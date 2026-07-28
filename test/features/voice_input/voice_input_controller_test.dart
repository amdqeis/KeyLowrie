import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/features/voice_input/application/voice_input_controller.dart';
import 'package:keyspace/features/voice_input/domain/voice_input_models.dart';

import '../../helpers/fakes.dart';

void main() {
  group('VoiceInputController', () {
    test('partial dan final result mengubah draft tanpa auto action', () async {
      final service = FakeSpeechRecognitionService();
      final results = <({String text, bool isFinal})>[];
      final controller = VoiceInputController(
        service: service,
        onTranscript: (text, isFinal) {
          results.add((text: text, isFinal: isFinal));
        },
      );
      addTearDown(controller.dispose);

      await controller.start();
      await controller.start();
      service.emitResult('makan seratus', isFinal: false);
      service.emitResult('makan seratus ribu', isFinal: true);
      service.emitStatus('done');

      expect(service.startCalls, 1, reason: 'hanya satu sesi boleh aktif');
      expect(results, [
        (text: 'makan seratus', isFinal: false),
        (text: 'makan seratus ribu', isFinal: true),
      ]);
      expect(controller.status, VoiceInputStatus.completed);
      expect(controller.transcript, 'makan seratus ribu');
    });

    test('permission denied dan permanently denied dibedakan', () async {
      for (final permission in [
        VoicePermissionState.denied,
        VoicePermissionState.permanentlyDenied,
      ]) {
        final service = FakeSpeechRecognitionService()
          ..permission = VoicePermissionState.denied
          ..requestedPermission = permission;
        final controller = VoiceInputController(
          service: service,
          onTranscript: (_, _) {},
        );

        await controller.start();

        expect(controller.status, VoiceInputStatus.denied);
        expect(
          controller.permissionPermanentlyDenied,
          permission == VoicePermissionState.permanentlyDenied,
        );
        expect(service.startCalls, 0);
        controller.dispose();
      }
    });

    test('service unavailable gagal tanpa memulai listener', () async {
      final service = FakeSpeechRecognitionService()..available = false;
      final controller = VoiceInputController(
        service: service,
        onTranscript: (_, _) {},
      );

      await controller.start();

      expect(controller.status, VoiceInputStatus.failed);
      expect(controller.failure, VoiceRecognitionFailure.unavailable);
      expect(service.startCalls, 0);
      controller.dispose();
    });

    for (final failure in [
      VoiceRecognitionFailure.noSpeech,
      VoiceRecognitionFailure.timeout,
      VoiceRecognitionFailure.network,
    ]) {
      test('${failure.name} dipetakan ke failed', () async {
        final service = FakeSpeechRecognitionService();
        final controller = VoiceInputController(
          service: service,
          onTranscript: (_, _) {},
        );
        await controller.start();

        service.emitError(failure);

        expect(controller.status, VoiceInputStatus.failed);
        expect(controller.failure, failure);
        controller.dispose();
      });
    }

    test('silence, stop, cancel, dan dispose membersihkan sesi', () async {
      final silence = FakeSpeechRecognitionService();
      final silenceController = VoiceInputController(
        service: silence,
        onTranscript: (_, _) {},
      );
      await silenceController.start();
      silence.emitStatus('done');
      expect(silenceController.status, VoiceInputStatus.failed);
      expect(silenceController.failure, VoiceRecognitionFailure.noSpeech);
      silenceController.dispose();

      final service = FakeSpeechRecognitionService();
      final controller = VoiceInputController(
        service: service,
        onTranscript: (_, _) {},
      );
      await controller.start();
      service.emitResult('draft parsial');
      await controller.stop();
      expect(service.stopCalls, 1);
      expect(controller.status, VoiceInputStatus.completed);

      await controller.start();
      await controller.cancel();
      expect(service.cancelCalls, 1);
      expect(controller.status, VoiceInputStatus.idle);

      await controller.start();
      controller.dispose();
      await Future<void>.delayed(Duration.zero);
      expect(service.cancelCalls, 2);
    });
  });
}
