import 'package:flutter/material.dart';

class FastBouncingEffect extends StatefulWidget {
  final Widget? child;
  final Duration duration;
  final void Function(void Function() fastBouncingAnimator) initAnimator;

  const FastBouncingEffect({
    Key? key,
    this.child,
    this.duration = const Duration(milliseconds: 200),
    required this.initAnimator,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FastBouncingEffectState();
  }
}

class _FastBouncingEffectState extends State<FastBouncingEffect>
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

    _tween = Tween(begin: 1.0, end: 0.8).animate(
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
    _controller.reset();
    _controller.forward().then((value) {
      _controller.reverse();
    });
  }
}
