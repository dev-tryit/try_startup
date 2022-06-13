import 'package:flutter/material.dart';

class SnackBarUtil {
  static void show(BuildContext context, SnackBar snackBar){
    var messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(snackBar);
  }
}