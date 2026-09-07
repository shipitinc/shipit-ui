import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_button.dart';
import 'package:shipit_ui/src/components/app_text_field.dart';
import 'package:shipit_ui/src/components/app_card.dart';
import 'package:shipit_ui/src/components/app_loading_state.dart';
import 'package:shipit_ui/src/components/app_empty_state.dart';
import 'package:shipit_ui/src/components/app_error_state.dart';

void main() {
  group('Golden tests - AppButton', () {
    testGoldens('primary button', (tester) async {
      await tester.pumpWidgetBuilder(
        MaterialApp(
          home: Scaffold(body: AppButton.primary(label: 'Primary')),
        ),
      );
      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('button_primary.png'),
      );
    });

    testGoldens('secondary button', (tester) async {
      await tester.pumpWidgetBuilder(
        MaterialApp(
          home: Scaffold(body: AppButton.secondary(label: 'Secondary')),
        ),
      );
      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('button_secondary.png'),
      );
    });

    testGoldens('destructive button', (tester) async {
      await tester.pumpWidgetBuilder(
        MaterialApp(
          home: Scaffold(body: AppButton.destructive(label: 'Delete')),
        ),
      );
      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('button_destructive.png'),
      );
    });

    testGoldens('disabled button', (tester) async {
      await tester.pumpWidgetBuilder(
        MaterialApp(
          home: Scaffold(
            body: AppButton.primary(label: 'Disabled', isDisabled: true),
          ),
        ),
      );
      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('button_disabled.png'),
      );
    });

    testGoldens('loading button', (tester) async {
      await tester.pumpWidgetBuilder(
        MaterialApp(
          home: Scaffold(
            body: AppButton.primary(label: 'Loading', isLoading: true),
          ),
        ),
      );
      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('button_loading.png'),
      );
    });
  });

  group('Golden tests - AppTextField', () {
    testGoldens('normal text field', (tester) async {
      await tester.pumpWidgetBuilder(
        MaterialApp(
          home: Scaffold(body: AppTextField.normal(label: 'Name')),
        ),
      );
      await expectLater(
        find.byType(AppTextField),
        matchesGoldenFile('textfield_normal.png'),
      );
    });

    testGoldens('error text field', (tester) async {
      await tester.pumpWidgetBuilder(
        MaterialApp(
          home: Scaffold(body: AppTextField.error(label: 'Email')),
        ),
      );
      await expectLater(
        find.byType(AppTextField),
        matchesGoldenFile('textfield_error.png'),
      );
    });

    testGoldens('disabled text field', (tester) async {
      await tester.pumpWidgetBuilder(
        MaterialApp(
          home: Scaffold(
            body: AppTextField.disabled(label: 'Status', value: 'Active'),
          ),
        ),
      );
      await expectLater(
        find.byType(AppTextField),
        matchesGoldenFile('textfield_disabled.png'),
      );
    });
  });

  group('Golden tests - States', () {
    testGoldens('loading state', (tester) async {
      await tester.pumpWidgetBuilder(
        const MaterialApp(
          home: Scaffold(body: AppLoadingState(message: 'Loading...')),
        ),
      );
      await expectLater(
        find.byType(AppLoadingState),
        matchesGoldenFile('loading_state.png'),
      );
    });

    testGoldens('empty state', (tester) async {
      await tester.pumpWidgetBuilder(
        const MaterialApp(
          home: Scaffold(body: AppEmptyState(title: 'No Items')),
        ),
      );
      await expectLater(
        find.byType(AppEmptyState),
        matchesGoldenFile('empty_state.png'),
      );
    });

    testGoldens('error state', (tester) async {
      await tester.pumpWidgetBuilder(
        const MaterialApp(
          home: Scaffold(body: AppErrorState(title: 'Error')),
        ),
      );
      await expectLater(
        find.byType(AppErrorState),
        matchesGoldenFile('error_state.png'),
      );
    });
  });

  group('Golden tests - AppCard', () {
    testGoldens('card with title', (tester) async {
      await tester.pumpWidgetBuilder(
        const MaterialApp(
          home: Scaffold(
            body: AppCard(title: 'Card Title', subtitle: 'Subtitle'),
          ),
        ),
      );
      await expectLater(
        find.byType(AppCard),
        matchesGoldenFile('card_title.png'),
      );
    });

    testGoldens('card with children', (tester) async {
      await tester.pumpWidgetBuilder(
        const MaterialApp(
          home: Scaffold(
            body: AppCard(title: 'Card', children: [Text('Content')]),
          ),
        ),
      );
      await expectLater(
        find.byType(AppCard),
        matchesGoldenFile('card_children.png'),
      );
    });
  });
}
