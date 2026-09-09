import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_shimmer.dart';
import 'package:shipit_ui/src/theme/app_theme.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

Widget _scene(AppTheme tokens, {ThemeData? theme}) => MaterialApp(
  theme: theme,
  home: Scaffold(
    body: AppShimmer(
      autoplay: false,
      initialProgress: 0.5,
      child: Padding(
        padding: EdgeInsets.all(tokens.space.s4),
        child: SizedBox(
          width: 200,
          height: 64,
          child: ColoredBox(color: tokens.color.shimmer.base),
        ),
      ),
    ),
  ),
);

void main() {
  group('Golden tests - AppShimmer', () {
    testGoldens('shimmer skeleton', (tester) async {
      await tester.pumpWidgetBuilder(_scene(AppTheme.light));
      await expectLater(
        find.byType(AppShimmer),
        matchesGoldenFile('shimmer.png'),
      );
    });

    testGoldens('shimmer skeleton (dark)', (tester) async {
      await tester.pumpWidgetBuilder(
        _scene(AppTheme.dark, theme: shipitDarkTheme()),
      );
      await expectLater(
        find.byType(AppShimmer),
        matchesGoldenFile('shimmer_dark.png'),
      );
    });
  });
}
