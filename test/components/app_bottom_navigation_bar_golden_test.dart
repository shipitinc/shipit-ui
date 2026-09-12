import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shipit_ui/src/components/app_bottom_navigation_bar.dart';
import 'package:shipit_ui/src/theme/app_theme.dart';

const _items = [
  AppBottomNavigationItem(
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
    label: 'Home',
  ),
  AppBottomNavigationItem(
    icon: Icons.group_outlined,
    selectedIcon: Icons.group,
    label: 'Household',
  ),
  AppBottomNavigationItem(
    icon: Icons.event_outlined,
    selectedIcon: Icons.event,
    label: 'Programs',
  ),
  AppBottomNavigationItem(
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings,
    label: 'Settings',
  ),
];

Widget _bar({required int selectedIndex, ThemeData? theme}) {
  return MaterialApp(
    theme: theme,
    home: Scaffold(
      body: const SizedBox.expand(),
      bottomNavigationBar: AppBottomNavigationBar(
        items: _items,
        selectedIndex: selectedIndex,
        onDestinationSelected: (_) {},
      ),
    ),
  );
}

void main() {
  group('Golden tests - AppBottomNavigationBar', () {
    testGoldens('default bar', (tester) async {
      await tester.pumpWidgetBuilder(
        _bar(selectedIndex: 1),
        surfaceSize: const Size(360, 96),
      );
      await expectLater(
        find.byType(AppBottomNavigationBar),
        matchesGoldenFile('bottom_navigation_bar.png'),
      );
    });

    testGoldens('default bar (dark)', (tester) async {
      await tester.pumpWidgetBuilder(
        _bar(selectedIndex: 1, theme: shipitDarkTheme()),
        surfaceSize: const Size(360, 96),
      );
      await expectLater(
        find.byType(AppBottomNavigationBar),
        matchesGoldenFile('bottom_navigation_bar_dark.png'),
      );
    });
  });
}
