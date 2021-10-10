import 'colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

//Font 400 - Regular
//Font 500 - Medium
//Font 600 - SemiBold
//Font 700 - Bold

const headline1 = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 18,
  color: Color(white),
  fontWeight: FontWeight.w600,
);

const headline1Black = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 18,
  color: Color(textBlack2),
  fontWeight: FontWeight.w600,
);

const headline2 = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 30,
  color: Color(textBlack),
  fontWeight: FontWeight.w500,
);

const subTitle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 16,
  color: Color(subTitleTextBlack),
  fontWeight: FontWeight.w500,
);

const bodyText = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 14,
  color: Color(white),
  fontWeight: FontWeight.w500,
);

const infoWindowText = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 12,
  color: Color(primaryFont),
  fontWeight: FontWeight.w500,
);

const headline1SmallFont = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 14,
  color: Color(textBlack),
  fontWeight: FontWeight.w600,
);

const regular = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 16,
  color: Color(textBlack2),
  fontWeight: FontWeight.w400,
);

var systemUiStyleForSplash = SystemUiOverlayStyle().copyWith(
    statusBarColor: Colors.blueGrey[400], statusBarBrightness: Brightness.dark);
var systemUiStyleForDash = SystemUiOverlayStyle().copyWith(
    statusBarColor: Color(colorPrimary), statusBarBrightness: Brightness.dark);
var systemUiStyleForMap = SystemUiOverlayStyle().copyWith(
    statusBarColor: Colors.blueGrey[400], statusBarBrightness: Brightness.dark);

final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom().copyWith(
  backgroundColor: MaterialStateProperty.resolveWith<Color>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) return Colors.grey;
      return Color(colorPrimary); // Defer to the widget's default.
    },
  ),
);

final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom().copyWith(
  side: MaterialStateProperty.resolveWith<BorderSide>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return const BorderSide(
          color: Color(colorPrimary),
          width: 1,
        );
      }
      return const BorderSide(color: Color(colorPrimary));
    },
  ),
);

const OutlineInputBorder normalBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
  borderSide: BorderSide(color: Colors.black12, width: 1),
);
