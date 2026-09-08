import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shipit_ui/src/components/app_avatar.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

Widget _row(List<Widget> children) {
  return MaterialApp(
    home: Scaffold(
      backgroundColor: AppColors.bgSurfaceColor,
      body: Center(
        child: Row(
          key: const Key('avatar_row'),
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < children.length; i++) ...[
              if (i > 0) const SizedBox(width: AppSpacing.space6),
              children[i],
            ],
          ],
        ),
      ),
    ),
  );
}

Widget _countBadge(String count) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space1),
    constraints: const BoxConstraints(minWidth: AppSpacing.space4),
    height: AppSpacing.space4,
    alignment: Alignment.center,
    decoration: const BoxDecoration(
      color: AppColors.actionPrimaryBgColor,
      borderRadius: AppRadius.borderRadiusFull,
    ),
    child: Text(
      count,
      style: AppTypography.labelSmall.copyWith(
        color: AppColors.actionPrimaryFgColor,
      ),
    ),
  );
}

void main() {
  group('Golden tests - AppAvatar', () {
    testGoldens('sizes', (tester) async {
      await tester.pumpWidgetBuilder(
        _row(const [
          AppAvatar(name: 'Ada Lovelace', size: AppAvatarSize.sm),
          AppAvatar(name: 'Ada Lovelace'),
          AppAvatar(name: 'Ada Lovelace', size: AppAvatarSize.lg),
          AppAvatar(name: 'Ada Lovelace', size: AppAvatarSize.xl),
        ]),
        surfaceSize: const Size(320, 120),
      );
      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('avatar_sizes.png'),
      );
    });

    testGoldens('states', (tester) async {
      await tester.pumpWidgetBuilder(
        _row([
          const AppAvatar(name: 'Ada Lovelace', status: AppAvatarStatus.online),
          const AppAvatar(name: 'Ada Lovelace', status: AppAvatarStatus.busy),
          const AppAvatar(),
          AppAvatar(name: 'Ada Lovelace', badge: _countBadge('3')),
        ]),
        surfaceSize: const Size(320, 120),
      );
      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('avatar_states.png'),
      );
    });
  });
}
