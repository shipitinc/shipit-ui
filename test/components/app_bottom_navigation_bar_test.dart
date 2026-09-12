import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/components/app_bottom_navigation_bar.dart';

const _items = [
  AppBottomNavigationItem(
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
    label: 'Home',
    semanticLabel: Key('nav_home'),
  ),
  AppBottomNavigationItem(
    icon: Icons.group_outlined,
    selectedIcon: Icons.group,
    label: 'Household',
    semanticLabel: Key('nav_household'),
  ),
  AppBottomNavigationItem(
    icon: Icons.event_outlined,
    selectedIcon: Icons.event,
    label: 'Programs',
    semanticLabel: Key('nav_programs'),
  ),
];

Widget _harness({
  required int selectedIndex,
  required ValueChanged<int> onSelected,
  Size size = const Size(360, 640),
}) {
  return MediaQuery(
    data: MediaQueryData(size: size),
    child: MaterialApp(
      home: Scaffold(
        body: const SizedBox.expand(),
        bottomNavigationBar: AppBottomNavigationBar(
          items: _items,
          selectedIndex: selectedIndex,
          onDestinationSelected: onSelected,
        ),
      ),
    ),
  );
}

void main() {
  group('AppBottomNavigationBar', () {
    testWidgets('renders all destinations with labels', (tester) async {
      await tester.pumpWidget(_harness(selectedIndex: 0, onSelected: (_) {}));

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Household'), findsOneWidget);
      expect(find.text('Programs'), findsOneWidget);
      expect(find.byType(AppBottomNavigationBar), findsOneWidget);
    });

    testWidgets('invokes onDestinationSelected with tapped index', (
      tester,
    ) async {
      int? tapped;
      await tester.pumpWidget(
        _harness(selectedIndex: 0, onSelected: (i) => tapped = i),
      );

      await tester.tap(find.byKey(const Key('nav_programs')));
      expect(tapped, 2);
    });

    testWidgets('uses selectedIcon for the active destination', (tester) async {
      await tester.pumpWidget(_harness(selectedIndex: 1, onSelected: (_) {}));

      expect(find.byIcon(Icons.group), findsOneWidget);
      expect(find.byIcon(Icons.home_outlined), findsOneWidget);
      expect(find.byIcon(Icons.home), findsNothing);
    });

    testWidgets('highlights the active destination with nav.selected tokens', (
      tester,
    ) async {
      await tester.pumpWidget(_harness(selectedIndex: 1, onSelected: (_) {}));

      final highlighted = tester
          .widget<AnimatedContainer>(
            find.descendant(
              of: find.byKey(const Key('nav_household')),
              matching: find.byType(AnimatedContainer),
            ),
          )
          .decoration;

      final notHighlighted = tester
          .widget<AnimatedContainer>(
            find.descendant(
              of: find.byKey(const Key('nav_home')),
              matching: find.byType(AnimatedContainer),
            ),
          )
          .decoration;

      expect(highlighted, isA<BoxDecoration>());
      expect((highlighted as BoxDecoration).color, isNot(Colors.transparent));
      expect(notHighlighted, isA<BoxDecoration>());
      expect((notHighlighted as BoxDecoration).color, Colors.transparent);
    });

    testWidgets('exposes 44px+ tap targets', (tester) async {
      await tester.pumpWidget(_harness(selectedIndex: 0, onSelected: (_) {}));

      final size = tester.getSize(find.byKey(const Key('nav_household')));
      expect(size.height, greaterThanOrEqualTo(44));

      final icon = tester.widget<Icon>(
        find.descendant(
          of: find.byKey(const Key('nav_household')),
          matching: find.byType(Icon),
        ),
      );
      expect(icon.size, 24);
    });

    testWidgets('exposes selected semantics', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(_harness(selectedIndex: 1, onSelected: (_) {}));

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

    testWidgets('asserts at least two items', (tester) async {
      AppBottomNavigationBar invalid() => AppBottomNavigationBar(
        items: const [AppBottomNavigationItem(icon: Icons.home, label: 'Home')],
        selectedIndex: 0,
        onDestinationSelected: (_) {},
      );
      expect(invalid, throwsA(isA<AssertionError>()));
    });
  });
}
