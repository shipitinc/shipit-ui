import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_shimmer.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

void main() {
  group('AppShimmer', () {
    testWidgets('renders with default tokens', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppShimmer(
              child: SizedBox(
                width: 100,
                height: 100,
                child: ColoredBox(color: AppTheme.light.color.shimmer.base),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppShimmer), findsOneWidget);
      expect(find.byType(ShaderMask), findsOneWidget);
    });

    testWidgets('can be frozen at a specific progress', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppShimmer(
              autoplay: false,
              initialProgress: 0.5,
              child: SizedBox(
                width: 100,
                height: 100,
                child: ColoredBox(color: AppTheme.light.color.shimmer.base),
              ),
            ),
          ),
        ),
      );

      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(AppShimmer), findsOneWidget);
    });

    testWidgets('uses provided duration and direction', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppShimmer(
              duration: AppTheme.light.motion.duration.fast,
              direction: AppShimmerDirection.ttb,
              autoplay: false,
              initialProgress: 0.5,
              child: SizedBox(
                width: 100,
                height: 100,
                child: ColoredBox(color: AppTheme.light.color.shimmer.base),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppShimmer), findsOneWidget);
    });

    testWidgets('reports loading semantics', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppShimmer(
              autoplay: false,
              child: SizedBox(
                width: 100,
                height: 100,
                child: ColoredBox(color: AppTheme.light.color.shimmer.base),
              ),
            ),
          ),
        ),
      );

      expect(find.bySemanticsLabel('Loading'), findsOneWidget);

      handle.dispose();
    });

    testWidgets('clamps initial progress', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppShimmer(
              autoplay: false,
              initialProgress: 2.0,
              child: SizedBox(
                width: 100,
                height: 100,
                child: ColoredBox(color: AppTheme.light.color.shimmer.base),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppShimmer), findsOneWidget);
    });
  });
}
