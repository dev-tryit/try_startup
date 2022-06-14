import 'package:flutter/material.dart';

class StringListTile extends StatelessWidget {
  final TextEditingController controller;
  final String titleText;

  const StringListTile({
    Key? key,
    required this.titleText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      minLeadingWidth: 100,
      leading: Text(titleText, style: const TextStyle(fontSize: 12.5)),
      title: TextField(
        controller: controller,
        decoration: const InputDecoration(isDense: true),
      ),
    );
  }
}
