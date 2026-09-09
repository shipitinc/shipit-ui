import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shipit_ui/src/components/app_search_field.dart';
import 'package:shipit_ui/src/theme/app_theme.dart';

const _filters = [
  AppSearchFilter(label: 'All', selected: true),
  AppSearchFilter(label: 'Active', icon: Icons.bolt),
  AppSearchFilter(label: 'Archived', icon: Icons.archive_outlined),
];

Widget _field({
  TextEditingController? controller,
  FocusNode? focusNode,
  List<AppSearchFilter> filters = const [],
  List<String> recentSearches = const [],
  ThemeData? theme,
}) {
  return MaterialApp(
    theme: theme,
    home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Align(
          alignment: Alignment.topCenter,
          child: AppSearchField(
            hint: 'Search members',
            controller: controller,
            focusNode: focusNode,
            filters: filters,
            recentSearches: recentSearches,
            onFilterToggled: (_) {},
          ),
        ),
      ),
    ),
  );
}

void main() {
  group('Golden tests - AppSearchField', () {
    testGoldens('default with filters', (tester) async {
      await tester.pumpWidgetBuilder(
        _field(filters: _filters),
        surfaceSize: const Size(400, 260),
      );
      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('search_field_default.png'),
      );
    });

    testGoldens('default with filters (dark)', (tester) async {
      await tester.pumpWidgetBuilder(
        _field(filters: _filters, theme: shipitDarkTheme()),
        surfaceSize: const Size(400, 260),
      );
      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('search_field_default_dark.png'),
      );
    });

    testGoldens('active with text and clear button', (tester) async {
      final controller = TextEditingController(text: 'Ann');
      addTearDown(controller.dispose);
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpWidgetBuilder(
        _field(controller: controller, focusNode: focusNode, filters: _filters),
        surfaceSize: const Size(400, 260),
      );
      focusNode.requestFocus();
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('search_field_active.png'),
      );
    });

    testGoldens('focused with recent searches', (tester) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpWidgetBuilder(
        _field(
          focusNode: focusNode,
          recentSearches: const ['Ann Smith', 'Bob Jones', 'Carol White'],
        ),
        surfaceSize: const Size(400, 260),
      );
      focusNode.requestFocus();
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('search_field_recents.png'),
      );
    });
  });
}
