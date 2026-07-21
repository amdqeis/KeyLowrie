import 'package:dio/dio.dart';
import 'package:keyspace/core/security/secret_store.dart';

enum GeminiFailureCategory {
  invalidKey,
  permission,
  rateLimit,
  transientServer,
  timeout,
  offline,
  requestInvalid,
  safetyBlock,
  schemaMismatch,
  secretUnavailable,
  cancelled,
  unknown,
}

class GeminiFailure {
  const GeminiFailure({
    required this.category,
    this.httpStatus,
    this.retryAfter,
  });

  final GeminiFailureCategory category;
  final int? httpStatus;
  final Duration? retryAfter;
}

class GeminiErrorClassifier {
  const GeminiErrorClassifier();

  GeminiFailure classify(Object error) {
    if (error is GeminiFailure) return error;
    if (error is SecretStoreException) {
      return const GeminiFailure(
        category: GeminiFailureCategory.secretUnavailable,
      );
    }
    if (error is DioException) return _classifyDio(error);
    return const GeminiFailure(category: GeminiFailureCategory.unknown);
  }

  GeminiFailure _classifyDio(DioException error) {
    if (error.type == DioExceptionType.cancel) {
      return const GeminiFailure(category: GeminiFailureCategory.cancelled);
    }
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return const GeminiFailure(category: GeminiFailureCategory.timeout);
    }
    if (error.type == DioExceptionType.connectionError) {
      return const GeminiFailure(category: GeminiFailureCategory.offline);
    }

    final status = error.response?.statusCode;
    final body = error.response?.data;
    final statusText = _statusText(body);
    if (statusText.contains('SAFETY') || statusText.contains('BLOCKED')) {
      return GeminiFailure(
        category: GeminiFailureCategory.safetyBlock,
        httpStatus: status,
      );
    }
    if (status == 401) {
      return GeminiFailure(
        category: GeminiFailureCategory.invalidKey,
        httpStatus: status,
      );
    }
    if (status == 403) {
      return GeminiFailure(
        category: GeminiFailureCategory.permission,
        httpStatus: status,
      );
    }
    if (status == 429) {
      return GeminiFailure(
        category: GeminiFailureCategory.rateLimit,
        httpStatus: status,
        retryAfter: _retryAfter(error.response?.headers.value('retry-after')),
      );
    }
    if (status == 408 || status == 499 || status == 504) {
      return GeminiFailure(
        category: GeminiFailureCategory.timeout,
        httpStatus: status,
      );
    }
    if (status != null && status >= 500) {
      return GeminiFailure(
        category: GeminiFailureCategory.transientServer,
        httpStatus: status,
      );
    }
    if (status == 400 || status == 404 || status == 422) {
      return GeminiFailure(
        category: GeminiFailureCategory.requestInvalid,
        httpStatus: status,
      );
    }
    return GeminiFailure(
      category: GeminiFailureCategory.unknown,
      httpStatus: status,
    );
  }

  String _statusText(Object? body) => body.toString().toUpperCase();

  Duration? _retryAfter(String? value) {
    final seconds = int.tryParse(value ?? '');
    return seconds == null ? null : Duration(seconds: seconds);
  }
}
