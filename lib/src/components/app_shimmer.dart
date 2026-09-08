import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_motion.dart';

/// Direction of the shimmer sweep.
enum AppShimmerDirection {
  /// Left-to-right.
  ltr,

  /// Right-to-left.
  rtl,

  /// Top-to-bottom.
  ttb,

  /// Bottom-to-top.
  btt,
}

/// A reusable shimmer loading effect for the shipit_ui design system.
///
/// Wrap any opaque placeholder [child] (e.g., boxes, circles, text blocks) and
/// the child will be filled with an animated gradient. Product packages can use
/// this to build skeleton screens while content loads.
///
/// The [child] should be opaque and typically filled with [AppColors.shimmerBaseColor]
/// so the gradient is visible. Custom [baseColor] and [highlightColor] can be
/// supplied for other contexts.
///
/// ## Semantics
///
/// Reports a default "Loading" label. Wrap with [Semantics] if a more specific
/// label is needed.
///
/// See docs/penpot-mapping.md for the Penpot token mapping.
class AppShimmer extends StatefulWidget {
  /// The placeholder widget to apply the shimmer effect to. Should be opaque.
  final Widget child;

  /// The base color of the shimmer. Defaults to [AppColors.shimmerBaseColor].
  final Color baseColor;

  /// The highlight color of the shimmer. Defaults to
  /// [AppColors.shimmerHighlightColor].
  final Color highlightColor;

  /// The duration of one full shimmer sweep. Defaults to [AppMotion.shimmer].
  final Duration duration;

  /// The easing curve of the shimmer sweep. Defaults to [AppMotion.curveStandard].
  final Curve curve;

  /// The direction of the sweep. Defaults to [AppShimmerDirection.ltr].
  final AppShimmerDirection direction;

  /// Whether the shimmer should animate automatically. Set to `false` to freeze
  /// the effect at [initialProgress] (useful for golden tests).
  final bool autoplay;

  /// The initial animation progress, from `0.0` (off-screen) to `1.0`
  /// (off-screen on the far side). `0.5` places the highlight band in the
  /// center of the child.
  final double initialProgress;

  /// Optional key used for automation targeting.
  final Key? semanticLabel;

  const AppShimmer({
    super.key,
    required this.child,
    this.baseColor = AppColors.shimmerBaseColor,
    this.highlightColor = AppColors.shimmerHighlightColor,
    this.duration = AppMotion.shimmer,
    this.curve = AppMotion.curveStandard,
    this.direction = AppShimmerDirection.ltr,
    this.autoplay = true,
    this.initialProgress = 0.0,
    this.semanticLabel,
  });

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  static const double _gradientStart = -2.0;
  static const double _gradientEnd = 2.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: widget.initialProgress.clamp(0.0, 1.0),
    );
    _animation = Tween<double>(
      begin: _gradientStart,
      end: _gradientEnd,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    if (widget.autoplay) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant AppShimmer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }
    if (widget.curve != oldWidget.curve) {
      _animation = Tween<double>(
        begin: _gradientStart,
        end: _gradientEnd,
      ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    }
    if (widget.autoplay != oldWidget.autoplay) {
      if (widget.autoplay) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      key: widget.semanticLabel,
      container: true,
      label: 'Loading',
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final t = _animation.value;
          final (begin, end) = _gradientAlignments(t, widget.direction);
          return ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: begin,
                end: end,
                colors: [
                  widget.baseColor,
                  widget.baseColor,
                  widget.highlightColor,
                  widget.baseColor,
                  widget.baseColor,
                ],
                stops: const [0.0, 0.4, 0.5, 0.6, 1.0],
              ).createShader(bounds);
            },
            child: child!,
          );
        },
        child: widget.child,
      ),
    );
  }

  (Alignment, Alignment) _gradientAlignments(
    double t,
    AppShimmerDirection direction,
  ) {
    switch (direction) {
      case AppShimmerDirection.ltr:
        return (Alignment(-1.0 + t, 0.0), Alignment(1.0 + t, 0.0));
      case AppShimmerDirection.rtl:
        return (Alignment(1.0 - t, 0.0), Alignment(-1.0 - t, 0.0));
      case AppShimmerDirection.ttb:
        return (Alignment(0.0, -1.0 + t), Alignment(0.0, 1.0 + t));
      case AppShimmerDirection.btt:
        return (Alignment(0.0, 1.0 - t), Alignment(0.0, -1.0 - t));
    }
  }
}
