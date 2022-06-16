import 'package:flutter/material.dart';

import '../effect/BouncingModalBottomEffect.dart';
import '../widget/CircleButton.dart';

typedef AddFunctionWithSetErrorMessage = void Function(
    void Function(String errorMessage) setErrorMessage);

class InputBottomSheet extends StatefulWidget {
  String title;
  String buttonStr;
  List<Widget> children;
  AddFunctionWithSetErrorMessage onAdd;

  InputBottomSheet(
      {Key? key,
      required this.title,
      required this.children,
      required this.onAdd,
      required this.buttonStr})
      : super(key: key);

  @override
  _InputBottomSheetState createState() => _InputBottomSheetState();

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String buttonStr,
    required List<Widget> children,
    required AddFunctionWithSetErrorMessage onAdd,
    required PopController popController,
  }) async {
    await BouncingModalBottomEffect.apply(context, builder: () {
      return InputBottomSheet(
        title: title,
        buttonStr: buttonStr,
        onAdd: onAdd,
        children: children,
      );
    }, popController: popController);
  }
}

class _InputBottomSheetState extends State<InputBottomSheet> {
  String errorMessage = "";

  void setErrorMessage(String errorMessage) {
    this.errorMessage = errorMessage;
    setState(() {});
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
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Expanded(
                  child: Text(
                    errorMessage,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CircleButton(
                  widget.buttonStr,
                  useShadow: false,
                  onPressed: () => widget.onAdd(setErrorMessage),
                ),
              ],
            ),
          ),
          const Divider(),
          ...widget.children,
        ],
      ),
    );
  }
}
