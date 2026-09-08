import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shipit_ui/src/components/app_inline_alert.dart';
import 'package:shipit_ui/src/components/app_skeleton.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';

Widget _page(Widget child) => MaterialApp(
  home: Scaffold(
    backgroundColor: AppColors.bgBaseColor,
    body: Padding(
      padding: const EdgeInsets.all(AppSpacing.space4),
      child: child,
    ),
  ),
);

void main() {
  group('Golden tests - AppSkeleton', () {
    testGoldens('card and list tile silhouettes', (tester) async {
      await tester.pumpWidgetBuilder(
        _page(
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpacing.space4,
            children: [
              AppSkeleton.card(autoplay: false),
              AppSkeleton.listTile(autoplay: false),
              AppSkeleton.listTile(autoplay: false),
            ],
          ),
        ),
        surfaceSize: const Size(400, 320),
      );
      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('skeleton_states.png'),
      );
    });
  });

  group('Golden tests - AppInlineAlert', () {
    testGoldens('all severities', (tester) async {
      await tester.pumpWidgetBuilder(
        _page(
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpacing.space3,
            children: [
              AppInlineAlert.error(
                title: 'Could not load members',
                message: 'Check your connection and try again.',
                actionLabel: 'Retry',
                onAction: () {},
                onDismiss: () {},
              ),
              AppInlineAlert.warning(
                title: 'Unsaved changes',
                onDismiss: () {},
              ),
              const AppInlineAlert.info(
                title: 'Heads up',
                message: 'Sync runs nightly.',
              ),
              AppInlineAlert.success(title: 'Saved', onDismiss: () {}),
            ],
          ),
        ),
        surfaceSize: const Size(400, 420),
      );
      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('inline_alert_severities.png'),
      );
    });
  });
}
