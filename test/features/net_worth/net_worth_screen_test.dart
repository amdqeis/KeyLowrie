import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keyspace/app/theme/keyspace_theme.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/net_worth/presentation/net_worth_screen.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';

void main() {
  testWidgets('empty state initializes zero without presenting a fake value', (
    tester,
  ) async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(database)],
        child: MaterialApp(
          theme: KeySpaceTheme.light,
          home: const NetWorthScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('NET WORTH BELUM DIATUR'), findsOneWidget);
    expect(find.text('Rp 0'), findsNothing);
    await tester.tap(find.text('ATUR SEKARANG'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, 'Nilai net worth awal'),
      '0',
    );
    await tester.pump();
    await tester.tap(find.text('SIMPAN'));
    await tester.pumpAndSettle();

    expect(find.text('Rp 0'), findsOneWidget);
    expect(
      await database.select(database.netWorthInitializations).get(),
      hasLength(1),
    );
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 10));
  });
}
