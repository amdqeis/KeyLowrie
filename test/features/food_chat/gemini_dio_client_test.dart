import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/features/food_chat/data/gemini_dio_client.dart';
import 'package:keyspace/features/food_chat/domain/chat_input_models.dart';
import 'package:keyspace/features/food_chat/domain/unified_chat_models.dart';

void main() {
  test('Gemini response schema uses REST-compatible nullable fields', () {
    void validateSchema(Object? value) {
      if (value is Map<String, dynamic>) {
        expect(
          value['type'],
          isNot(isA<List<Object?>>()),
          reason: 'Gemini REST schema type must be a scalar value.',
        );
        for (final child in value.values) {
          validateSchema(child);
        }
      } else if (value is List<Object?>) {
        for (final child in value) {
          validateSchema(child);
        }
      }
    }

    validateSchema(geminiFoodResponseSchema);

    final items =
        geminiFoodResponseSchema['properties'] as Map<String, dynamic>;
    final itemArray = items['items'] as Map<String, dynamic>;
    final itemSchema = itemArray['items'] as Map<String, dynamic>;
    final itemProperties = itemSchema['properties'] as Map<String, dynamic>;
    expect(itemProperties['quantity'], {'type': 'number', 'nullable': true});
  });

  test('unified schema tetap scalar dan tidak memuat reimburse', () {
    void validateSchema(Object? value) {
      if (value is Map<String, dynamic>) {
        expect(value['type'], isNot(isA<List<Object?>>()));
        for (final child in value.values) {
          validateSchema(child);
        }
      } else if (value is List<Object?>) {
        for (final child in value) {
          validateSchema(child);
        }
      }
    }

    validateSchema(geminiUnifiedChatResponseSchema);
    expect(
      jsonEncode(geminiUnifiedChatResponseSchema),
      isNot(contains('reimburse')),
    );
  });

  test('request unified hanya membawa konteks minimum yang diizinkan', () {
    final request = buildUnifiedGeminiRequest(
      input: 'kemarin makan 150 ribu, bonus 2 jt',
      context: ChatParseContext(
        mode: ChatInputMode.automatic,
        localDate: DateTime(2026, 7, 22),
        timezone: 'Asia/Jakarta',
        currencyCode: 'IDR',
        activeCategories: const [
          GeminiCategoryContext(
            id: 'private-database-id',
            name: 'Makan',
            type: ChatDomain.expense,
          ),
        ],
      ),
      repairAttempt: false,
    );
    final contents = request['contents'] as List<Object?>;
    final content = contents.single as Map<String, dynamic>;
    final parts = content['parts'] as List<Object?>;
    final part = parts.single as Map<String, dynamic>;
    final payload = jsonDecode(part['text']! as String) as Map<String, dynamic>;

    expect(payload.keys, {
      'input',
      'mode',
      'local_date',
      'timezone',
      'currency',
      'active_categories',
      'current_datetime',
      'week_starts_on',
      'default_event_duration_minutes',
      'active_schedule_categories',
    });
    expect(payload['local_date'], '2026-07-22');
    expect(payload['timezone'], 'Asia/Jakarta');
    expect(payload['currency'], 'IDR');
    expect(jsonEncode(payload), isNot(contains('private-database-id')));
    expect(jsonEncode(payload), isNot(contains('api_key')));

    final instruction = jsonEncode(request['systemInstruction']);
    expect(instruction, contains('150 ribu'));
    expect(instruction, contains('1,5 juta'));
    expect(instruction, contains('2 jt'));
    expect(instruction, contains('tanggal relatif'));
    expect(instruction, contains('Jangan menghasilkan is_reimburse'));
  });
}
