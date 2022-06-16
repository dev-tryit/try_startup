import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'FastBouncingWidgetEffect.dart';

class PopController {
  late Function popFunction;

  PopController();
}


class BouncingModalBottomEffect extends StatelessWidget {
  PopController popController;
  Widget Function() builder;
  late void Function() fastBouncingAnimator;
  late AnimationController animationController;
  bool useModal;

  BouncingModalBottomEffect(this.builder, {Key? key, this.useModal=false, required this.popController}) : super(key: key);

  static void apply(
      BuildContext context, {required Widget Function() builder, bool useModal=false, required PopController popController}) {
    showMaterialModalBottomSheet(
      enableDrag: false,
      bounce: false,
      context: context,
      backgroundColor: Colors.transparent,
      duration: Duration.zero,
      builder: (context) => BouncingModalBottomEffect(builder, useModal:useModal, popController:popController),
    );
  }

  @override
  Widget build(BuildContext context) {
    popController.popFunction = ()=>popFunction(context);

    return ColoredBox(
      color: Colors.black.withOpacity(0.35),
      child: Column(
        children: [
          Expanded(child: GestureDetector(
            onTap: () {
              if(useModal) {
                fastBouncingAnimator();
              }
              else {
                popFunction(context);
              }
            },
          )),
          SlideInUp(
            duration: const Duration(milliseconds: 200),
            controller: (animationController) =>
                this.animationController = animationController,
            child: FastBouncingWidgetEffect(
              initAnimator: (fastBouncingAnimator) =>
                  this.fastBouncingAnimator = fastBouncingAnimator,
              child: builder(),
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
