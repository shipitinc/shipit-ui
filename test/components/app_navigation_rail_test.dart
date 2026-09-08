import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/components/app_navigation_rail.dart';
import 'package:shipit_ui/src/components/app_tooltip.dart';

const _items = [
  AppNavigationRailItem(
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
    label: 'Home',
    semanticLabel: Key('nav_home'),
  ),
  AppNavigationRailItem(
    icon: Icons.group_outlined,
    selectedIcon: Icons.group,
    label: 'Household',
    semanticLabel: Key('nav_household'),
  ),
  AppNavigationRailItem(
    icon: Icons.event_outlined,
    selectedIcon: Icons.event,
    label: 'Programs',
    semanticLabel: Key('nav_programs'),
  ),
];

Widget _harness({
  required int selectedIndex,
  required ValueChanged<int> onSelected,
  bool? extended,
  Size size = const Size(1200, 800),
}) {
  return MediaQuery(
    data: MediaQueryData(size: size),
    child: MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            AppNavigationRail(
              items: _items,
              selectedIndex: selectedIndex,
              onDestinationSelected: onSelected,
              extended: extended,
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    ),
  );
}

void main() {
  group('AppNavigationRail', () {
    testWidgets('renders all destinations with labels when extended', (
      tester,
    ) async {
      await tester.pumpWidget(
        _harness(selectedIndex: 0, onSelected: (_) {}, extended: true),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Household'), findsOneWidget);
      expect(find.text('Programs'), findsOneWidget);
      expect(find.byType(AppTooltip), findsNothing);

      final rail = tester.getSize(find.byType(AppNavigationRail));
      expect(rail.width, AppNavigationRail.extendedWidth);
    });

    testWidgets('collapses to icons with tooltips when not extended', (
      tester,
    ) async {
      await tester.pumpWidget(
        _harness(selectedIndex: 0, onSelected: (_) {}, extended: false),
      );

      expect(find.text('Home'), findsNothing);
      expect(find.byType(AppTooltip), findsNWidgets(3));
      expect(find.byTooltip('Household'), findsOneWidget);

      final rail = tester.getSize(find.byType(AppNavigationRail));
      expect(rail.width, AppNavigationRail.collapsedWidth);
    });

    testWidgets('auto-collapses below desktop breakpoint', (tester) async {
      await tester.pumpWidget(
        _harness(
          selectedIndex: 0,
          onSelected: (_) {},
          size: const Size(800, 600),
        ),
      );

      final rail = tester.getSize(find.byType(AppNavigationRail));
      expect(rail.width, AppNavigationRail.collapsedWidth);
    });

    testWidgets('invokes onDestinationSelected with tapped index', (
      tester,
    ) async {
      int? tapped;
      await tester.pumpWidget(
        _harness(
          selectedIndex: 0,
          onSelected: (i) => tapped = i,
          extended: true,
        ),
      );

      await tester.tap(find.byKey(const Key('nav_programs')));
      expect(tapped, 2);
    });

    testWidgets('uses selectedIcon for the active destination', (tester) async {
      await tester.pumpWidget(
        _harness(selectedIndex: 1, onSelected: (_) {}, extended: true),
      );

      expect(find.byIcon(Icons.group), findsOneWidget);
      expect(find.byIcon(Icons.home_outlined), findsOneWidget);
      expect(find.byIcon(Icons.home), findsNothing);
    });

    testWidgets('exposes selected semantics', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _harness(selectedIndex: 1, onSelected: (_) {}, extended: true),
      );

      expect(
        tester.getSemantics(find.byKey(const Key('nav_household'))),
        isSemantics(isSelected: true, isButton: true, label: 'Household'),
      );
      expect(
        tester.getSemantics(find.byKey(const Key('nav_home'))),
        isSemantics(isSelected: false, isButton: true, label: 'Home'),
      );

      handle.dispose();
    });
  });
}
