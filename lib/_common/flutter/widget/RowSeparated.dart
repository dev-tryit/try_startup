import 'package:flutter/material.dart';

import 'FlexBoxSeparated.dart';

class RowSeparated<ItemType> extends FlexBoxSeparated<ItemType> {
  RowSeparated(
      {Key? key,
      Widget? separatorWidget,
      bool addTopDivider = false,
      bool addBottomDivider = false,
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
      CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
      MainAxisSize mainAxisSize = MainAxisSize.max,
      required List<ItemType> items,
      required Widget Function(ItemType item) builder})
      : super(
            key: key,
            builder: builder,
            separatorWidget: separatorWidget,
            addTopDivider: addTopDivider,
            addBottomDivider: addBottomDivider,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            mainAxisSize: mainAxisSize,
            items: items);

  @override
  Widget flexBoxBuilder({
    required MainAxisAlignment mainAxisAlignment,
    required CrossAxisAlignment crossAxisAlignment,
    required List<Widget> children,
    MainAxisSize mainAxisSize = MainAxisSize.max,
  }) {
    return Row(
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );
  }
}
