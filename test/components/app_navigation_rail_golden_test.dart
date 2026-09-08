import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shipit_ui/src/components/app_navigation_rail.dart';

const _items = [
  AppNavigationRailItem(
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
    label: 'Home',
  ),
  AppNavigationRailItem(
    icon: Icons.group_outlined,
    selectedIcon: Icons.group,
    label: 'Household',
  ),
  AppNavigationRailItem(
    icon: Icons.event_outlined,
    selectedIcon: Icons.event,
    label: 'Programs',
  ),
];

Widget _rail({required bool extended}) {
  return MaterialApp(
    home: Scaffold(
      body: Row(
        children: [
          AppNavigationRail(
            items: _items,
            selectedIndex: 1,
            onDestinationSelected: (_) {},
            extended: extended,
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    ),
  );
}

void main() {
  group('Golden tests - AppNavigationRail', () {
    testGoldens('extended rail', (tester) async {
      await tester.pumpWidgetBuilder(
        _rail(extended: true),
        surfaceSize: const Size(320, 320),
      );
      await expectLater(
        find.byType(AppNavigationRail),
        matchesGoldenFile('navigation_rail_extended.png'),
      );
    });

    testGoldens('collapsed rail', (tester) async {
      await tester.pumpWidgetBuilder(
        _rail(extended: false),
        surfaceSize: const Size(160, 320),
      );
      await expectLater(
        find.byType(AppNavigationRail),
        matchesGoldenFile('navigation_rail_collapsed.png'),
      );
    });
  });
}
