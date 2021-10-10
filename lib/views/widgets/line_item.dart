// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:white_rabbit_sreedwish/constants.dart';
import 'package:white_rabbit_sreedwish/uiResource/colors.dart';
import 'package:white_rabbit_sreedwish/uiResource/styles.dart';

class LineItem extends StatelessWidget {
  final String hint;
  String? value;

  LineItem({required this.hint, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$hint : ',
            style: bodyText.copyWith(
                color: const Color(textSubGrey), fontSize: 13),
          ),
          Expanded(
            child: Text(
              value ?? unknown,
              textAlign: TextAlign.end,
              style: bodyText.copyWith(color: const Color(textBlack)),
            ),
          )
        ],
      ),
    );
  }
}
