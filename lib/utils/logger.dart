// ignore_for_file: avoid_print

import 'package:white_rabbit_sreedwish/constants.dart';

class Logger {
  static void printWithTag(String tag, String msg) {
    if (logEnabled) {
      print('~~$tag : $msg');
    }
  }

  static void printMsg(String msg) {
    if (logEnabled) {
      print('~~: $msg');
    }
  }
}
