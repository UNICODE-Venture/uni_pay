import 'dart:ui';

import 'package:uni_pay/src/theme/colors.dart';
import 'package:uni_pay/uni_pay.dart';

class UniPayThemeData {
  /// Primary color of the UniPay theme.
  late Color primaryColor;

  /// UI type for the payment view
  late UniPayUIType uiType;

  /// Header Title text
  late String? headerTitle;

  /// Header Subtitle text
  late String? headerSubtitle;

  /// App bar text
  late String? appBarTitle;

  /// Tabby header title text
  late String? tabbyHeaderTitle;

  /// Tamara header title text
  late String? tamaraHeaderTitle;

  /// Credit card header title text
  late String? creditCardHeaderTitle;

  /// Data constructor for `UniPayThemeData` with optional parameters
  UniPayThemeData({
    this.primaryColor = UniPayColorsPalletes.purpleColor,
    this.uiType = UniPayUIType.modern,
    this.headerTitle,
    this.headerSubtitle,
    this.appBarTitle,
    this.tabbyHeaderTitle,
    this.tamaraHeaderTitle,
    this.creditCardHeaderTitle,
  });
}
