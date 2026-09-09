import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shipit_ui/src/components/app_confirm_dialog.dart';
import 'package:shipit_ui/src/theme/app_theme.dart';

Widget _host(Widget dialog, {ThemeData? theme}) {
  return MaterialApp(
    theme: theme,
    home: Scaffold(body: Center(child: dialog)),
  );
}

void main() {
  group('Golden tests - AppConfirmDialog', () {
    testGoldens('default confirm dialog', (tester) async {
      await tester.pumpWidgetBuilder(
        _host(
          const AppConfirmDialog(
            title: 'Save changes?',
            message: 'Your edits will be kept in this draft.',
          ),
        ),
        surfaceSize: const Size(480, 320),
      );
      await expectLater(
        find.byType(AppConfirmDialog),
        matchesGoldenFile('confirm_dialog_default.png'),
      );
    });

    testGoldens('default confirm dialog (dark)', (tester) async {
      await tester.pumpWidgetBuilder(
        _host(
          const AppConfirmDialog(
            title: 'Save changes?',
            message: 'Your edits will be kept in this draft.',
          ),
          theme: shipitDarkTheme(),
        ),
        surfaceSize: const Size(480, 320),
      );
      await expectLater(
        find.byType(AppConfirmDialog),
        matchesGoldenFile('confirm_dialog_default_dark.png'),
      );
    });

    testGoldens('destructive confirm dialog', (tester) async {
      await tester.pumpWidgetBuilder(
        _host(
          const AppConfirmDialog.destructive(
            title: 'Delete item?',
            message: 'This action cannot be undone.',
          ),
        ),
        surfaceSize: const Size(480, 320),
      );
      await expectLater(
        find.byType(AppConfirmDialog),
        matchesGoldenFile('confirm_dialog_destructive.png'),
      );
    });
  });
}
