import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/components/app_data_table.dart';
import 'package:shipit_ui/src/components/app_shimmer.dart';
import 'package:shipit_ui/src/components/app_state_view.dart';

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

List<AppDataColumn<_Person>> _columns({bool sortableName = true}) => [
  AppDataColumn<_Person>.text(
    label: 'Name',
    value: (p) => p.name,
    comparator: sortableName ? (a, b) => a.name.compareTo(b.name) : null,
  ),
  AppDataColumn<_Person>.text(label: 'Role', value: (p) => p.role),
  AppDataColumn<_Person>.text(
    label: 'Age',
    value: (p) => '${p.age}',
    numeric: true,
    comparator: (a, b) => a.age.compareTo(b.age),
    width: 96,
  ),
];

Widget _harness(Widget child) {
  return MaterialApp(
    home: Scaffold(
      body: Center(child: SizedBox(width: 640, child: child)),
    ),
  );
}

List<String> _firstColumn(WidgetTester tester) {
  final rows = find.byWidgetPredicate(
    (w) =>
        w.key is ValueKey<String> &&
        (w.key as ValueKey<String>).value.startsWith('table_row_'),
  );
  return tester.widgetList(rows).map((row) {
    final text = find.descendant(
      of: find.byWidget(row),
      matching: find.byType(Text),
    );
    return (tester.widget<Text>(text.first)).data!;
  }).toList();
}

void main() {
  group('AppDataTable', () {
    testWidgets('renders headers and cells', (tester) async {
      await tester.pumpWidget(
        _harness(AppDataTable<_Person>(columns: _columns(), rows: _people)),
      );

      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Role'), findsOneWidget);
      expect(find.text('Age'), findsOneWidget);
      expect(find.text('Ada'), findsOneWidget);
      expect(find.text('Engineer'), findsNWidgets(2));
      expect(find.text('52'), findsOneWidget);
      expect(find.byKey(const Key('table_row_3')), findsOneWidget);
      expect(_firstColumn(tester), ['Grace', 'Ada', 'Linus', 'Mary']);
    });

    testWidgets('sort toggling reorders rows and calls onSort', (tester) async {
      final calls = <(int, bool)>[];
      await tester.pumpWidget(
        _harness(
          AppDataTable<_Person>(
            columns: _columns(),
            rows: _people,
            onSort: (i, asc) => calls.add((i, asc)),
          ),
        ),
      );

      expect(find.byIcon(Icons.unfold_more), findsNWidgets(2));

      await tester.tap(find.byKey(const Key('table_sort_0')));
      await tester.pump();
      expect(_firstColumn(tester), ['Ada', 'Grace', 'Linus', 'Mary']);
      expect(find.byIcon(Icons.arrow_upward), findsOneWidget);
      expect(calls.last, (0, true));

      await tester.tap(find.byKey(const Key('table_sort_0')));
      await tester.pump();
      expect(_firstColumn(tester), ['Mary', 'Linus', 'Grace', 'Ada']);
      expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
      expect(calls.last, (0, false));

      await tester.tap(find.byKey(const Key('table_sort_2')));
      await tester.pump();
      expect(_firstColumn(tester), ['Linus', 'Ada', 'Grace', 'Mary']);
      expect(calls.last, (2, true));
      expect(find.byIcon(Icons.unfold_more), findsOneWidget);
    });

    testWidgets('applies initial sort', (tester) async {
      await tester.pumpWidget(
        _harness(
          AppDataTable<_Person>(
            columns: _columns(),
            rows: _people,
            sortColumnIndex: 2,
            sortAscending: false,
          ),
        ),
      );
      expect(_firstColumn(tester), ['Mary', 'Grace', 'Ada', 'Linus']);
      expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
    });

    testWidgets('non-sortable header has no sort icon and ignores taps', (
      tester,
    ) async {
      var sorted = false;
      await tester.pumpWidget(
        _harness(
          AppDataTable<_Person>(
            columns: _columns(sortableName: false),
            rows: _people,
            onSort: (_, _) => sorted = true,
          ),
        ),
      );

      expect(find.byKey(const Key('table_sort_0')), findsNothing);
      expect(find.byKey(const Key('table_sort_1')), findsNothing);
      expect(find.byIcon(Icons.unfold_more), findsOneWidget);

      await tester.tap(find.text('Name'));
      await tester.pump();
      expect(sorted, isFalse);
      expect(_firstColumn(tester), ['Grace', 'Ada', 'Linus', 'Mary']);
    });

    testWidgets('rowFilter hides rows', (tester) async {
      await tester.pumpWidget(
        _harness(
          AppDataTable<_Person>(
            columns: _columns(),
            rows: _people,
            rowFilter: (p) => p.role == 'Engineer',
          ),
        ),
      );

      expect(_firstColumn(tester), ['Ada', 'Linus']);
      expect(find.text('Grace'), findsNothing);
    });

    testWidgets('paginates client-side and fires onPageChanged', (
      tester,
    ) async {
      final rows = List.generate(25, (i) => _Person('P$i', 'Role', i));
      final pages = <int>[];
      await tester.pumpWidget(
        _harness(
          AppDataTable<_Person>(
            columns: _columns(),
            rows: rows,
            onPageChanged: pages.add,
          ),
        ),
      );

      expect(find.text('1–10 of 25'), findsOneWidget);
      expect(find.text('P0'), findsOneWidget);
      expect(find.text('P10'), findsNothing);
      expect(
        tester
            .widget<IconButton>(find.byKey(const Key('table_prev')))
            .onPressed,
        isNull,
      );

      await tester.tap(find.byKey(const Key('table_next')));
      await tester.pump();
      expect(find.text('11–20 of 25'), findsOneWidget);
      expect(find.text('P10'), findsOneWidget);
      expect(pages, [1]);

      await tester.tap(find.byKey(const Key('table_next')));
      await tester.pump();
      expect(find.text('21–25 of 25'), findsOneWidget);
      expect(pages, [1, 2]);
      expect(
        tester
            .widget<IconButton>(find.byKey(const Key('table_next')))
            .onPressed,
        isNull,
      );

      await tester.tap(find.byKey(const Key('table_next')));
      await tester.pump();
      expect(pages, [1, 2]);

      await tester.tap(find.byKey(const Key('table_prev')));
      await tester.pump();
      expect(find.text('11–20 of 25'), findsOneWidget);
      expect(pages, [1, 2, 1]);
    });

    testWidgets('footer hidden when rows fit on one page', (tester) async {
      await tester.pumpWidget(
        _harness(AppDataTable<_Person>(columns: _columns(), rows: _people)),
      );
      expect(find.byKey(const Key('table_next')), findsNothing);
      expect(find.byKey(const Key('table_prev')), findsNothing);
    });

    testWidgets('clamps page when rows shrink', (tester) async {
      final rows = List.generate(25, (i) => _Person('P$i', 'Role', i));
      Widget build(List<_Person> data) =>
          _harness(AppDataTable<_Person>(columns: _columns(), rows: data));

      await tester.pumpWidget(build(rows));
      await tester.tap(find.byKey(const Key('table_next')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('table_next')));
      await tester.pump();
      expect(find.text('21–25 of 25'), findsOneWidget);

      await tester.pumpWidget(build(rows.take(12).toList()));
      expect(find.text('11–12 of 12'), findsOneWidget);

      await tester.pumpWidget(build(rows.take(3).toList()));
      expect(find.text('1–3 of 3'), findsOneWidget);
    });

    testWidgets('onRowTap receives the row', (tester) async {
      _Person? tapped;
      await tester.pumpWidget(
        _harness(
          AppDataTable<_Person>(
            columns: _columns(),
            rows: _people,
            onRowTap: (p) => tapped = p,
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('table_row_1')));
      expect(tapped, same(_people[1]));
    });

    testWidgets('isLoading shows shimmer placeholders', (tester) async {
      await tester.pumpWidget(
        _harness(
          AppDataTable<_Person>(
            columns: _columns(),
            rows: _people,
            isLoading: true,
          ),
        ),
      );

      expect(find.byType(AppShimmer), findsNWidgets(15));
      expect(find.text('Ada'), findsNothing);
      expect(find.byKey(const Key('table_next')), findsNothing);
    });

    testWidgets('empty rows shows AppStateView with emptyTitle', (
      tester,
    ) async {
      await tester.pumpWidget(
        _harness(
          AppDataTable<_Person>(
            columns: _columns(),
            rows: const [],
            emptyTitle: 'Nothing here',
            emptyDescription: 'Try a different filter',
          ),
        ),
      );

      expect(find.byType(AppStateView), findsOneWidget);
      expect(find.text('Nothing here'), findsOneWidget);
      expect(find.text('Try a different filter'), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
    });

    testWidgets('exposes semantics', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _harness(
          AppDataTable<_Person>(
            columns: _columns(),
            rows: _people,
            onRowTap: (_) {},
            semanticLabel: const Key('people_table'),
          ),
        ),
      );

      expect(
        tester.getSemantics(find.byKey(const Key('people_table'))),
        isSemantics(label: 'Data table'),
      );
      expect(
        tester.getSemantics(find.text('Role')),
        isSemantics(isHeader: true, label: 'Role'),
      );
      expect(
        tester.getSemantics(find.byKey(const Key('table_row_0'))),
        isSemantics(isButton: true),
      );

      handle.dispose();
    });
  });
}
