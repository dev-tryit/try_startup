import 'dart:collection';

import 'package:flutter/material.dart';

abstract class FlexBoxSeparated<ItemType> extends StatelessWidget {
  List<ItemType> items;
  Widget? separatorWidget;
  Widget Function(ItemType item) builder;
  MainAxisAlignment mainAxisAlignment;
  CrossAxisAlignment crossAxisAlignment;
  MainAxisSize mainAxisSize;
  bool addTopDivider;
  bool addBottomDivider;

  FlexBoxSeparated(
      {Key? key,
      this.separatorWidget,
      this.addTopDivider = false,
      this.addBottomDivider = false,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.mainAxisSize = MainAxisSize.max,
      required this.items,
      required this.builder})
      : super(key: key);

  Widget flexBoxBuilder({
    required MainAxisAlignment mainAxisAlignment,
    required CrossAxisAlignment crossAxisAlignment,
    required List<Widget> children,
    MainAxisSize mainAxisSize = MainAxisSize.max,
  });

  @override
  Widget build(BuildContext context) {
    bool separated = false;
    Queue<Widget> widgetList = new Queue();
    for (var item in items) {
      if (!separated) {
        separated = true;
      } else {
        if (separatorWidget != null) {
          widgetList.add(separatorWidget!);
        }
      }

      widgetList.add(builder(item));
    }

    if (separatorWidget != null) {
      if (addTopDivider) {
        widgetList.addFirst(separatorWidget!);
      }
      if (addBottomDivider) {
        widgetList.addLast(separatorWidget!);
      }
    }

    return flexBoxBuilder(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: widgetList.toList(),
    );
  }
}
