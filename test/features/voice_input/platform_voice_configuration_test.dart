import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Android manifest memuat permission dan recognizer query', () {
    final manifest = File(
      'android/app/src/main/AndroidManifest.xml',
    ).readAsStringSync();

    expect(manifest, contains('android.permission.RECORD_AUDIO'));
    expect(manifest, contains('android.permission.INTERNET'));
    expect(manifest, contains('android.speech.RecognitionService'));
  });

  test('iOS Info.plist memuat kedua usage description', () {
    final plist = File('ios/Runner/Info.plist').readAsStringSync();

    expect(plist, contains('NSMicrophoneUsageDescription'));
    expect(plist, contains('NSSpeechRecognitionUsageDescription'));
  });
}
