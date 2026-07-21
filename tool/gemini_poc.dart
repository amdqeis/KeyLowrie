import 'dart:convert';
import 'dart:io';

import 'package:keyspace/features/food_chat/data/gemini_dio_client.dart';
import 'package:keyspace/features/food_chat/domain/food_response_parser.dart';
import 'package:keyspace/features/food_chat/domain/gemini_contracts.dart';

Future<void> main() async {
  if (!stdin.hasTerminal) {
    stderr.writeln('Runner harus dijalankan dari terminal interaktif.');
    exitCode = 64;
    return;
  }
  stdout.write(
    'Runner ini akan memakai kuota Gemini untuk corpus lokal. '
    'Ketik LANJUT untuk meneruskan: ',
  );
  if (stdin.readLineSync()?.trim() != 'LANJUT') {
    stdout.writeln('Dibatalkan.');
    return;
  }

  stdout.write('Masukkan API key Gemini (input disembunyikan): ');
  late final String secret;
  final previousEchoMode = stdin.echoMode;
  try {
    stdin.echoMode = false;
    secret = stdin.readLineSync()?.trim() ?? '';
  } finally {
    stdin.echoMode = previousEchoMode;
    stdout.writeln();
  }
  if (secret.isEmpty) {
    stderr.writeln('API key kosong; tidak ada request yang dikirim.');
    exitCode = 64;
    return;
  }

  final fixture =
      jsonDecode(
            File(
              'test/fixtures/indonesian_food_corpus.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  final inputs = (fixture['inputs'] as List<dynamic>).cast<String>();
  final client = GeminiDioClient();
  const parser = FoodResponseParser();
  var valid = 0;
  final failures = <String, int>{};

  for (final input in inputs) {
    final result = await client.parseFood(
      secret: secret,
      input: input,
      repairAttempt: false,
    );
    if (result is GeminiCallSuccess) {
      try {
        parser.parse(result.data);
        valid++;
      } on FoodResponseException {
        failures.update(
          'schemaMismatch',
          (count) => count + 1,
          ifAbsent: () => 1,
        );
      }
    } else if (result is GeminiCallFailure) {
      failures.update(
        result.failure.category.name,
        (count) => count + 1,
        ifAbsent: () => 1,
      );
    }
  }

  stdout.writeln(
    'Ringkasan tersanitasi: $valid/${inputs.length} response valid.',
  );
  if (failures.isNotEmpty) stdout.writeln('Kategori gagal: $failures');
}
