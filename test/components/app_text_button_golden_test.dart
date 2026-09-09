import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_text_button.dart';
import 'package:shipit_ui/src/theme/app_theme.dart';

void main() {
  group('Golden tests - AppTextButton', () {
    testGoldens('text button', (tester) async {
      await tester.pumpWidgetBuilder(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: AppTextButton(label: 'Forgot password?', onPressed: () {}),
            ),
          ),
        ),
      );
      await expectLater(
        find.byType(AppTextButton),
        matchesGoldenFile('text_button.png'),
      );
    });

    testGoldens('text button (dark)', (tester) async {
      await tester.pumpWidgetBuilder(
        MaterialApp(
          theme: shipitDarkTheme(),
          home: Scaffold(
            body: Center(
              child: AppTextButton(label: 'Forgot password?', onPressed: () {}),
            ),
          ),
        ),
      );
      await expectLater(
        find.byType(AppTextButton),
        matchesGoldenFile('text_button_dark.png'),
      );
    });
  });
}
