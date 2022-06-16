import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'FastBouncingWidgetEffect.dart';

class BackController {
  late Function back;

  BackController();
}


class BouncingModalBottomEffect extends StatelessWidget {
  BackController backController;
  Widget Function() builder;
  late void Function() fastBouncingAnimator;
  AnimationController? animationController;
  bool useModal;

  BouncingModalBottomEffect(this.builder, {Key? key, this.useModal=false, required this.backController}) : super(key: key);

  static Future apply(
      BuildContext context, {required Widget Function() builder, bool useModal=false, required BackController backController}) async {
    return showMaterialModalBottomSheet(
      enableDrag: false,
      bounce: false,
      context: context,
      backgroundColor: Colors.transparent,
      duration: Duration.zero,
      builder: (context) => BouncingModalBottomEffect(builder, useModal:useModal, backController:backController),
    );
  }

  @override
  Widget build(BuildContext context) {
    backController.back = ()=>back(context);

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
                back(context);
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

  void back(BuildContext context) {
    animationController?.reverse().then((value) {
      Navigator.pop(context);
    });
  }
}
