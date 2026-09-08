import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/components/app_confirm_dialog.dart';

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

Widget _launcher({
  required bool isDestructive,
  required void Function(bool) onResult,
}) {
  return MaterialApp(
    home: Scaffold(
      body: Builder(
        builder: (context) => TextButton(
          key: const Key('open'),
          onPressed: () async {
            final result = await AppConfirmDialog.show(
              context,
              title: 'Confirm?',
              message: 'Are you sure?',
              isDestructive: isDestructive,
            );
            onResult(result);
          },
          child: const Text('Open'),
        ),
      ),
    ),
  );
}

void main() {
  group('AppConfirmDialog', () {
    testWidgets('renders title, message and default labels', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const AppConfirmDialog(
            title: 'Save changes?',
            message: 'Your edits will be kept.',
          ),
        ),
      );

      expect(find.text('Save changes?'), findsOneWidget);
      expect(find.text('Your edits will be kept.'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.byKey(AppConfirmDialog.confirmKey), findsOneWidget);
      expect(find.byKey(AppConfirmDialog.cancelKey), findsOneWidget);
      expect(find.byIcon(Icons.warning_amber_rounded), findsNothing);
    });

    testWidgets('renders custom labels and content', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const AppConfirmDialog(
            title: 'Publish',
            confirmLabel: 'Publish now',
            cancelLabel: 'Later',
            content: Text('Extra content'),
          ),
        ),
      );

      expect(find.text('Publish now'), findsOneWidget);
      expect(find.text('Later'), findsOneWidget);
      expect(find.text('Extra content'), findsOneWidget);
    });

    testWidgets('destructive defaults to Delete and shows warning icon', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(const AppConfirmDialog.destructive(title: 'Delete item?')),
      );

      expect(find.text('Delete'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
    });

    testWidgets('fires onConfirm and onCancel callbacks', (tester) async {
      var confirmed = false;
      var cancelled = false;
      await tester.pumpWidget(
        _wrap(
          AppConfirmDialog(
            title: 'Confirm?',
            onConfirm: () => confirmed = true,
            onCancel: () => cancelled = true,
          ),
        ),
      );

      await tester.tap(find.byKey(AppConfirmDialog.confirmKey));
      await tester.tap(find.byKey(AppConfirmDialog.cancelKey));
      await tester.pump();

      expect(confirmed, isTrue);
      expect(cancelled, isTrue);
    });

    testWidgets('applies semanticLabel key and Semantics label', (
      tester,
    ) async {
      const key = Key('confirm_dialog');
      await tester.pumpWidget(
        _wrap(const AppConfirmDialog(title: 'Confirm?', semanticLabel: key)),
      );

      expect(find.byKey(key), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (w) => w is Semantics && w.properties.label == 'Confirm?',
        ),
        findsOneWidget,
      );
    });

    testWidgets('show returns true on confirm', (tester) async {
      bool? result;
      await tester.pumpWidget(
        _launcher(isDestructive: false, onResult: (r) => result = r),
      );

      await tester.tap(find.byKey(const Key('open')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(AppConfirmDialog.confirmKey));
      await tester.pumpAndSettle();

      expect(result, isTrue);
      expect(find.byType(AppConfirmDialog), findsNothing);
    });

    testWidgets('show returns false on cancel', (tester) async {
      bool? result;
      await tester.pumpWidget(
        _launcher(isDestructive: false, onResult: (r) => result = r),
      );

      await tester.tap(find.byKey(const Key('open')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(AppConfirmDialog.cancelKey));
      await tester.pumpAndSettle();

      expect(result, isFalse);
    });

    testWidgets('default show is barrier-dismissible and returns false', (
      tester,
    ) async {
      bool? result;
      await tester.pumpWidget(
        _launcher(isDestructive: false, onResult: (r) => result = r),
      );

      await tester.tap(find.byKey(const Key('open')));
      await tester.pumpAndSettle();
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(find.byType(AppConfirmDialog), findsNothing);
      expect(result, isFalse);
    });

    testWidgets('destructive show is not barrier-dismissible', (tester) async {
      bool? result;
      await tester.pumpWidget(
        _launcher(isDestructive: true, onResult: (r) => result = r),
      );

      await tester.tap(find.byKey(const Key('open')));
      await tester.pumpAndSettle();
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(find.byType(AppConfirmDialog), findsOneWidget);
      expect(result, isNull);
    });
  });
}
