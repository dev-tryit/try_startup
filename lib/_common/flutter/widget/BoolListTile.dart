import 'package:flutter/material.dart';

class BoolController {
  bool value;

  BoolController(this.value);
}

class BoolListTile extends StatefulWidget {
  final BoolController controller;
  final String titleText;

  const BoolListTile({
    Key? key,
    required this.titleText,
    required this.controller,
  }) : super(key: key);

  @override
  State<BoolListTile> createState() => _BoolListTileState();
}

class _BoolListTileState extends State<BoolListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      minLeadingWidth: 100,
      leading: Text(widget.titleText, style: const TextStyle(fontSize: 12.5)),
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
