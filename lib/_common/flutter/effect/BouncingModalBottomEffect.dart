import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'FastBouncingWidgetEffect.dart';

class BouncingModalBottomEffect extends StatelessWidget {
  Widget Function(Function popFunction) builder;
  late void Function() fastBouncingAnimator;
  late AnimationController animationController;

  BouncingModalBottomEffect(this.builder, {Key? key}) : super(key: key);

  static void apply(
      BuildContext context, {required Widget Function(Function popFunction) builder}) {
    showMaterialModalBottomSheet(
      enableDrag: false,
      bounce: false,
      context: context,
      backgroundColor: Colors.transparent,
      duration: Duration.zero,
      builder: (context) => BouncingModalBottomEffect(builder),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black.withOpacity(0.35),
      child: Column(
        children: [
          Expanded(child: GestureDetector(
            onTap: () {
              fastBouncingAnimator();
            },
          )),
          SlideInUp(
            duration: const Duration(milliseconds: 200),
            controller: (animationController) =>
                this.animationController = animationController,
            child: FastBouncingWidgetEffect(
              initAnimator: (fastBouncingAnimator) =>
                  this.fastBouncingAnimator = fastBouncingAnimator,
              child: builder(() => popFunction(context)),
            ),
          ),
        ],
      ),
    );
  }

  void popFunction(BuildContext context) {
    animationController.reverse().then((value) {
      Navigator.pop(context);
    });
  }
}
