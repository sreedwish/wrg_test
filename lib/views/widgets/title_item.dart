// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:white_rabbit_sreedwish/uiResource/styles.dart';

class TitleItem extends StatelessWidget {
  final String title;

  const TitleItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      child: Text(
        title,
        style: headline1Black,
      ),
    );
  }
}
