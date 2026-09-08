import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/components/app_filter_chip.dart';
import 'package:shipit_ui/src/components/app_search_field.dart';

const _filters = [
  AppSearchFilter(label: 'All', selected: true),
  AppSearchFilter(label: 'Active', icon: Icons.bolt),
  AppSearchFilter(label: 'Archived', icon: Icons.archive_outlined),
];

Widget _harness({
  TextEditingController? controller,
  FocusNode? focusNode,
  ValueChanged<String>? onChanged,
  ValueChanged<String>? onSubmitted,
  VoidCallback? onClear,
  List<AppSearchFilter> filters = const [],
  ValueChanged<int>? onFilterToggled,
  List<String> recentSearches = const [],
  ValueChanged<String>? onRecentSelected,
}) {
  return MaterialApp(
    home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AppSearchField(
          hint: 'Search members',
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          onClear: onClear,
          filters: filters,
          onFilterToggled: onFilterToggled,
          recentSearches: recentSearches,
          onRecentSelected: onRecentSelected,
          semanticLabel: const Key('search_field'),
        ),
      ),
    ),
  );
}

void main() {
  group('AppSearchField', () {
    testWidgets('typing calls onChanged', (tester) async {
      String? value;
      await tester.pumpWidget(_harness(onChanged: (v) => value = v));
      await tester.enterText(find.byType(TextField), 'ann');
      expect(value, 'ann');
    });

    testWidgets('clear button hidden when empty and shown with text', (
      tester,
    ) async {
      await tester.pumpWidget(_harness());
      expect(find.byKey(const Key('search_field_clear')), findsNothing);

      await tester.enterText(find.byType(TextField), 'ann');
      await tester.pump();
      expect(find.byKey(const Key('search_field_clear')), findsOneWidget);
    });

    testWidgets('tapping clear empties field and fires callbacks', (
      tester,
    ) async {
      final controller = TextEditingController(text: 'ann');
      addTearDown(controller.dispose);
      String? changed;
      var cleared = 0;
      await tester.pumpWidget(
        _harness(
          controller: controller,
          onChanged: (v) => changed = v,
          onClear: () => cleared++,
        ),
      );

      await tester.tap(find.byKey(const Key('search_field_clear')));
      await tester.pump();

      expect(controller.text, isEmpty);
      expect(changed, '');
      expect(cleared, 1);
      expect(find.byKey(const Key('search_field_clear')), findsNothing);
    });

    testWidgets('onSubmitted fires on search action', (tester) async {
      String? submitted;
      await tester.pumpWidget(_harness(onSubmitted: (v) => submitted = v));
      await tester.enterText(find.byType(TextField), 'ann');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      expect(submitted, 'ann');
    });

    testWidgets('renders filter chips and fires onFilterToggled', (
      tester,
    ) async {
      int? toggled;
      await tester.pumpWidget(
        _harness(filters: _filters, onFilterToggled: (i) => toggled = i),
      );

      expect(find.byType(AppFilterChip), findsNWidgets(3));
      expect(find.text('Archived'), findsOneWidget);

      await tester.tap(find.byKey(const Key('search_filter_2')));
      expect(toggled, 2);
    });

    testWidgets('shows recents on focus with empty text and hides on typing', (
      tester,
    ) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      await tester.pumpWidget(
        _harness(focusNode: focusNode, recentSearches: const ['Ann', 'Bob']),
      );
      expect(find.byKey(const Key('search_recent_0')), findsNothing);

      focusNode.requestFocus();
      await tester.pump();
      expect(find.byKey(const Key('search_recent_0')), findsOneWidget);
      expect(find.byKey(const Key('search_recent_1')), findsOneWidget);
      expect(find.byIcon(Icons.history), findsNWidgets(2));

      await tester.enterText(find.byType(TextField), 'a');
      await tester.pump();
      expect(find.byKey(const Key('search_recent_0')), findsNothing);
    });

    testWidgets('caps recents at five', (tester) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      await tester.pumpWidget(
        _harness(
          focusNode: focusNode,
          recentSearches: List.generate(8, (i) => 'Recent $i'),
        ),
      );
      focusNode.requestFocus();
      await tester.pump();
      expect(find.byIcon(Icons.history), findsNWidgets(5));
    });

    testWidgets('tapping a recent fills the field and fires callbacks', (
      tester,
    ) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      final controller = TextEditingController();
      addTearDown(controller.dispose);
      String? changed;
      String? recent;
      await tester.pumpWidget(
        _harness(
          controller: controller,
          focusNode: focusNode,
          recentSearches: const ['Ann', 'Bob'],
          onChanged: (v) => changed = v,
          onRecentSelected: (v) => recent = v,
        ),
      );
      focusNode.requestFocus();
      await tester.pump();

      await tester.tap(find.byKey(const Key('search_recent_1')));
      await tester.pump();

      expect(controller.text, 'Bob');
      expect(changed, 'Bob');
      expect(recent, 'Bob');
      expect(find.byKey(const Key('search_recent_0')), findsNothing);
    });

    testWidgets('exposes text field semantics with hint label', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(_harness());
      expect(
        tester.getSemantics(find.byKey(const Key('search_field'))),
        isSemantics(isTextField: true, label: 'Search members'),
      );
      handle.dispose();
    });
  });
}
