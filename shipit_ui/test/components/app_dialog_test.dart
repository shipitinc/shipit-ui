import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_dialog.dart';

void main() {
  group('AppDialog', () {
    testWidgets('dialog renders with title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppDialog(
              title: 'Confirm',
              content: const Text('Are you sure?'),
              actions: [TextButton(onPressed: () {}, child: const Text('OK'))],
            ),
          ),
        ),
      );

      expect(find.text('Confirm'), findsOneWidget);
      expect(find.text('Are you sure?'), findsOneWidget);
    });

    testWidgets('dialog renders with subtitle', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppDialog(
              title: 'Confirm',
              subtitle: 'Please review',
              content: Text('Content'),
              actions: [],
            ),
          ),
        ),
      );

      expect(find.text('Please review'), findsOneWidget);
    });

    testWidgets('error dialog factory creates correct buttons', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppDialog.error(
              title: 'Delete Item',
              subtitle: 'This action cannot be undone',
              onConfirm: () {},
            ),
          ),
        ),
      );

      expect(find.text('Delete Item'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });
  });
}
