import 'package:flutter/material.dart';

import '../../../uni_pay.dart';

class WidgetData {
  final bool currentStatus;
  final ValueChanged<bool> onChange;
  final UniPayLocale locale;
  final Color? activeColor;
  final num? totalAmount;
  final int? installment;
  final UniPayCurrency currency;

  WidgetData({
    required this.currentStatus,
    required this.onChange,
    this.locale = UniPayLocale.ar,
    this.activeColor,
    this.totalAmount,
    this.currency = UniPayCurrency.sar,
    this.installment,
  });
}
