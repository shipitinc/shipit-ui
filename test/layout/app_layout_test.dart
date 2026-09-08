import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/layout/app_layout.dart';
import 'package:flutter/material.dart';

void main() {
  group('AppLayout', () {
    test('pageConstraints returns valid constraints', () {
      final constraints = AppLayout.pageConstraints();
      expect(constraints.maxWidth, 1200);
    });

    test('pageConstraints with custom width', () {
      final constraints = AppLayout.pageConstraints(width: 800);
      expect(constraints.maxWidth, 800);
    });

    test('centeredPage returns a widget', () {
      final widget = AppLayout.centeredPage(child: const Text('Content'));
      expect(widget, isNotNull);
    });

    test('hStack returns a Row', () {
      final widget = AppLayout.hStack(
        children: [const Text('A'), const Text('B')],
      );
      expect(widget, isA<Row>());
    });

    test('vStack returns a Column', () {
      final widget = AppLayout.vStack(
        children: [const Text('A'), const Text('B')],
      );
      expect(widget, isA<Column>());
    });

    test('hStack with wrap returns a Wrap', () {
      final widget = AppLayout.hStack(
        children: [const Text('A'), const Text('B')],
        wrap: true,
      );
      expect(widget, isA<Wrap>());
    });

    test('vStack with wrap returns a Wrap', () {
      final widget = AppLayout.vStack(
        children: [const Text('A'), const Text('B')],
        wrap: true,
      );
      expect(widget, isA<Wrap>());
    });

    test('spacer widgets are sized boxes', () {
      expect(AppLayout.width2, isA<SizedBox>());
      expect(AppLayout.width4, isA<SizedBox>());
      expect(AppLayout.height2, isA<SizedBox>());
      expect(AppLayout.height4, isA<SizedBox>());
    });

    test('divider returns a Divider', () {
      final widget = AppLayout.divider();
      expect(widget, isA<Divider>());
    });

    test('responsivePadding returns a widget', () {
      final widget = AppLayout.responsivePadding(child: const Text('Content'));
      expect(widget, isNotNull);
    });
  });
}
