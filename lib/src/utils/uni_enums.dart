import 'package:flutter/material.dart';
import 'package:tabby_flutter_inapp_sdk_fork/tabby_flutter_inapp_sdk_fork.dart';
import 'package:uni_pay/src/core/keys/api_keys.dart';
import 'package:uni_pay/src/utils/extension.dart';

import '../constant/locale.dart';

enum UniPayPaymentMethods {
  applepay,
  card,
  stcpay,
  tamara,
  tabby,
  notSpecified;

  /// Check if the payment method is `ApplePay`
  bool get isApplePay => this == UniPayPaymentMethods.applepay;

  /// Check if the payment method is `Card`
  bool get isCard => this == UniPayPaymentMethods.card;

  /// Check if the payment method is `STC Pay`
  bool get isStcPay => this == UniPayPaymentMethods.stcpay;

  /// Check if the payment method is `Tamara`
  bool get isTamara => this == UniPayPaymentMethods.tamara;

  /// Check if the payment method is `Tabby`
  bool get isTabby => this == UniPayPaymentMethods.tabby;

  /// Check if the payment method is `Moyasar gateway`
  bool get isMoyasar => isApplePay || isCard || isStcPay;

  /// Check if the payment method is `NotSpecified`
  bool get isNotSpecified => this == UniPayPaymentMethods.notSpecified;

  /// Get the `pay now` amount by the type of payment method is selected
  String payNowAmount(num totalAmount) {
    num amount = totalAmount;
    // Tamara is 3 installments
    if (isTamara) {
      amount = totalAmount / 3;
    } else if (isTabby) {
      amount = totalAmount / 4;
    }
    return amount.formattedString;
  }
}

enum UniPayLocale {
  ar,
  en;

  /// Get current locale `ar_SA` or `en_US`
  Locale get currentLocale => this == UniPayLocale.ar
      ? LocalizationsData.supportLocale.first
      : LocalizationsData.supportLocale.last;

  /// Check if the locale is `Arabic`
  bool get isArabic => this == UniPayLocale.ar;

  /// Check if the locale is `English`
  bool get isEnglish => this == UniPayLocale.en;

  /// Get the locale code
  String get localeCode {
    switch (this) {
      case UniPayLocale.ar:
        return "ar_SA";
      case UniPayLocale.en:
        return "en_US";
      // default:
      //   return "en_US";
    }
  }

  /// tabby locale
  Lang get tabbyLang => isArabic ? Lang.ar : Lang.en;

  /// Get the language code
  String get code => isArabic ? "ar" : "en";
}

enum UniPayCountry { sa }

enum UniPayCurrency {
  sar,
  aed,
  kwd,
  bhd,
  qar,
  usd;

  /// Get the name of currency
  String get currencyCode {
    return switch (this) {
      UniPayCurrency.sar => "SAR",
      UniPayCurrency.aed => "AED",
      UniPayCurrency.kwd => "KWD",
      UniPayCurrency.bhd => "BHD",
      UniPayCurrency.qar => "QAR",
      UniPayCurrency.usd => "USD",
    };
  }

  /// Get the tabby currency
  Currency get tabbyCurrency {
    switch (this) {
      case UniPayCurrency.sar:
        return Currency.sar;
      case UniPayCurrency.aed:
        return Currency.aed;
      case UniPayCurrency.kwd:
        return Currency.kwd;
      case UniPayCurrency.bhd:
        return Currency.bhd;
      case UniPayCurrency.qar:
        return Currency.qar;
      case UniPayCurrency.usd:
        throw Exception("USD Currency not supported by Tabby");
    }
  }
}

enum UniPayItemType { product, service, notSpecified }

enum UniPayEnvironment {
  production,
  development;

  /// Check if the environment is `Production`
  bool get isProduction => this == UniPayEnvironment.production;

  /// Check if the environment is `Development`
  bool get isDevelopement => this == UniPayEnvironment.development;

  String get tamaraBaseUrl => isProduction
      ? ApiKeys.tamaraProductionBaseUrl
      : ApiKeys.tamaraBaseUrlForDev;

  String get tamaraCapturePayment => "$tamaraBaseUrl/payments/capture";
  String tamaraTransactionApi(String orderId) =>
      "$tamaraBaseUrl/orders/$orderId";

  /// Get the tabby environment
  Environment get tabbyEnv =>
      isProduction ? Environment.production : Environment.production;
}

enum UniPayStatus {
  success,
  failed,
  cancelled,
  notSpecified,
  notFound;

  bool get isSuccess => this == UniPayStatus.success;
  bool get isFailed => this == UniPayStatus.failed;
  bool get isCancelled => this == UniPayStatus.cancelled;
  bool get isNotSpecified => this == UniPayStatus.notSpecified;
  bool get isNotFound => this == UniPayStatus.notFound;
}

enum UniPayCurrentState { loading, success, failed, notSpecified }

enum UniPayCardType {
  mada,
  visa,
  mastercard,
  amex,
  tamara,
  notSpecified;

  bool get isMada => this == UniPayCardType.mada;
  bool get isVisa => this == UniPayCardType.visa;
  bool get isMastercard => this == UniPayCardType.mastercard;
  bool get isAmex => this == UniPayCardType.amex;
  bool get isTamara => this == UniPayCardType.tamara;
  bool get isNotSpecified => this == UniPayCardType.notSpecified;
}

///* Below section responsible  above enums extentions

extension UniPayCountryExt on UniPayCountry {
  String get countryCode {
    switch (this) {
      case UniPayCountry.sa:
        return "SA";
    }
  }
}

extension UniPayCurrentStateExt on UniPayCurrentState {
  bool get isLoading => this == UniPayCurrentState.loading;
  bool get isSuccess => this == UniPayCurrentState.success;
  bool get isFailed => this == UniPayCurrentState.failed;
  bool get isNotSpecified => this == UniPayCurrentState.notSpecified;
}

extension UniPayPaymentMethodsExt on List<UniPayPaymentMethods> {
  /// Check if any of the payment methods is `Moyasar`
  bool get isMoyasarGateway => any((t) => t.isMoyasar);

  /// Check if any of the payment methods is `Tamara`
  bool get isTamaraGateway => any((t) => t.isTamara);

  /// Check if any of the payment methods is `ApplePay`
  bool get isApplePay => any((t) => t.isApplePay);

  /// Check if any of the payment methods is `Tabby`
  bool get isTabbyGateway => any((t) => t.isTabby);

  /// Check if any of the payment methods is `stcpay`
  bool get isStcPay => any((t) => t.isStcPay);
}
