import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/components/app_shimmer.dart';
import 'package:shipit_ui/src/components/app_skeleton.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

BoxDecoration _decoration(WidgetTester tester, Finder finder) =>
    tester.widget<Container>(finder).decoration! as BoxDecoration;

void main() {
  group('AppSkeleton', () {
    testWidgets('line fills width and uses shimmer base color', (tester) async {
      await tester.pumpWidget(
        _wrap(const SizedBox(width: 300, child: AppSkeleton.line())),
      );

      final finder = find.descendant(
        of: find.byType(AppSkeleton),
        matching: find.byType(Container),
      );
      expect(tester.getSize(finder).width, 300);
      expect(_decoration(tester, finder).color, AppColors.shimmerBaseColor);
    });

    testWidgets('circle renders with given diameter', (tester) async {
      await tester.pumpWidget(
        _wrap(const Center(child: AppSkeleton.circle(diameter: 24))),
      );

      expect(tester.getSize(find.byType(AppSkeleton)), const Size(24, 24));
      expect(
        _decoration(
          tester,
          find.descendant(
            of: find.byType(AppSkeleton),
            matching: find.byType(Container),
          ),
        ).shape,
        BoxShape.circle,
      );
    });

    testWidgets('block renders with given size', (tester) async {
      await tester.pumpWidget(
        _wrap(const Center(child: AppSkeleton.block(width: 120, height: 40))),
      );
      expect(tester.getSize(find.byType(AppSkeleton)), const Size(120, 40));
    });

    testWidgets('shimmer wraps composition in a single AppShimmer', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          AppSkeleton.shimmer(
            autoplay: false,
            child: const Column(
              children: [AppSkeleton.line(), AppSkeleton.line()],
            ),
          ),
        ),
      );

      expect(find.byType(AppShimmer), findsOneWidget);
      expect(find.byType(AppSkeleton), findsNWidgets(2));
    });

    testWidgets('listTile and card presets render placeholders', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          Column(
            children: [
              AppSkeleton.listTile(autoplay: false),
              AppSkeleton.card(autoplay: false),
            ],
          ),
        ),
      );

      expect(find.byType(AppShimmer), findsNWidgets(2));
      expect(find.byType(AppSkeleton), findsNWidgets(7));
    });

    testWidgets('exposes a single Loading live region', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _wrap(AppSkeleton.listTile(key: const Key('skel'), autoplay: false)),
      );
      expect(
        tester.getSemantics(find.byKey(const Key('skel'))),
        isSemantics(label: 'Loading', isLiveRegion: true),
      );
      handle.dispose();
    });
  });
}
