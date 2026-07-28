import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/features/food_chat/domain/chat_input_models.dart';
import 'package:keyspace/features/food_chat/domain/unified_chat_models.dart';
import 'package:keyspace/features/food_chat/domain/unified_chat_response_parser.dart';

import '../../helpers/fakes.dart';

void main() {
  const parser = UnifiedChatResponseParser();

  group('UnifiedChatResponseParser', () {
    test('mempertahankan regresi parsing nutrisi', () {
      final food = validFoodResponse();
      final draft = parser.parse({
        ..._base(domain: 'nutrition'),
        'items': food['items'],
        'nutrition_summary': food['summary'],
      }, context: _context());

      expect(draft.detectedDomain, ChatDomain.nutrition);
      expect(draft.nutrition?.items.single.name, 'Nasi goreng');
      expect(draft.nutrition?.totalCaloriesKcal, 640);
      expect(draft.financialItems, isEmpty);
    });

    test(
      'menerima multiple expense dan nominal Indonesia yang dinormalisasi',
      () {
        final draft = parser.parse({
          ..._base(domain: 'expense'),
          'items': [
            _financeItem(name: 'Makan', amount: 150000, date: '2026-07-21'),
            _financeItem(
              name: 'Belanja bulanan',
              amount: 1500000,
              category: 'Belanja',
            ),
            _financeItem(name: 'Servis', amount: 2000000, category: 'Jasa'),
          ],
        }, context: _context());

        expect(draft.financialItems.map((item) => item.amount), [
          150000,
          1500000,
          2000000,
        ]);
        expect(
          draft.financialItems.first.transactionDate,
          DateTime(2026, 7, 21),
        );
        expect(draft.financialItems.first.categoryName, 'Makan');
        expect(draft.financialItems.last.categoryName, 'Lainnya');
      },
    );

    test('menerima income IDR dengan kategori income aktif', () {
      final draft = parser.parse({
        ..._base(domain: 'income'),
        'items': [
          _financeItem(name: 'Gaji Juli', amount: 8000000, category: 'Gaji'),
        ],
      }, context: _context(mode: ChatInputMode.income));

      expect(draft.detectedDomain, ChatDomain.income);
      expect(draft.financialItems.single.categoryId, 'income-salary');
    });

    test('mode eksplisit menolak domain yang berbeda', () {
      expect(
        () => parser.parse({
          ..._base(domain: 'income'),
          'items': [_financeItem(name: 'Gaji', amount: 1000000)],
        }, context: _context(mode: ChatInputMode.expense)),
        throwsA(
          isA<UnifiedChatResponseException>().having(
            (error) => error.reason,
            'reason',
            'explicit_mode_mismatch',
          ),
        ),
      );
    });

    test('unknown wajib menghasilkan clarification', () {
      final draft = parser.parse({
        ..._base(domain: 'unknown'),
        'requires_clarification': true,
        'clarification_question': 'Ini pengeluaran atau pemasukan?',
      }, context: _context());

      expect(draft.detectedDomain, ChatDomain.unknown);
      expect(draft.requiresClarification, isTrue);
      expect(draft.clarificationQuestion, isNotEmpty);
    });

    for (final invalid in <String, Map<String, dynamic>>{
      'nominal pecahan': _financeItem(name: 'Kopi', amount: 12500.5),
      'currency bukan IDR': _financeItem(
        name: 'Kopi',
        amount: 12500,
        currency: 'USD',
      ),
      'tanggal tidak valid': _financeItem(
        name: 'Kopi',
        amount: 12500,
        date: '2026-02-30',
      ),
    }.entries) {
      test('menolak ${invalid.key}', () {
        expect(
          () => parser.parse({
            ..._base(domain: 'expense'),
            'items': [invalid.value],
          }, context: _context()),
          throwsA(isA<UnifiedChatResponseException>()),
        );
      });
    }

    test('kategori asing jatuh ke Lainnya dengan tipe yang sama', () {
      final draft = parser.parse({
        ..._base(domain: 'expense'),
        'items': [
          _financeItem(
            name: 'Keperluan unik',
            amount: 10000,
            category: 'Kategori Rekaan',
          ),
        ],
      }, context: _context());

      expect(draft.financialItems.single.categoryId, 'expense-other');
    });

    test('menolak reimburse yang ditentukan provider', () {
      expect(
        () => parser.parse({
          ..._base(domain: 'expense'),
          'items': [
            {
              ..._financeItem(name: 'Talangan kantor', amount: 50000),
              'is_reimburse': true,
            },
          ],
        }, context: _context()),
        throwsA(
          isA<UnifiedChatResponseException>().having(
            (error) => error.reason,
            'reason',
            'reimburse_provider_forbidden',
          ),
        ),
      );
    });

    test('confidence di luar rentang ditolak', () {
      expect(
        () => parser.parse({
          ..._base(domain: 'expense'),
          'confidence': 1.1,
          'items': [_financeItem(name: 'Kopi', amount: 12000)],
        }, context: _context()),
        throwsA(isA<UnifiedChatResponseException>()),
      );
    });
  });
}

ChatParseContext _context({ChatInputMode mode = ChatInputMode.automatic}) =>
    ChatParseContext(
      mode: mode,
      localDate: DateTime(2026, 7, 22),
      timezone: 'Asia/Jakarta',
      currencyCode: 'IDR',
      activeCategories: const [
        GeminiCategoryContext(
          id: 'expense-food',
          name: 'Makan',
          type: ChatDomain.expense,
        ),
        GeminiCategoryContext(
          id: 'expense-shopping',
          name: 'Belanja',
          type: ChatDomain.expense,
        ),
        GeminiCategoryContext(
          id: 'expense-other',
          name: 'Lainnya',
          type: ChatDomain.expense,
        ),
        GeminiCategoryContext(
          id: 'income-salary',
          name: 'Gaji',
          type: ChatDomain.income,
        ),
        GeminiCategoryContext(
          id: 'income-other',
          name: 'Lainnya',
          type: ChatDomain.income,
        ),
      ],
    );

Map<String, dynamic> _base({required String domain}) => {
  'detected_domain': domain,
  'confidence': 0.9,
  'requires_clarification': false,
  'clarification_question': null,
  'items': <Object>[],
  'nutrition_summary': null,
};

Map<String, dynamic> _financeItem({
  required String name,
  required num amount,
  String currency = 'IDR',
  String date = '2026-07-22',
  String category = 'Makan',
}) => {
  'name': name,
  'amount': amount,
  'currency': currency,
  'transaction_date': date,
  'category': category,
};
