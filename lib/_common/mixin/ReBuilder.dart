import 'package:flutter/material.dart';

mixin ReBuilder<TargetWidget extends StatefulWidget> on State<TargetWidget> {
  void rebuild({Future<void> Function()? afterBuild}) {
    if (afterBuild != null) {
      //build 때, afterBuild 불리도록 요청.
      WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild());
    }

    //Flutter는 중간에 state를 제거해놓기도 한다. 추후에 build로 다시 생성하지만..
    //이 때, setState가 불리면, 에러가 발생한다. 따라서, mounted 여부 체크가 필요하다.
    if (!mounted) return;

    setState(() {});
  }
}
