import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shipit_ui/src/components/app_inline_alert.dart';
import 'package:shipit_ui/src/components/app_skeleton.dart';
import 'package:shipit_ui/src/theme/app_theme.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

Widget _page(Widget child, {ThemeData? theme}) => MaterialApp(
  theme: theme,
  home: Builder(
    builder: (context) => Scaffold(
      backgroundColor: context.color.bg.base,
      body: Padding(padding: EdgeInsets.all(context.space.s4), child: child),
    ),
  ),
);

Widget _skeletons() => Builder(
  builder: (context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: context.space.s4,
    children: [
      AppSkeleton.card(autoplay: false),
      AppSkeleton.listTile(autoplay: false),
      AppSkeleton.listTile(autoplay: false),
    ],
  ),
);

Widget _alerts() => Builder(
  builder: (context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: context.space.s3,
    children: [
      AppInlineAlert.error(
        title: 'Could not load members',
        message: 'Check your connection and try again.',
        actionLabel: 'Retry',
        onAction: () {},
        onDismiss: () {},
      ),
      AppInlineAlert.warning(title: 'Unsaved changes', onDismiss: () {}),
      const AppInlineAlert.info(
        title: 'Heads up',
        message: 'Sync runs nightly.',
      ),
      AppInlineAlert.success(title: 'Saved', onDismiss: () {}),
    ],
  ),
);

void main() {
  group('Golden tests - AppSkeleton', () {
    testGoldens('card and list tile silhouettes', (tester) async {
      await tester.pumpWidgetBuilder(
        _page(_skeletons()),
        surfaceSize: const Size(400, 320),
      );
      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('skeleton_states.png'),
      );
    });

    testGoldens('card and list tile silhouettes (dark)', (tester) async {
      await tester.pumpWidgetBuilder(
        _page(_skeletons(), theme: shipitDarkTheme()),
        surfaceSize: const Size(400, 320),
      );
      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('skeleton_states_dark.png'),
      );
    });
  });

  group('Golden tests - AppInlineAlert', () {
    testGoldens('all severities', (tester) async {
      await tester.pumpWidgetBuilder(
        _page(_alerts()),
        surfaceSize: const Size(400, 420),
      );
      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('inline_alert_severities.png'),
      );
    });

    testGoldens('all severities (dark)', (tester) async {
      await tester.pumpWidgetBuilder(
        _page(_alerts(), theme: shipitDarkTheme()),
        surfaceSize: const Size(400, 420),
      );
      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('inline_alert_severities_dark.png'),
      );
    });
  });
}
