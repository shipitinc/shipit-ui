import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/components/app_avatar.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

Widget _harness(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}

Container _statusDot(WidgetTester tester) {
  return tester.widget<Container>(
    find.descendant(
      of: find.byType(Positioned),
      matching: find.byType(Container),
    ),
  );
}

void main() {
  group('AppAvatar.initialsFor', () {
    test('derives initials from names', () {
      expect(AppAvatar.initialsFor('Ada Lovelace'), 'AL');
      expect(AppAvatar.initialsFor('ada'), 'A');
      expect(AppAvatar.initialsFor('Mary Jane Watson'), 'MJ');
      expect(AppAvatar.initialsFor('  spaced   out  '), 'SO');
      expect(AppAvatar.initialsFor(''), '');
      expect(AppAvatar.initialsFor(null), '');
    });
  });

  group('AppAvatar', () {
    testWidgets('renders initials for a name', (tester) async {
      await tester.pumpWidget(_harness(const AppAvatar(name: 'Ada Lovelace')));

      expect(find.text('AL'), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsNothing);
    });

    testWidgets('renders fallback icon when no name', (tester) async {
      await tester.pumpWidget(_harness(const AppAvatar()));

      expect(find.byIcon(Icons.person_outline), findsOneWidget);
      expect(find.byType(Text), findsNothing);
    });

    testWidgets('sizes map to correct dimensions', (tester) async {
      const expected = {
        AppAvatarSize.sm: 24.0,
        AppAvatarSize.md: 32.0,
        AppAvatarSize.lg: 40.0,
        AppAvatarSize.xl: 56.0,
      };
      for (final entry in expected.entries) {
        await tester.pumpWidget(
          _harness(AppAvatar(name: 'Ada', size: entry.key)),
        );
        expect(AppAvatar.dimension(entry.key), entry.value);
        expect(
          tester.getSize(find.byType(AppAvatar)),
          Size(entry.value, entry.value),
        );
      }
    });

    testWidgets('defaults to md size', (tester) async {
      await tester.pumpWidget(_harness(const AppAvatar(name: 'Ada')));
      expect(tester.getSize(find.byType(AppAvatar)), const Size(32, 32));
    });

    testWidgets('renders no status dot or badge by default', (tester) async {
      await tester.pumpWidget(_harness(const AppAvatar(name: 'Ada')));
      expect(find.byType(Positioned), findsNothing);
    });

    testWidgets('renders status dot with correct color', (tester) async {
      final color = AppTheme.light.color;
      final expected = {
        AppAvatarStatus.online: color.state.success.fg,
        AppAvatarStatus.offline: color.fg.muted,
        AppAvatarStatus.busy: color.state.error.fg,
      };
      for (final entry in expected.entries) {
        await tester.pumpWidget(
          _harness(AppAvatar(name: 'Ada', status: entry.key)),
        );
        final decoration = _statusDot(tester).decoration! as BoxDecoration;
        expect(decoration.color, entry.value);
        expect(decoration.shape, BoxShape.circle);
        expect(decoration.border!.top.color, color.bg.surface);
      }
    });

    testWidgets('renders custom badge', (tester) async {
      await tester.pumpWidget(
        _harness(
          const AppAvatar(
            name: 'Ada',
            status: AppAvatarStatus.online,
            badge: Text('3', key: Key('badge')),
          ),
        ),
      );

      expect(find.byKey(const Key('badge')), findsOneWidget);
      expect(find.byType(Positioned), findsNWidgets(2));
    });

    testWidgets('renders image when provided', (tester) async {
      await tester.pumpWidget(
        _harness(
          AppAvatar(
            name: 'Ada Lovelace',
            image: MemoryImage(Uint8List.fromList(_transparentPng)),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      expect(find.text('AL'), findsOneWidget);
    });

    testWidgets('exposes semantics label defaulting to name', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _harness(
          const AppAvatar(
            name: 'Ada Lovelace',
            semanticLabel: Key('avatar_ada'),
          ),
        ),
      );

      expect(
        tester.getSemantics(find.byKey(const Key('avatar_ada'))),
        isSemantics(label: 'Ada Lovelace', isImage: true),
      );
      handle.dispose();
    });

    testWidgets('exposes explicit semantics label and Avatar fallback', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _harness(
          const AppAvatar(
            name: 'Ada',
            semanticsLabel: 'Profile picture',
            semanticLabel: Key('avatar'),
          ),
        ),
      );
      expect(
        tester.getSemantics(find.byKey(const Key('avatar'))),
        isSemantics(label: 'Profile picture'),
      );

      await tester.pumpWidget(
        _harness(const AppAvatar(semanticLabel: Key('avatar'))),
      );
      expect(
        tester.getSemantics(find.byKey(const Key('avatar'))),
        isSemantics(label: 'Avatar'),
      );
      handle.dispose();
    });
  });
}

const List<int> _transparentPng = <int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, //
  0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, //
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00, //
  0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, //
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, //
  0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82, //
];
