import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:keyspace/app/provider_config.dart';
import 'package:keyspace/core/errors/gemini_failure.dart';
import 'package:keyspace/core/network/request_cancellation.dart';
import 'package:keyspace/features/food_chat/domain/gemini_contracts.dart';
import 'package:keyspace/features/food_chat/domain/unified_chat_models.dart';

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

  @override
  Future<GeminiCallResult> parseChat({
    required String secret,
    required String input,
    required ChatParseContext context,
    required bool repairAttempt,
    CancellationSignal? cancellation,
  }) async {
    final stopwatch = Stopwatch()..start();
    final cancelToken = CancelToken();
    cancellation?.onCancel(() => cancelToken.cancel('cancelled_by_user'));
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/${ProviderConfig.apiVersion}/models/${ProviderConfig.model}:generateContent',
        data: buildUnifiedGeminiRequest(
          input: input,
          context: context,
          repairAttempt: repairAttempt,
        ),
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
                'Ekstrak makanan dan estimasi nutrisi dari input Bahasa Indonesia. '
                'Input singkat berupa nama item dan jumlah (contoh: "Udang 200 gram", '
                '"Nasi 1 porsi") tetap valid — anggap pengguna melaporkan makanan yang '
                'baru dikonsumsi. Jangan tolak input hanya karena tidak ada kata kerja '
                '("makan", "habis") atau penanda waktu. '
                'Tandai asumsi di assumption_note; '
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
        'responseSchema': geminiFoodResponseSchema,
      },
    };
  }
}

const geminiFoodResponseSchema = <String, dynamic>{
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
          'quantity': {'type': 'number', 'nullable': true},
          'unit': {'type': 'string', 'nullable': true},
          'portion_text': {'type': 'string', 'nullable': true},
          'calories_kcal': {'type': 'number', 'minimum': 0},
          'protein_g': {'type': 'number', 'nullable': true, 'minimum': 0},
          'carbs_g': {'type': 'number', 'nullable': true, 'minimum': 0},
          'fat_g': {'type': 'number', 'nullable': true, 'minimum': 0},
          'fiber_g': {'type': 'number', 'nullable': true, 'minimum': 0},
          'sodium_mg': {'type': 'number', 'nullable': true, 'minimum': 0},
          'confidence': {
            'type': 'number',
            'nullable': true,
            'minimum': 0,
            'maximum': 1,
          },
          'assumption_note': {'type': 'string', 'nullable': true},
        },
      },
    },
    'summary': {
      'type': 'object',
      'required': ['total_calories_kcal', 'needs_user_review'],
      'properties': {
        'total_calories_kcal': {'type': 'number', 'minimum': 0},
        'total_protein_g': {'type': 'number', 'nullable': true, 'minimum': 0},
        'total_carbs_g': {'type': 'number', 'nullable': true, 'minimum': 0},
        'total_fat_g': {'type': 'number', 'nullable': true, 'minimum': 0},
        'needs_user_review': {'type': 'boolean'},
        'general_note': {'type': 'string', 'nullable': true},
      },
    },
  },
};

Map<String, dynamic> buildUnifiedGeminiRequest({
  required String input,
  required ChatParseContext context,
  required bool repairAttempt,
}) {
  final local = context.localDate;
  final localDate =
      '${local.year.toString().padLeft(4, '0')}-'
      '${local.month.toString().padLeft(2, '0')}-'
      '${local.day.toString().padLeft(2, '0')}';
  final categories = context.activeCategories
      .map((category) => {'name': category.name, 'type': category.type.name})
      .toList(growable: false);
  final repairInstruction = repairAttempt
      ? ' Respons sebelumnya tidak valid. Perbaiki seluruh field dan kembalikan JSON saja.'
      : '';
  final modeInstruction = context.mode.name == 'automatic'
      ? 'Deteksi domain nutrition, expense, income, atau unknown.'
      : 'Domain dikunci ke ${context.mode.name}; jangan klasifikasikan ke domain lain.';
  return {
    'systemInstruction': {
      'parts': [
        {
          'text':
              'Kamu mengekstrak catatan nutrisi dan keuangan Bahasa Indonesia. '
              '$modeInstruction '
              'Input singkat berupa \'nama item + jumlah\' (tanpa kata kerja '
              'seperti \'makan\' atau \'beli\', dan tanpa penanda waktu seperti '
              '\'hari ini\') tetap VALID dan harus diproses. '
              'Aturan default untuk input singkat: '
              '(1) Jika ada nama makanan + satuan berat/volume/porsi → domain nutrition, '
              'gunakan local_date sebagai transaction_date. '
              '(2) Jika ada nama item + nominal uang (angka, atau format \'X ribu/juta\') '
              '→ domain expense, gunakan local_date sebagai transaction_date. '
              '(3) Hanya set requires_clarification=true jika domain BENAR-BENAR tidak '
              'dapat ditentukan dari konteks (contoh: \'5000\' saja tanpa nama item). '
              'Normalisasi 150 ribu → 150000, 1,5 juta → 1500000, 2 jt → 2000000. '
              'Ubah tanggal relatif seperti kemarin berdasarkan local_date. '
              'Jangan mengarang nominal uang. '
              'Kategori keuangan wajib dari active_categories; jika tidak cocok '
              'gunakan Lainnya. Jangan menghasilkan is_reimburse; nilai itu hanya '
              'berasal dari pengguna. Jangan menyatakan estimasi nutrisi sebagai '
              'nilai pasti.$repairInstruction',
        },
      ],
    },
    'contents': [
      {
        'role': 'user',
        'parts': [
          {
            'text': jsonEncode({
              'input': input,
              'mode': context.mode.name,
              'local_date': localDate,
              'timezone': context.timezone,
              'currency': context.currencyCode,
              'active_categories': categories,
            }),
          },
        ],
      },
    ],
    'generationConfig': {
      'responseMimeType': 'application/json',
      'responseSchema': geminiUnifiedChatResponseSchema,
    },
  };
}

const geminiUnifiedChatResponseSchema = <String, dynamic>{
  'type': 'object',
  'required': [
    'detected_domain',
    'confidence',
    'requires_clarification',
    'clarification_question',
    'items',
  ],
  'properties': {
    'detected_domain': {
      'type': 'string',
      'enum': ['nutrition', 'expense', 'income', 'unknown'],
    },
    'confidence': {'type': 'number', 'minimum': 0, 'maximum': 1},
    'requires_clarification': {'type': 'boolean'},
    'clarification_question': {'type': 'string', 'nullable': true},
    'items': {
      'type': 'array',
      'items': {
        'type': 'object',
        'required': ['name'],
        'properties': {
          'name': {'type': 'string'},
          'amount': {'type': 'integer', 'nullable': true, 'minimum': 1},
          'currency': {'type': 'string', 'nullable': true},
          'transaction_date': {'type': 'string', 'nullable': true},
          'category': {'type': 'string', 'nullable': true},
          'quantity': {'type': 'number', 'nullable': true},
          'unit': {'type': 'string', 'nullable': true},
          'portion_text': {'type': 'string', 'nullable': true},
          'calories_kcal': {'type': 'number', 'nullable': true, 'minimum': 0},
          'protein_g': {'type': 'number', 'nullable': true, 'minimum': 0},
          'carbs_g': {'type': 'number', 'nullable': true, 'minimum': 0},
          'fat_g': {'type': 'number', 'nullable': true, 'minimum': 0},
          'fiber_g': {'type': 'number', 'nullable': true, 'minimum': 0},
          'sodium_mg': {'type': 'number', 'nullable': true, 'minimum': 0},
          'confidence': {
            'type': 'number',
            'nullable': true,
            'minimum': 0,
            'maximum': 1,
          },
          'assumption_note': {'type': 'string', 'nullable': true},
        },
      },
    },
    'nutrition_summary': {
      'type': 'object',
      'nullable': true,
      'required': ['total_calories_kcal', 'needs_user_review'],
      'properties': {
        'total_calories_kcal': {'type': 'number', 'minimum': 0},
        'total_protein_g': {'type': 'number', 'nullable': true, 'minimum': 0},
        'total_carbs_g': {'type': 'number', 'nullable': true, 'minimum': 0},
        'total_fat_g': {'type': 'number', 'nullable': true, 'minimum': 0},
        'needs_user_review': {'type': 'boolean'},
        'general_note': {'type': 'string', 'nullable': true},
      },
    },
  },
};

class _SafetyBlocked implements Exception {
  const _SafetyBlocked();
}
