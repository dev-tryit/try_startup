import 'package:flutter/material.dart';

import '../effect/BouncingModalBottomEffect.dart';

class AlertBottomSheet extends StatelessWidget {
  String alertMessageText;
  String alertButtonText;
  VoidCallback onPressed;

  AlertBottomSheet(
      {Key? key,
      required this.alertMessageText,
      required this.alertButtonText,
      required this.onPressed})
      : super(key: key);

  static Future<void> show(
    BuildContext context, {
    required String alertMessageText,
    String alertButtonText = '확인',
        required BackController backController,
  }) async {
    await BouncingModalBottomEffect.apply(context, builder: () {
      return AlertBottomSheet(
        alertMessageText: alertMessageText,
        alertButtonText: alertButtonText,
        onPressed: () {
          backController.back();
        },
      );
    }, backController: backController);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(9),
          topRight: Radius.circular(9),
        ),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(alertMessageText),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style:
                  OutlinedButton.styleFrom(padding: const EdgeInsets.all(20)),
              onPressed: onPressed,
              child: Text(
                alertButtonText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
