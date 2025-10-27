import 'package:flutter/material.dart';
import 'package:uni_pay/src/constant/path.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';

class UniPayColorsPalletes {
  static Color primaryColor = purpleColor;
  static const Color black = Colors.black;
  static Color transparent = Colors.transparent;
  static Color white = Colors.white;
  static Color greyTextColor = const Color(0xFF808080);
  static WidgetStatePropertyAll<Color> transparentMaterialColor =
      WidgetStatePropertyAll<Color>(UniPayColorsPalletes.transparent);
  static Color fillColor = const Color(0xFFF5F5F5);
  static const Color cyan = Color(0xFF13ACDF);
  static Color greyColor5 = const Color(0xffF1F2F3);
  static Color grayTextColor = const Color(0xff25272A);
  static const Color purpleColor = Color(0xffEE174B);
  static const Color boldGreyColor = Color(0xff6B717A);
  static const Color greyColor3 = Color(0xff858B94);
  static Color greyColor8 = const Color(0xffA0A5AB);
  static const Color redColor = Color(0xffFC4742);
  static const Color secondaryColor = Color(0xFF25272A);
  static const Color greyBorderColor = Color(0xFFFAFAFA);
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

  static TextStyle defaultTitle500Style({Color? color}) {
    return TextStyle(
      color: color ?? UniPayColorsPalletes.black,
      fontWeight: FontWeight.w500,
      fontSize: 14.rSp,
      fontFamily: fontFamily,
      package: UniAssetsPath.packageName,
    );
  }

  static TextStyle get title13Style400 => TextStyle(
        color: UniPayColorsPalletes.boldGreyColor,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        fontSize: 13.rSp,
        package: UniAssetsPath.packageName,
      );
}
