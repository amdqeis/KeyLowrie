enum VoiceInputStatus {
  idle,
  requestingPermission,
  listening,
  processing,
  completed,
  denied,
  failed,
}

enum VoicePermissionState { granted, denied, permanentlyDenied }

enum VoiceRecognitionFailure {
  noSpeech,
  timeout,
  network,
  unavailable,
  permissionDenied,
  unknown,
}

class VoiceRecognitionError {
  const VoiceRecognitionError(this.failure);

  final VoiceRecognitionFailure failure;
}
