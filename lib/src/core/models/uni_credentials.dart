import 'dart:convert';

import 'package:uni_pay/uni_pay.dart';

import '../../constant/uni_text.dart';
import '../keys/api_keys.dart';

class UniPayCredentials {
  ///* Payment methods to be shown in gateway `[UniPayPaymentMethods.card]`
  late List<UniPayPaymentMethods> paymentMethods;

  ///* Moyasar credentials
  late MoyasarCredential? moyasarCredential;

  ///* Tamara credentials
  late TamaraCredential? tamaraCredential;

  ///* Apple pay merchant identifier. e.g: `merchant.com.myapp.sa`
  late String applePayMerchantIdentifier;

  ///* Tabby credentials
  late TabbyCredential? tabbyCredential;

  UniPayCredentials({
    required this.paymentMethods,
    this.moyasarCredential,
    this.tamaraCredential,
    required this.applePayMerchantIdentifier,
    this.tabbyCredential,
  })  : assert(
            paymentMethods.isMoyasarGateway ? moyasarCredential != null : true,
            UniPayText.pleaseProvideMoyasarCredentails),
        assert(paymentMethods.isTamaraGateway ? tamaraCredential != null : true,
            UniPayText.pleaseProvideTamaraCredentails),
        assert(paymentMethods.isTabbyGateway ? tabbyCredential != null : true,
            UniPayText.pleaseProvideTabbyCredentails),
        assert(paymentMethods.isNotEmpty, UniPayText.noGatewayProvided),
        assert(moyasarCredential != null || tamaraCredential != null,
            UniPayText.pleaseProvideCredentials),
        assert(
            paymentMethods.isApplePay
                ? applePayMerchantIdentifier.isNotEmpty
                : true,
            UniPayText.applePayMerchantIdentifierError);

  UniPayCredentials.fromJson(Map<String, dynamic> json) {
    paymentMethods =
        json['paymentMethods'].map((e) => UniPayPaymentMethods.values[e]);
    moyasarCredential = MoyasarCredential.fromJson(json['moyasarCredential']);
    tamaraCredential = TamaraCredential.fromJson(json['tamaraCredential']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentMethods'] = paymentMethods.map((e) => e..index).toList();
    data['moyasarCredential'] = moyasarCredential?.toJson();
    data['tamaraCredential'] = tamaraCredential?.toJson();
    data['applePayMerchantIdentifier'] = applePayMerchantIdentifier;
    data['tabbyCredential'] = tabbyCredential?.toJson();

    return data;
  }
}

///* Moyasar credential
class MoyasarCredential {
  ///* Moyasar publishable key
  late String publishableKey;

  ///* Moyasar secret key
  late String secretKey;

  MoyasarCredential({
    this.publishableKey = "",
    this.secretKey = "",
  });

  MoyasarCredential.fromJson(Map<String, dynamic> json) {
    publishableKey = json['publishableKey'];
    secretKey = json['secretKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['publishableKey'] = publishableKey;
    data['secretKey'] = secretKey;
    return data;
  }

  String get moyasarAuthKey => 'Basic ${base64Encode(utf8.encode(secretKey))}';
}

///* Tamara credential
class TamaraCredential {
  ///* Tamara token
  late String token;

  ///* Merchant `Urls` for Tamara
  late MerchantUrl merchantUrl;

  ///* If `true` it authorise the payment automatically after successful payment
  late bool authoriseOrder;

  ///* If `true` it capture the full amount of order automatically after successful payment
  late bool captureOrder;

  TamaraCredential({
    required this.token,
    required this.merchantUrl,
    this.authoriseOrder = true,
    this.captureOrder = false,
  }) : assert(
            merchantUrl.success.isNotEmpty &&
                merchantUrl.success != merchantUrl.failure,
            "Tamara success and failure urls must be different");

  TamaraCredential.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    merchantUrl = MerchantUrl.fromJson(json['merchantUrl']);
    authoriseOrder = json['authoriseOrder'];
    captureOrder = json['captureOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['merchantUrl'] = merchantUrl.toJson();
    data['authoriseOrder'] = authoriseOrder;
    data['captureOrder'] = captureOrder;
    return data;
  }
}

class MerchantUrl {
  late String success;
  late String failure;
  late String cancel;
  late String notification;

  MerchantUrl({
    this.success = ApiKeys.successUrl,
    this.failure = ApiKeys.failedUrl,
    this.cancel = ApiKeys.cancelUrl,
    required this.notification,
  });

  MerchantUrl.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    failure = json['failure'];
    cancel = json['cancel'];
    notification = json['notification'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['failure'] = failure;
    data['cancel'] = cancel;
    data['notification'] = notification;
    return data;
  }
}
