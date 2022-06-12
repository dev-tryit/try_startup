import 'package:flutter/material.dart';

import '../../animation/FastBouncingEffect.dart';

class BouncingModalBottomSheet extends StatelessWidget {
  late void Function() fastBouncingAnimator;
  BouncingModalBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: GestureDetector(
          onTap: () {
            fastBouncingAnimator();
          },
        )),
        FastBouncingEffect(
          initAnimator: (fastBouncingAnimator) => this.fastBouncingAnimator = fastBouncingAnimator,
          child: Container(
            height: 100,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
