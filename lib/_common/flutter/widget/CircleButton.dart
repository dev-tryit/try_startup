
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool useShadow;

  const CircleButton(this.text,
      {Key? key, required this.onPressed, this.useShadow = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shadowColor: useShadow ? Colors.black : null,
        elevation: useShadow ? 7 : null,
        padding:
        const EdgeInsets.only(left: 23, right: 23, top: 14, bottom: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }
}
