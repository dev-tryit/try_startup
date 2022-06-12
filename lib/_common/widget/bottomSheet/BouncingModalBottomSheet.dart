import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../animation/FastBouncingEffect.dart';

class BouncingModalBottomSheet extends StatelessWidget {
  late void Function() fastBouncingAnimator;

  BouncingModalBottomSheet({Key? key}) : super(key: key);

  void show(BuildContext context) {
    showMaterialModalBottomSheet(
      enableDrag: false,
      bounce: false,
      context: context,
      backgroundColor: Colors.transparent,
      duration: Duration.zero,
      builder: (context) => this,
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
            child: FastBouncingEffect(
              initAnimator: (fastBouncingAnimator) =>
                  this.fastBouncingAnimator = fastBouncingAnimator,
              child: Container(
                height: 100,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
