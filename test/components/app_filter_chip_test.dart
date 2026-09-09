import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/components/app_filter_chip.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

Widget _harness({
  bool selected = false,
  ValueChanged<bool>? onSelected,
  IconData? icon,
}) {
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: AppFilterChip(
          label: 'Active',
          selected: selected,
          onSelected: onSelected,
          icon: icon,
          semanticLabel: const Key('chip_active'),
        ),
      ),
    ),
  );
}

BoxDecoration _decoration(WidgetTester tester) {
  return tester
          .widget<AnimatedContainer>(find.byType(AnimatedContainer))
          .decoration
      as BoxDecoration;
}

void main() {
  group('AppFilterChip', () {
    testWidgets('renders label', (tester) async {
      await tester.pumpWidget(_harness());
      expect(find.text('Active'), findsOneWidget);
      expect(tester.getSize(find.byType(AppFilterChip)).height, 32);
    });

    testWidgets('toggles via onSelected', (tester) async {
      bool? value;
      await tester.pumpWidget(_harness(onSelected: (v) => value = v));
      await tester.tap(find.byKey(const Key('chip_active')));
      expect(value, isTrue);

      await tester.pumpWidget(
        _harness(selected: true, onSelected: (v) => value = v),
      );
      await tester.tap(find.byKey(const Key('chip_active')));
      expect(value, isFalse);
    });

    testWidgets('applies unselected styling and leading icon', (tester) async {
      await tester.pumpWidget(_harness(icon: Icons.star));
      final decoration = _decoration(tester);
      expect(decoration.color, AppTheme.light.color.chip.bg);
      expect(decoration.border!.top.color, AppTheme.light.color.chip.border);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('applies selected styling with check icon', (tester) async {
      await tester.pumpWidget(_harness(selected: true, icon: Icons.star));
      final decoration = _decoration(tester);
      expect(decoration.color, AppTheme.light.color.chip.selected.bg);
      expect(
        decoration.border!.top.color,
        AppTheme.light.color.chip.selected.border,
      );
      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.byIcon(Icons.star), findsNothing);

      final text = tester.widget<Text>(find.text('Active'));
      expect(text.style!.color, AppTheme.light.color.chip.selected.fg);
      expect(text.style!.fontWeight, FontWeight.w600);
    });

    testWidgets('exposes selected semantics', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(_harness(selected: true, onSelected: (_) {}));
      expect(
        tester.getSemantics(find.byKey(const Key('chip_active'))),
        isSemantics(isSelected: true, isButton: true, label: 'Active'),
      );
      handle.dispose();
    });
  });
}
