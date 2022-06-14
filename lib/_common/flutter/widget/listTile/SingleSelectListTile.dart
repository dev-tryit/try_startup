import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:try_startup/_common/flutter/controller/ValueController.dart';

import 'leading/LeadingTitle.dart';

class SingleSelectListTile extends StatefulWidget {
  final ValueController<String> controller;
  final String titleText;
  final List<S2Choice<String>> choiceItems;

  const SingleSelectListTile({
    Key? key,
    required this.titleText,
    required this.controller,
    required this.choiceItems,
  }) : super(key: key);

  @override
  State<SingleSelectListTile> createState() => _SingleSelectListTileState();
}

class _SingleSelectListTileState extends State<SingleSelectListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.zero,
        dense: true,
        minLeadingWidth: 100,
        leading: LeadingTitle(widget.titleText),
        title: SmartSelect<String>.single(
          title: '',
          selectedValue: widget.controller.value,
          choiceItems: widget.choiceItems,
          onChange: (selected) =>
              setState(() => widget.controller.value = selected.value),
          modalType: S2ModalType.bottomSheet,
          tileBuilder: (context, state) => S2Tile.fromState(state),
        ));
  }
}
