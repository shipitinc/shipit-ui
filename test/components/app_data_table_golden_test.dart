import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shipit_ui/src/components/app_data_table.dart';
import 'package:shipit_ui/src/theme/app_theme.dart';

class _Person {
  final String name;
  final String role;
  final int age;
  const _Person(this.name, this.role, this.age);
}

const _people = [
  _Person('Grace', 'Designer', 41),
  _Person('Ada', 'Engineer', 36),
  _Person('Linus', 'Engineer', 29),
  _Person('Mary', 'Manager', 52),
];

final _columns = [
  AppDataColumn<_Person>.text(
    label: 'Name',
    value: (p) => p.name,
    comparator: (a, b) => a.name.compareTo(b.name),
    flex: 2,
  ),
  AppDataColumn<_Person>.text(label: 'Role', value: (p) => p.role, flex: 2),
  AppDataColumn<_Person>.text(
    label: 'Age',
    value: (p) => '${p.age}',
    numeric: true,
    comparator: (a, b) => a.age.compareTo(b.age),
    width: 96,
  ),
];

Widget _surface(Widget table, {ThemeData? theme}) {
  return MaterialApp(
    theme: theme,
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(width: 608, child: table),
        ),
      ),
    ),
  );
}

void main() {
  group('Golden tests - AppDataTable', () {
    testGoldens('default sorted table', (tester) async {
      await tester.pumpWidgetBuilder(
        _surface(
          AppDataTable<_Person>(
            columns: _columns,
            rows: _people,
            sortColumnIndex: 0,
          ),
        ),
        surfaceSize: const Size(640, 400),
      );
      await expectLater(
        find.byType(AppDataTable<_Person>),
        matchesGoldenFile('data_table_default.png'),
      );
    });

    testGoldens('default sorted table (dark)', (tester) async {
      await tester.pumpWidgetBuilder(
        _surface(
          AppDataTable<_Person>(
            columns: _columns,
            rows: _people,
            sortColumnIndex: 0,
          ),
          theme: shipitDarkTheme(),
        ),
        surfaceSize: const Size(640, 400),
      );
      await expectLater(
        find.byType(AppDataTable<_Person>),
        matchesGoldenFile('data_table_default_dark.png'),
      );
    });

    testGoldens('paginated table', (tester) async {
      final rows = List.generate(
        12,
        (i) => _Person(
          'Person ${i + 1}',
          i.isEven ? 'Engineer' : 'Designer',
          20 + i,
        ),
      );
      await tester.pumpWidgetBuilder(
        _surface(
          AppDataTable<_Person>(columns: _columns, rows: rows, rowsPerPage: 5),
        ),
        surfaceSize: const Size(640, 400),
      );
      await expectLater(
        find.byType(AppDataTable<_Person>),
        matchesGoldenFile('data_table_paginated.png'),
      );
    });

    testGoldens('empty table', (tester) async {
      await tester.pumpWidgetBuilder(
        _surface(
          AppDataTable<_Person>(
            columns: _columns,
            rows: const [],
            emptyDescription: 'Adjust your filters and try again.',
          ),
        ),
        surfaceSize: const Size(640, 400),
      );
      await expectLater(
        find.byType(AppDataTable<_Person>),
        matchesGoldenFile('data_table_empty.png'),
      );
    });

    testGoldens('loading table', (tester) async {
      await tester.pumpWidgetBuilder(
        _surface(
          AppDataTable<_Person>(
            columns: _columns,
            rows: const [],
            isLoading: true,
          ),
        ),
        surfaceSize: const Size(640, 400),
      );
      await expectLater(
        find.byType(AppDataTable<_Person>),
        matchesGoldenFile('data_table_loading.png'),
      );
    });
  });
}
