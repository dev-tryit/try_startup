import 'package:flutter/material.dart';

import '../_common/flutter/widget/RowSeparated.dart';
import 'MyColor.dart';
import 'MyImage.dart';
import 'MyStyle.dart';

class MyWidget {
  static Widget header({PreferredSizeWidget? bottom}){
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      toolbarHeight: 83,
      backgroundColor: MyColor.pointColor,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45.0),
        child: Row(children: [
          _headerLogo(),
          const Spacer(),
          _headerMenu(),
          const Spacer(),
          _headerActions(),
        ]),
      ),
      bottom: bottom,
    );
  }

  static Widget _headerMenu() {
    return RowSeparated(
      mainAxisSize: MainAxisSize.min,
      separatorWidget: const SizedBox(width: 30),
      items: const <String>["TryIt 소개", "포트폴리오", "Flutter과외", "문의"],
      builder: (String item) {
        return Text(item, style: MyStyle.menuTextStyle);
      },
    );
  }

  static Widget _headerActions() {
    return RowSeparated(
      mainAxisSize: MainAxisSize.min,
      separatorWidget: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text("|"),
      ),
      items: const <String>["KOR", "ENG"],
      builder: (String item) {
        return Text(item, style: MyStyle.menuTextStyle);
      },
    );
  }

  static Widget _headerLogo() {
    return const SizedBox(
      width: 120,
      height: 60,
      child: Image(
        image: MyImage.logoImage,
        fit: BoxFit.fill,
      ),
    );
  }
}