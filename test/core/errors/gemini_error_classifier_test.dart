import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/core/errors/gemini_failure.dart';
import 'package:keyspace/core/security/secret_store.dart';

void main() {
  const classifier = GeminiErrorClassifier();

  group('GeminiErrorClassifier', () {
    final statusCases = <int, GeminiFailureCategory>{
      400: GeminiFailureCategory.requestInvalid,
      401: GeminiFailureCategory.invalidKey,
      403: GeminiFailureCategory.permission,
      429: GeminiFailureCategory.rateLimit,
      500: GeminiFailureCategory.transientServer,
      502: GeminiFailureCategory.transientServer,
      503: GeminiFailureCategory.transientServer,
      504: GeminiFailureCategory.timeout,
    };

    for (final entry in statusCases.entries) {
      test('maps HTTP ${entry.key} to ${entry.value.name}', () {
        final failure = classifier.classify(_dioStatus(entry.key));
        expect(failure.category, entry.value);
        expect(failure.httpStatus, entry.key);
      });
    }

    test('reads Retry-After without exposing response body', () {
      final failure = classifier.classify(
        _dioStatus(
          429,
          headers: {
            'retry-after': ['12'],
          },
        ),
      );
      expect(failure.retryAfter, const Duration(seconds: 12));
    });

    test('maps Dio timeout, connection, cancellation, and safety', () {
      expect(
        classifier.classify(_dioType(DioExceptionType.receiveTimeout)).category,
        GeminiFailureCategory.timeout,
      );
      expect(
        classifier
            .classify(_dioType(DioExceptionType.connectionError))
            .category,
        GeminiFailureCategory.offline,
      );
      expect(
        classifier.classify(_dioType(DioExceptionType.cancel)).category,
        GeminiFailureCategory.cancelled,
      );
      expect(
        classifier
            .classify(_dioStatus(400, data: {'finishReason': 'SAFETY'}))
            .category,
        GeminiFailureCategory.safetyBlock,
      );
    });

    test('maps schema and secure-store failures to sanitized categories', () {
      const schema = GeminiFailure(
        category: GeminiFailureCategory.schemaMismatch,
      );
      expect(classifier.classify(schema), same(schema));
      expect(
        classifier
            .classify(const SecretStoreException(SecretStoreError.unavailable))
            .category,
        GeminiFailureCategory.secretUnavailable,
      );
    });
  });
}

DioException _dioStatus(
  int status, {
  Object? data,
  Map<String, List<String>>? headers,
}) {
  final request = RequestOptions(path: '/redacted');
  return DioException.badResponse(
    statusCode: status,
    requestOptions: request,
    response: Response<Object?>(
      requestOptions: request,
      statusCode: status,
      data: data,
      headers: Headers.fromMap(headers ?? const {}),
    ),
  );
}

DioException _dioType(DioExceptionType type) => DioException(
  requestOptions: RequestOptions(path: '/redacted'),
  type: type,
);
