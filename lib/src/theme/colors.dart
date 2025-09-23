import 'package:flutter/material.dart';
import 'package:uni_pay/src/constant/path.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';

class UniPayColorsPalletes {
  static const Color primaryColor = Colors.black;
  static const Color black = Colors.black;
  static Color transparent = Colors.transparent;
  static Color white = Colors.white;
  static Color greyTextColor = const Color(0xFF808080);
  static WidgetStatePropertyAll<Color> transparentMaterialColor =
      WidgetStatePropertyAll<Color>(UniPayColorsPalletes.transparent);
  static Color fillColor = const Color(0xFFF5F5F5);
}

class UniPayTheme {
  UniPayTheme._();
  static String fontFamily = "IBMPlexSansArabic";

  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: UniPayColorsPalletes.white,
    fontFamily: fontFamily,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
      ),
    ),
    appBarTheme:
        AppBarTheme(elevation: 0, backgroundColor: UniPayColorsPalletes.white),
    splashFactory: NoSplash.splashFactory,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
  );

  static TextStyle get uniPayStyle => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 13.rSp,
        package: UniAssetsPath.packageName,
      );
  static TextStyle get uniPaySubTitleStyle => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 13.rSp,
        package: UniAssetsPath.packageName,
        color: Colors.grey[800],
      );
}
