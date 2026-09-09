import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_icon_button.dart';
import 'package:shipit_ui/src/theme/app_theme.dart';

void main() {
  group('Golden tests - AppIconButton', () {
    testGoldens('icon button', (tester) async {
      await tester.pumpWidgetBuilder(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: AppIconButton(
                icon: Icons.visibility_outlined,
                tooltip: 'Show password',
                onPressed: () {},
              ),
            ),
          ),
        ),
      );
      await expectLater(
        find.byType(AppIconButton),
        matchesGoldenFile('icon_button.png'),
      );
    });

    testGoldens('icon button (dark)', (tester) async {
      await tester.pumpWidgetBuilder(
        MaterialApp(
          theme: shipitDarkTheme(),
          home: Scaffold(
            body: Center(
              child: AppIconButton(
                icon: Icons.visibility_outlined,
                tooltip: 'Show password',
                onPressed: () {},
              ),
            ),
          ),
        ),
      );
      await expectLater(
        find.byType(AppIconButton),
        matchesGoldenFile('icon_button_dark.png'),
      );
    });
  });
}
