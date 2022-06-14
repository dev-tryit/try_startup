import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:try_startup/_common/flutter/controller/ValueController.dart';

import 'leading/LeadingTitle.dart';

class MultiSelectListTile extends StatefulWidget {
  final ValueController<List<String>> controller;
  final String titleText;
  final List<S2Choice<String>> choiceItems;

  const MultiSelectListTile({
    Key? key,
    required this.titleText,
    required this.controller,
    required this.choiceItems,
  }) : super(key: key);

  @override
  State<MultiSelectListTile> createState() => _MultiSelectListTileState();
}

class _MultiSelectListTileState extends State<MultiSelectListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.zero,
        dense: true,
        minLeadingWidth: 100,
        leading: LeadingTitle(widget.titleText),
        title: SizedBox(
          child: SmartSelect<String>.multiple(
            title: '',
            selectedValue: widget.controller.value,
            choiceItems: widget.choiceItems,
            onChange: (selected) =>
                setState(() => widget.controller.value = selected.value),
            modalType: S2ModalType.bottomSheet,
            tileBuilder: (context, state) => ListTile(
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text((state.selected.title??[]).join(",")),
                  S2Tile.defaultTrailing,
                ],
              ),
              onTap: (){
                state.showModal();
              },
            ),
          ),
        ));
  }
}
