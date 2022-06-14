import 'package:flutter/material.dart';

class LeadingTitle extends StatelessWidget {
  final String titleText;
  const LeadingTitle(this.titleText,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(titleText, style: const TextStyle(fontSize: 12.5));
  }
}
