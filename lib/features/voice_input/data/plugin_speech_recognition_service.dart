import 'package:flutter/foundation.dart';
import 'package:keyspace/features/voice_input/domain/speech_recognition_service.dart';
import 'package:keyspace/features/voice_input/domain/voice_input_models.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class PluginSpeechRecognitionService implements SpeechRecognitionService {
  PluginSpeechRecognitionService({SpeechToText? speech})
    : _speech = speech ?? SpeechToText();

  final SpeechToText _speech;
  VoiceResultCallback? _resultCallback;
  VoiceErrorCallback? _errorCallback;
  VoiceStatusCallback? _statusCallback;
  bool _initialized = false;
  bool _disposed = false;

  @override
  Future<bool> isAvailable() => _initialize();

  @override
  Future<VoicePermissionState> permissionStatus() async {
    final statuses = await Future.wait(_permissions.map((item) => item.status));
    return _combineStatuses(statuses);
  }

  @override
  Future<VoicePermissionState> requestPermission() async {
    final statuses = await _permissions.request();
    return _combineStatuses(statuses.values);
  }

  @override
  Future<void> openSettings() async {
    await openAppSettings();
  }

  @override
  Future<void> start({
    required VoiceResultCallback onResult,
    required VoiceErrorCallback onError,
    required VoiceStatusCallback onStatus,
  }) async {
    if (_disposed) throw StateError('speech_service_disposed');
    _resultCallback = onResult;
    _errorCallback = onError;
    _statusCallback = onStatus;
    if (!await _initialize()) {
      onError(const VoiceRecognitionError(VoiceRecognitionFailure.unavailable));
      return;
    }
    await _speech.listen(
      onResult: _handleResult,
      listenOptions: SpeechListenOptions(
        cancelOnError: true,
        partialResults: true,
        onDevice: false,
        listenMode: ListenMode.dictation,
        pauseFor: const Duration(seconds: 5),
        listenFor: const Duration(minutes: 1),
        localeId: 'id_ID',
      ),
    );
  }

  @override
  Future<void> stop() => _speech.stop();

  @override
  Future<void> cancel() => _speech.cancel();

  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    await _speech.cancel();
    _resultCallback = null;
    _errorCallback = null;
    _statusCallback = null;
  }

  List<Permission> get _permissions {
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      return const [Permission.microphone, Permission.speech];
    }
    return const [Permission.microphone];
  }

  Future<bool> _initialize() async {
    if (_disposed) return false;
    if (_initialized) return true;
    _initialized = await _speech.initialize(
      onError: _handleError,
      onStatus: (status) => _statusCallback?.call(status),
      debugLogging: false,
    );
    return _initialized;
  }

  void _handleResult(SpeechRecognitionResult result) {
    _resultCallback?.call(result.recognizedWords, result.finalResult);
  }

  void _handleError(SpeechRecognitionError error) {
    _errorCallback?.call(VoiceRecognitionError(_mapError(error.errorMsg)));
  }

  VoicePermissionState _combineStatuses(Iterable<PermissionStatus> statuses) {
    if (statuses.any(
      (status) => status.isPermanentlyDenied || status.isRestricted,
    )) {
      return VoicePermissionState.permanentlyDenied;
    }
    if (statuses.every((status) => status.isGranted)) {
      return VoicePermissionState.granted;
    }
    return VoicePermissionState.denied;
  }

  VoiceRecognitionFailure _mapError(String value) {
    if (value.contains('permission')) {
      return VoiceRecognitionFailure.permissionDenied;
    }
    if (value.contains('network_timeout')) {
      return VoiceRecognitionFailure.timeout;
    }
    if (value.contains('network')) return VoiceRecognitionFailure.network;
    if (value.contains('speech_timeout')) {
      return VoiceRecognitionFailure.timeout;
    }
    if (value.contains('no_match')) return VoiceRecognitionFailure.noSpeech;
    return VoiceRecognitionFailure.unknown;
  }
}
