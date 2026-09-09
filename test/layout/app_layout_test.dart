import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/layout/app_layout.dart';
import 'package:shipit_ui/src/theme/app_theme.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

Future<BuildContext> _pump(WidgetTester tester, Widget child) async {
  late BuildContext captured;
  await tester.pumpWidget(
    MaterialApp(
      theme: shipitLightTheme(),
      home: Scaffold(
        body: Builder(
          builder: (context) {
            captured = context;
            return child;
          },
        ),
      ),
    ),
  );
  return captured;
}

void main() {
  group('AppLayout', () {
    testWidgets('pageConstraints reads breakpoint.pageWidth', (tester) async {
      final context = await _pump(tester, const SizedBox());
      expect(AppLayout.pageConstraints(context).maxWidth, 1200);
      expect(AppLayout.pageConstraints(context, width: 800).maxWidth, 800);
    });

    testWidgets('centeredPage pads with space.s4 by default', (tester) async {
      await _pump(tester, AppLayout.centeredPage(child: const Text('C')));
      final padding = tester.widget<Padding>(
        find.ancestor(of: find.text('C'), matching: find.byType(Padding)).first,
      );
      expect(padding.padding, const EdgeInsets.symmetric(horizontal: 16));
      expect(
        find.byWidgetPredicate(
          (w) => w is ConstrainedBox && w.constraints.maxWidth == 1200,
        ),
        findsOneWidget,
      );
    });

    testWidgets('hStack / vStack default spacing to space.s4', (tester) async {
      await _pump(
        tester,
        Column(
          children: [
            AppLayout.hStack(children: const [Text('a'), Text('b')]),
            AppLayout.vStack(children: const [Text('c'), Text('d')]),
            AppLayout.hStack(children: const [Text('e')], wrap: true),
          ],
        ),
      );
      expect(tester.widget<Row>(find.byType(Row)).spacing, 16);
      expect(
        tester
            .widgetList<Column>(find.byType(Column))
            .map((c) => c.spacing)
            .toList(),
        contains(16),
      );
      expect(find.byType(Wrap), findsOneWidget);
    });

    testWidgets('spacers and divider resolve tokens', (tester) async {
      await _pump(
        tester,
        Column(
          children: [AppLayout.width2, AppLayout.height4, AppLayout.divider()],
        ),
      );
      final boxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      expect(boxes.any((b) => b.width == 8), isTrue);
      expect(boxes.any((b) => b.height == 16), isTrue);
      final divider = tester.widget<Divider>(find.byType(Divider));
      expect(divider.color, AppTheme.light.color.border.base);
      expect(divider.height, 16);
    });

    testWidgets('overridden space tokens flow into layout helpers', (
      tester,
    ) async {
      final tokens = AppTheme.light.copyWith(
        space: AppTheme.light.space.copyWith(s4: 24),
      );
      await tester.pumpWidget(
        MaterialApp(
          theme: shipitLightTheme(tokens: tokens),
          home: Scaffold(
            body: AppLayout.hStack(children: const [Text('a'), Text('b')]),
          ),
        ),
      );
      expect(tester.widget<Row>(find.byType(Row)).spacing, 24);
    });

    testWidgets('responsivePadding picks padding by width class', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await _pump(
        tester,
        AppLayout.responsivePadding(
          child: const Text('C'),
          mobilePadding: const EdgeInsets.all(1),
          tabletPadding: const EdgeInsets.all(2),
          desktopPadding: const EdgeInsets.all(3),
        ),
      );
      final padding = tester.widget<Padding>(
        find.ancestor(of: find.text('C'), matching: find.byType(Padding)).first,
      );
      expect(padding.padding, const EdgeInsets.all(2));
    });
  });
}
