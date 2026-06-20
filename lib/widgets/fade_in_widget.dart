import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Fades + slides in when the widget enters the viewport.
class FadeInOnScroll extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final double slideOffset;
  const FadeInOnScroll({super.key,required this.child,this.delay=Duration.zero,this.slideOffset=40});
  @override State<FadeInOnScroll> createState() => _FadeInOnScrollState();
}

class _FadeInOnScrollState extends State<FadeInOnScroll>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double>   _opacity;
  late final Animation<Offset>   _slide;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync:this, duration:const Duration(milliseconds:650));
    _opacity = CurvedAnimation(parent:_c, curve:Curves.easeOut);
    _slide   = Tween(begin:Offset(0, widget.slideOffset/200), end:Offset.zero)
        .animate(CurvedAnimation(parent:_c, curve:Curves.easeOutCubic));
  }

  @override void dispose() { _c.dispose(); super.dispose(); }

  void _onVisibility(VisibilityInfo info) {
    if (!_triggered && info.visibleFraction > 0.08) {
      _triggered = true;
      Future.delayed(widget.delay, () { if (mounted) _c.forward(); });
    }
  }

  @override
  Widget build(BuildContext context) => VisibilityDetector(
    key: widget.key ?? UniqueKey(),
    onVisibilityChanged: _onVisibility,
    child: FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _slide, child: widget.child),
    ),
  );
}
