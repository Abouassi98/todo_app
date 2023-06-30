import 'package:flutter/material.dart';

abstract class AppStaticColors {
  static const Color primaryColor = Color(0xffF5C92C);
  static const Color selectedIconColor = Color(0xffCFA407);
  static const Color mainGray = Color(0xff9EA3A1);
  static const Color shadowColor = Color(0xff707070);
  static const Color toastColor = Color(0xFFC11718);
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);
  static const Color lightBlack = Color(0xff333333);
  static const Color lightOrange = Color(0xfffe9654);
  static const Color greyShadow = Color(0xffD9D9D9);
  static const Color blue = Color(0XFF181743);
  static const Color lightBlue = Color(0xFF58b9f0);
  static const List<Color> drawerColor = [
    Color(0XFFFF008D),
    Color(0XFF0DC4F4),
    Color(0XFFCF28A9),
    Color(0XFF3D457F),
    Color(0XFF00CF1C),
    Color(0XFFFFEE00),
  ];

  static const LinearGradient primaryIngredientColor = LinearGradient(
    colors: [Color(0xff254DDE), Color(0xff06E2FA)],
    stops: [0, 1],
  );
  static const LinearGradient containerIngredientColor = LinearGradient(
    colors: [Color(0xff254DDE), Color(0xffFE1E9A)],
    stops: [0, 1],
  );
  static LinearGradient appbarIngredientColor = LinearGradient(
    colors: [const Color(0xffFE1E9A).withOpacity(0.7), const Color(0xffFEA64C)],
    stops: const [0, 0.5],
  );
  static const LinearGradient loginBG = LinearGradient(
    colors: [
      Color.fromRGBO(255, 255, 255, 1),
      Color.fromRGBO(202, 235, 254, 0),
    ],
  );
  static const LinearGradient drawer = LinearGradient(
    colors: [
      Colors.white,
      Color.fromRGBO(202, 235, 254, 0.5),
    ],
  );
  static const LinearGradient homeIngredientColor = LinearGradient(
    colors: [Color(0xffFFFBF7), Color(0xffFCE4F3), Color(0xffE4E9FB)],
    stops: [0.1, 0.5, 1],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
}
