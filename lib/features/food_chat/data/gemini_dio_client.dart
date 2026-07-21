import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:keyspace/app/provider_config.dart';
import 'package:keyspace/core/errors/gemini_failure.dart';
import 'package:keyspace/core/network/request_cancellation.dart';
import 'package:keyspace/features/food_chat/domain/gemini_contracts.dart';

class GeminiDioClient implements GeminiClient {
  GeminiDioClient({Dio? dio, GeminiErrorClassifier? classifier})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: ProviderConfig.endpoint,
              connectTimeout: ProviderConfig.connectTimeout,
              receiveTimeout: ProviderConfig.receiveTimeout,
              contentType: Headers.jsonContentType,
            ),
          ),
      _classifier = classifier ?? const GeminiErrorClassifier();

  final Dio _dio;
  final GeminiErrorClassifier _classifier;

  @override
  Future<GeminiCallResult> parseFood({
    required String secret,
    required String input,
    required bool repairAttempt,
    CancellationSignal? cancellation,
  }) async {
    final stopwatch = Stopwatch()..start();
    final cancelToken = CancelToken();
    cancellation?.onCancel(() => cancelToken.cancel('cancelled_by_user'));
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/${ProviderConfig.apiVersion}/models/${ProviderConfig.model}:generateContent',
        data: _request(input, repairAttempt: repairAttempt),
        options: Options(headers: {'x-goog-api-key': secret}),
        cancelToken: cancelToken,
      );
      final envelope = response.data;
      final parsed = _extractStructuredData(envelope);
      stopwatch.stop();
      final usage = envelope?['usageMetadata'];
      return GeminiCallSuccess(
        data: parsed,
        latency: stopwatch.elapsed,
        promptTokens: _intValue(usage, 'promptTokenCount'),
        outputTokens: _intValue(usage, 'candidatesTokenCount'),
      );
    } on _SafetyBlocked {
      stopwatch.stop();
      return GeminiCallFailure(
        failure: const GeminiFailure(
          category: GeminiFailureCategory.safetyBlock,
        ),
        latency: stopwatch.elapsed,
      );
    } on FormatException {
      stopwatch.stop();
      return GeminiCallFailure(
        failure: const GeminiFailure(
          category: GeminiFailureCategory.schemaMismatch,
        ),
        latency: stopwatch.elapsed,
      );
    } on Object catch (error) {
      stopwatch.stop();
      return GeminiCallFailure(
        failure: _classifier.classify(error),
        latency: stopwatch.elapsed,
      );
    }
  }

  Map<String, dynamic> _extractStructuredData(Map<String, dynamic>? envelope) {
    final candidates = envelope?['candidates'];
    if (candidates is! List || candidates.isEmpty) {
      final feedback = envelope?['promptFeedback'].toString().toUpperCase();
      if (feedback?.contains('SAFETY') ?? false) throw const _SafetyBlocked();
      throw const FormatException('candidates_invalid');
    }
    final candidate = candidates.first;
    if (candidate is! Map<String, dynamic>) {
      throw const FormatException('candidate_invalid');
    }
    if (candidate['finishReason'].toString().toUpperCase().contains('SAFETY')) {
      throw const _SafetyBlocked();
    }
    final content = candidate['content'];
    final parts = content is Map<String, dynamic> ? content['parts'] : null;
    final firstPart = parts is List && parts.isNotEmpty ? parts.first : null;
    final text = firstPart is Map<String, dynamic> ? firstPart['text'] : null;
    if (text is! String) throw const FormatException('text_invalid');
    final decoded = jsonDecode(text);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('structured_data_invalid');
    }
    return decoded;
  }

  int? _intValue(Object? source, String key) {
    if (source is! Map<String, dynamic>) return null;
    final value = source[key];
    return value is num ? value.toInt() : null;
  }

  Map<String, dynamic> _request(String input, {required bool repairAttempt}) {
    final repairInstruction = repairAttempt
        ? ' Respons sebelumnya tidak valid. Perbaiki dan kembalikan JSON saja.'
        : '';
    return {
      'systemInstruction': {
        'parts': [
          {
            'text':
                'Ekstrak makanan dan estimasi nutrisi. Tandai asumsi; '
                'jangan menyatakan estimasi sebagai nilai pasti.$repairInstruction',
          },
        ],
      },
      'contents': [
        {
          'role': 'user',
          'parts': [
            {'text': 'Locale=id-ID; unit=metric; input=$input'},
          ],
        },
      ],
      'generationConfig': {
        'responseMimeType': 'application/json',
        'responseSchema': _responseSchema,
      },
    };
  }
}

const _responseSchema = <String, dynamic>{
  'type': 'object',
  'required': ['items', 'summary'],
  'properties': {
    'items': {
      'type': 'array',
      'minItems': 1,
      'items': {
        'type': 'object',
        'required': ['name', 'calories_kcal'],
        'properties': {
          'name': {'type': 'string'},
          'quantity': {
            'type': ['number', 'null'],
          },
          'unit': {
            'type': ['string', 'null'],
          },
          'portion_text': {
            'type': ['string', 'null'],
          },
          'calories_kcal': {'type': 'number', 'minimum': 0},
          'protein_g': {
            'type': ['number', 'null'],
            'minimum': 0,
          },
          'carbs_g': {
            'type': ['number', 'null'],
            'minimum': 0,
          },
          'fat_g': {
            'type': ['number', 'null'],
            'minimum': 0,
          },
          'fiber_g': {
            'type': ['number', 'null'],
            'minimum': 0,
          },
          'sodium_mg': {
            'type': ['number', 'null'],
            'minimum': 0,
          },
          'confidence': {
            'type': ['number', 'null'],
            'minimum': 0,
            'maximum': 1,
          },
          'assumption_note': {
            'type': ['string', 'null'],
          },
        },
      },
    },
    'summary': {
      'type': 'object',
      'required': ['total_calories_kcal', 'needs_user_review'],
      'properties': {
        'total_calories_kcal': {'type': 'number', 'minimum': 0},
        'total_protein_g': {
          'type': ['number', 'null'],
          'minimum': 0,
        },
        'total_carbs_g': {
          'type': ['number', 'null'],
          'minimum': 0,
        },
        'total_fat_g': {
          'type': ['number', 'null'],
          'minimum': 0,
        },
        'needs_user_review': {'type': 'boolean'},
        'general_note': {
          'type': ['string', 'null'],
        },
      },
    },
  },
};

class _SafetyBlocked implements Exception {
  const _SafetyBlocked();
}
