import 'package:flutter/material.dart';

class FastBouncingWidgetEffect extends StatefulWidget {
  final Widget? child;
  final Duration duration;
  final void Function(void Function() fastBouncingAnimator) initAnimator;

  const FastBouncingWidgetEffect({
    Key? key,
    this.child,
    this.duration = const Duration(milliseconds: 200),
    required this.initAnimator,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FastBouncingWidgetEffectState();
  }
}

class _FastBouncingWidgetEffectState extends State<FastBouncingWidgetEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _tween;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addListener(() {
        setState(() {});
      });
    widget.initAnimator(play);

    _tween = Tween(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.65,
          1.00,
          curve: Curves.easeIn,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _tween.value,
      child: widget.child,
    );
  }

  void play() {
    _controller.forward().then((value) {
      _controller.reverse();
    });
  }
}
