import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:keyspace/features/voice_input/domain/speech_recognition_service.dart';
import 'package:keyspace/features/voice_input/domain/voice_input_models.dart';

typedef VoiceTranscriptListener =
    void Function(String transcript, bool isFinal);

class VoiceInputController extends ChangeNotifier {
  VoiceInputController({
    required SpeechRecognitionService service,
    required VoiceTranscriptListener onTranscript,
  }) : _service = service,
       _onTranscript = onTranscript;

  final SpeechRecognitionService _service;
  final VoiceTranscriptListener _onTranscript;

  VoiceInputStatus status = VoiceInputStatus.idle;
  VoiceRecognitionFailure? failure;
  String transcript = '';
  bool permissionPermanentlyDenied = false;
  bool _disposed = false;
  bool _cancelled = false;

  bool get isActive =>
      status == VoiceInputStatus.requestingPermission ||
      status == VoiceInputStatus.listening ||
      status == VoiceInputStatus.processing;

  Future<void> start() async {
    if (_disposed || isActive) return;
    _cancelled = false;
    failure = null;
    permissionPermanentlyDenied = false;
    transcript = '';
    _setStatus(VoiceInputStatus.requestingPermission);
    try {
      var permission = await _service.permissionStatus();
      if (_disposed || _cancelled) return;
      if (permission != VoicePermissionState.granted) {
        permission = await _service.requestPermission();
      }
      if (_disposed || _cancelled) return;
      if (permission != VoicePermissionState.granted) {
        permissionPermanentlyDenied =
            permission == VoicePermissionState.permanentlyDenied;
        failure = VoiceRecognitionFailure.permissionDenied;
        _setStatus(VoiceInputStatus.denied);
        return;
      }
      if (!await _service.isAvailable()) {
        if (_disposed || _cancelled) return;
        failure = VoiceRecognitionFailure.unavailable;
        _setStatus(VoiceInputStatus.failed);
        return;
      }
      if (_disposed || _cancelled) return;
      _setStatus(VoiceInputStatus.listening);
      await _service.start(
        onResult: _handleResult,
        onError: _handleError,
        onStatus: _handleServiceStatus,
      );
    } on Object {
      if (_disposed || _cancelled) return;
      failure = VoiceRecognitionFailure.unknown;
      _setStatus(VoiceInputStatus.failed);
    }
  }

  Future<void> stop() async {
    if (_disposed || !isActive) return;
    _setStatus(VoiceInputStatus.processing);
    try {
      await _service.stop();
      if (_disposed || _cancelled || status != VoiceInputStatus.processing) {
        return;
      }
      _finishSession();
    } on Object {
      if (_disposed) return;
      failure = VoiceRecognitionFailure.unknown;
      _setStatus(VoiceInputStatus.failed);
    }
  }

  Future<void> cancel() async {
    if (_disposed || !isActive) return;
    _cancelled = true;
    try {
      await _service.cancel();
    } on Object {
      // Cancellation is best-effort during lifecycle cleanup.
    }
    if (_disposed) return;
    _setStatus(VoiceInputStatus.idle);
  }

  Future<void> openSettings() => _service.openSettings();

  void _handleResult(String value, bool isFinal) {
    if (_disposed || _cancelled) return;
    final cleaned = value.trim();
    if (cleaned.isEmpty) {
      if (isFinal) {
        failure = VoiceRecognitionFailure.noSpeech;
        _setStatus(VoiceInputStatus.failed);
      }
      return;
    }
    transcript = cleaned;
    _onTranscript(cleaned, isFinal);
    _setStatus(
      isFinal ? VoiceInputStatus.processing : VoiceInputStatus.listening,
    );
  }

  void _handleError(VoiceRecognitionError error) {
    if (_disposed || _cancelled) return;
    failure = error.failure;
    permissionPermanentlyDenied =
        error.failure == VoiceRecognitionFailure.permissionDenied;
    _setStatus(
      error.failure == VoiceRecognitionFailure.permissionDenied
          ? VoiceInputStatus.denied
          : VoiceInputStatus.failed,
    );
  }

  void _handleServiceStatus(String value) {
    if (_disposed || _cancelled) return;
    switch (value) {
      case 'listening':
        _setStatus(VoiceInputStatus.listening);
      case 'done':
      case 'notListening':
        _finishSession();
    }
  }

  void _finishSession() {
    if (transcript.isEmpty) {
      failure = VoiceRecognitionFailure.noSpeech;
      _setStatus(VoiceInputStatus.failed);
    } else {
      _setStatus(VoiceInputStatus.completed);
    }
  }

  void _setStatus(VoiceInputStatus value) {
    if (_disposed) return;
    status = value;
    notifyListeners();
  }

  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    unawaited(_service.cancel());
    super.dispose();
  }
}
