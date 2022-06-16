import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:try_startup/_common/flutter/controller/ValueController.dart';
import 'package:try_startup/extension/NullableExtension.dart';

import 'leading/LeadingTitle.dart';

class IntListTile extends StatelessWidget {
  final ValueController<int> controller;
  final String titleText;

  const IntListTile({
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
        controller: TextEditingController(text: controller.value.toString()),
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(isDense: true),
        textAlign: TextAlign.end,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (String value) {
          controller.value = int.tryParse(value) ?? 0;
        },
      ),
    );
  }
}
