import 'package:flutter/material.dart';
import 'package:uni_pay/uni_pay.dart';

class TabbySnippet extends TabbyCredential {
  /// Total amount with VAT
  final num totalAmountWithVat;

  /// Currency of transaction, default is `SAR`
  final UniPayCurrency currency;

  /// Locale of transaction, default is `en_US`
  final UniPayLocale locale;

  /// Border color of the snippet, default is `0xFFD6DED6`
  final Color borderColor;

  /// Background color of the snippet, default is `0xFFFFFFFF`
  final Color backgroundColor;

  /// Text color of the snippet, default is `0xFF292929`
  final Color textColor;

  /// Installment count, default is `4`
  final int installmentCount;

  /// Environment of Tabby, default is `UniPayEnvironment.production`
  final UniPayEnvironment environment;

  TabbySnippet({
    required this.totalAmountWithVat,
    this.currency = UniPayCurrency.sar,
    this.locale = UniPayLocale.ar,
    this.borderColor = const Color(0xFFD6DED6),
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF292929),
    super.merchantCode = "sa",
    super.psKey = "",
    this.installmentCount = 4,
    this.environment = UniPayEnvironment.production,
    super.merchantUrl,
    Key? key,
  });
}
