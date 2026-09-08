import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_shimmer.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';

void main() {
  group('Golden tests - AppShimmer', () {
    testGoldens('shimmer skeleton', (tester) async {
      await tester.pumpWidgetBuilder(
        const MaterialApp(
          home: Scaffold(
            body: AppShimmer(
              autoplay: false,
              initialProgress: 0.5,
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.space4),
                child: SizedBox(
                  width: 200,
                  height: 64,
                  child: ColoredBox(color: AppColors.shimmerBaseColor),
                ),
              ),
            ),
          ),
        ),
      );
      await expectLater(
        find.byType(AppShimmer),
        matchesGoldenFile('shimmer.png'),
      );
    });
  });
}
