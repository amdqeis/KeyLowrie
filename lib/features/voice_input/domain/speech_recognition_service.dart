import 'package:keyspace/features/voice_input/domain/voice_input_models.dart';

typedef VoiceResultCallback = void Function(String transcript, bool isFinal);
typedef VoiceErrorCallback = void Function(VoiceRecognitionError error);
typedef VoiceStatusCallback = void Function(String status);

abstract interface class SpeechRecognitionService {
  Future<bool> isAvailable();

  Future<VoicePermissionState> permissionStatus();

  Future<VoicePermissionState> requestPermission();

  Future<void> openSettings();

  Future<void> start({
    required VoiceResultCallback onResult,
    required VoiceErrorCallback onError,
    required VoiceStatusCallback onStatus,
  });

  Future<void> stop();

  Future<void> cancel();

  Future<void> dispose();
}
