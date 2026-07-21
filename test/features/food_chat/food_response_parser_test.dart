import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/features/food_chat/domain/food_response_parser.dart';

void main() {
  const parser = FoodResponseParser();

  group('FoodResponseParser', () {
    test('parses corpus response, sanitizes text, and recalculates totals', () {
      final fixture =
          jsonDecode(
                File(
                  'test/fixtures/indonesian_food_corpus.json',
                ).readAsStringSync(),
              )
              as Map<String, dynamic>;
      final corpus = fixture['inputs'] as List<dynamic>;
      final response = fixture['valid_response'] as Map<String, dynamic>;

      expect(corpus, hasLength(12));
      final draft = parser.parse(response);
      expect(draft.items, hasLength(2));
      expect(draft.totalCaloriesKcal, 640);
      expect(draft.providerTotalDifferenceKcal, 10);
      expect(draft.totalCarbsG, 102);
      expect(draft.items.first.name, 'Nasi goreng');
    });

    test('accepts nullable optional nutrition values', () {
      final draft = parser.parse({
        'items': [
          {
            'name': 'Air putih',
            'calories_kcal': 0,
            'protein_g': null,
            'confidence': null,
          },
        ],
        'summary': {'total_calories_kcal': 0, 'needs_user_review': false},
      });
      expect(draft.totalProteinG, isNull);
      expect(draft.needsUserReview, isFalse);
    });

    test('flags extreme values for review', () {
      final draft = parser.parse({
        'items': [
          {'name': 'Porsi ekstrem', 'calories_kcal': 6000},
        ],
        'summary': {'total_calories_kcal': 6000, 'needs_user_review': false},
      });
      expect(draft.needsUserReview, isTrue);
    });

    test(
      'rejects empty, malformed, negative, non-finite, and bad confidence',
      () {
        final invalid = <Map<String, dynamic>>[
          {'items': [], 'summary': <String, dynamic>{}},
          {
            'items': ['not-an-object'],
            'summary': {'total_calories_kcal': 0},
          },
          {
            'items': [
              {'name': 'Invalid', 'calories_kcal': -1},
            ],
            'summary': {'total_calories_kcal': 0},
          },
          {
            'items': [
              {'name': 'Invalid', 'calories_kcal': double.infinity},
            ],
            'summary': {'total_calories_kcal': 0},
          },
          {
            'items': [
              {'name': 'Invalid', 'calories_kcal': 10, 'confidence': 2},
            ],
            'summary': {'total_calories_kcal': 10},
          },
        ];
        for (final response in invalid) {
          expect(
            () => parser.parse(response),
            throwsA(isA<FoodResponseException>()),
          );
        }
      },
    );
  });
}
