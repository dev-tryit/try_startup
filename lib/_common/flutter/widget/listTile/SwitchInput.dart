import 'package:flutter/material.dart';

import '../../controller/ValueController.dart';
import 'leading/LeadingTitle.dart';

class SwitchInput extends StatefulWidget {
  final ValueController<bool> controller;
  final String titleText;

  const SwitchInput({
    Key? key,
    required this.titleText,
    required this.controller,
  }) : super(key: key);

  @override
  State<SwitchInput> createState() => _SwitchInputState();
}

class _SwitchInputState extends State<SwitchInput> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      minLeadingWidth: 100,
      leading: LeadingTitle(widget.titleText),
      trailing: Switch(
        value: widget.controller.value,
        onChanged: (bool value) {
          setState(() {
            widget.controller.value = value;
          });
        },
      ),
    );
  }
}
