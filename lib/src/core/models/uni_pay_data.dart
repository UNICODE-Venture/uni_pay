import 'package:flutter/material.dart';
import 'package:uni_pay/uni_pay.dart';

import '../../utils/uni_enums.dart';
import 'uni_credentials.dart';
import 'uni_customer_history.dart';
import 'uni_order.dart';
import 'uni_pay_customer.dart';
import 'uni_pay_res.dart';

///* `UniPayData` is all we need to make a payment request to your desired payment gateway
class UniPayData {
  ///* Name of your application
  late String appName;

  ///* Locale of gateway
  late UniPayLocale locale;

  ///* Customer information with order shipping/delivery address
  late UniPayCustomerInfo customerInfo;

  ///* Credentials of payment gateway
  late UniPayCredentials credentials;

  ///* Order information
  late UniPayOrder orderInfo;

  ///* Unipay enivronment
  late UniPayEnvironment environment;

  ///* Listen to response when payment request is successfully completed
  late ValueChanged<UniPayResponse> onPaymentSucess;

  ///* Get response callback when payment request is failed
  late ValueChanged<UniPayResponse> onPaymentFailed;

  ///* Order Meta Data in key value pair, example:
  /// ```dart
  /// {
  ///   "customer_uid": "ABC_12345",
  ///   "customer_name": "Mohammad Saif"
  /// }
  /// ```
  /// - Currently supports all `Moyasar`, `Tamara`, and `Tabby`
  Map<String, dynamic>? metaData;

  ///* Previous order history of the customer
  late List<UniCustomerHistory> ordersHistory;

  ///* Uni pay theme data
  late UniPayThemeData uniPayThemeData;

  ///* Data constructor for `UniPayData` with required parameters and optional parameters
  UniPayData({
    required this.appName,
    required this.locale,
    required this.customerInfo,
    required this.credentials,
    required this.orderInfo,
    this.environment = UniPayEnvironment.production,
    required this.onPaymentSucess,
    required this.onPaymentFailed,
    this.metaData,
    this.ordersHistory = const [],
    UniPayThemeData? themeData,
  }) : uniPayThemeData = themeData ?? UniPayThemeData();

  ///* Convert json into `UniPayData`
  UniPayData.fromJson(Map<String, dynamic> json) {
    appName = json['appName'];
    locale = UniPayLocale.values[json['locale']];
    customerInfo = UniPayCustomerInfo.fromJson(json['customerInfo']);
    credentials = UniPayCredentials.fromJson(json['credentials']);
    orderInfo = UniPayOrder.fromJson(json['orderInfo']);
    environment = UniPayEnvironment.values
        .firstWhere((e) => e.name == json['environment']);
    metaData = json['metaData'];
  }

  ///* Convert `UniPayData` to json
  Map<String, dynamic> toJson() => {
        'appName': appName,
        'locale': locale.index,
        'customerInfo': customerInfo.toJson(),
        'credentials': credentials.toJson(),
        'orderInfo': orderInfo.toJson(),
        'environment': environment.name,
        'metaData': metaData,
      };
}
