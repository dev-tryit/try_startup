
import 'package:flutter/material.dart';

/// A widget which adds a heartbeat effect to its contents.
class FastBouncingWidget extends StatefulWidget {
  /// The item to apply the heartbeat effect to.
  final Widget? child;

  /// The number of beats per minutes. Defaults to 70.
  final Duration duration;
  final void Function(AnimationController controller) animationControllerSender;

  FastBouncingWidget(
      {this.child,
        this.duration= const Duration(milliseconds: 200),
        required this.animationControllerSender});

  @override
  State<StatefulWidget> createState() {
    return _FastBouncingWidgetState();
  }
}

class _FastBouncingWidgetState extends State<FastBouncingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _beatForward, _tween;

  @override
  void initState() {
    super.initState();

    // When it comes to calculating the beats per minute. 60000 milliseconds which make up a minute is divided by the number of beatsPerMinute. At the time of this writing it approximately produces the desired effect. It is quite possible that this division might result in a negative number or 0, in that case a default beating of 70bps (857 milliseconds) is applied.

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addListener(() {
      setState(() {});
    });

    widget.animationControllerSender(_controller);

    _tween = Tween(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.65,
          1.00,
          curve: Curves.easeIn,
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(FastBouncingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
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
}
