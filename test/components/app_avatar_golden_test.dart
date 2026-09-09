import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shipit_ui/src/components/app_avatar.dart';
import 'package:shipit_ui/src/theme/app_theme.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

Widget _row(List<Widget> children, {ThemeData? theme}) {
  return MaterialApp(
    theme: theme,
    home: Builder(
      builder: (context) => Scaffold(
        backgroundColor: context.color.bg.surface,
        body: Center(
          child: Row(
            key: const Key('avatar_row'),
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) SizedBox(width: context.space.s6),
                children[i],
              ],
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _countBadge(String count) {
  return Builder(
    builder: (context) => Container(
      padding: EdgeInsets.symmetric(horizontal: context.space.s1),
      constraints: BoxConstraints(minWidth: context.space.s4),
      height: context.space.s4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.color.action.primary.bg,
        borderRadius: context.radius.all.full,
      ),
      child: Text(
        count,
        style: context.text.label.small.copyWith(
          color: context.color.action.primary.fg,
        ),
      ),
    ),
  );
}

List<Widget> _stateAvatars() => [
  const AppAvatar(name: 'Ada Lovelace', status: AppAvatarStatus.online),
  const AppAvatar(name: 'Ada Lovelace', status: AppAvatarStatus.busy),
  const AppAvatar(),
  AppAvatar(name: 'Ada Lovelace', badge: _countBadge('3')),
];

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
        _row(_stateAvatars()),
        surfaceSize: const Size(320, 120),
      );
      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('avatar_states.png'),
      );
    });

    testGoldens('states (dark)', (tester) async {
      await tester.pumpWidgetBuilder(
        _row(_stateAvatars(), theme: shipitDarkTheme()),
        surfaceSize: const Size(320, 120),
      );
      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('avatar_states_dark.png'),
      );
    });
  });
}
