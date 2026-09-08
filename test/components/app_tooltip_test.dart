import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/components/app_tooltip.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';

void main() {
  group('AppTooltip', () {
    testWidgets('renders child and exposes message', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTooltip(message: 'Sign out', child: Icon(Icons.logout)),
          ),
        ),
      );

      expect(find.byIcon(Icons.logout), findsOneWidget);
      expect(find.byTooltip('Sign out'), findsOneWidget);
    });

    testWidgets('shows token-styled tooltip on long press', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTooltip(message: 'Sign out', child: Icon(Icons.logout)),
          ),
        ),
      );

      await tester.longPress(find.byIcon(Icons.logout));
      await tester.pump(const Duration(milliseconds: 600));

      expect(find.text('Sign out'), findsOneWidget);

      final decorated = tester
          .widgetList<Container>(find.byType(Container))
          .map((c) => c.decoration)
          .whereType<BoxDecoration>()
          .firstWhere((d) => d.color == AppColors.tooltipBgColor);
      expect(decorated.color, AppColors.tooltipBgColor);

      await tester.pumpAndSettle(const Duration(seconds: 2));
    });

    testWidgets('rich variant renders inline spans', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTooltip.rich(
              richMessage: TextSpan(
                children: [
                  TextSpan(text: 'Press '),
                  TextSpan(
                    text: 'Enter',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              child: Icon(Icons.keyboard),
            ),
          ),
        ),
      );

      await tester.longPress(find.byIcon(Icons.keyboard));
      await tester.pump(const Duration(milliseconds: 600));

      expect(find.textContaining('Press'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 2));
    });
  });
}
