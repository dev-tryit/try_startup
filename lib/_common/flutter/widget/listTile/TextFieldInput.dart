import 'package:flutter/material.dart';
import 'package:try_startup/_common/flutter/controller/ValueController.dart';

import 'leading/LeadingTitle.dart';

class TextFieldInput extends StatelessWidget {
  final ValueController<String> controller;
  final String titleText;

  const TextFieldInput({
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
      leading: LeadingTitle(titleText),
      title: TextField(
        controller: TextEditingController(text: controller.value),
        decoration: const InputDecoration(isDense: true),
        textAlign: TextAlign.end,
        onChanged: (value) {
          controller.value = value;
        },
      ),
    );
  }
}
