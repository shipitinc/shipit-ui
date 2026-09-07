import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/shipit_ui.dart';

void main() {
  test('shipit_ui library loads', () {
    expect(AppColors.actionPrimary, isNotNull);
    expect(AppTypography.bodyLarge, isNotNull);
    expect(AppSpacing.md, 16.0);
    expect(AppRadius.radiusMd, 8.0);
    expect(AppBreakpoints.md, 900);
  });
}
