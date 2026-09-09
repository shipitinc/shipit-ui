import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/shipit_ui.dart';

void main() {
  test('shipit_ui library loads', () {
    expect(AppTheme.light.color.action.primary.bg, isNotNull);
    expect(AppTheme.light.text.body.large, isNotNull);
    expect(AppTheme.light.space.s4, 16.0);
    expect(AppTheme.light.radius.md, 8.0);
    expect(AppTheme.light.breakpoint.desktop, 1024);
  });
}
