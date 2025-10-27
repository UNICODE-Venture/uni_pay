import 'package:uni_pay/uni_pay.dart';
import '../../constant/uni_text.dart';

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

  ///* Coupon related credentials
  late CouponCredential? couponCredential;

  UniPayCredentials({
    required this.paymentMethods,
    this.moyasarCredential,
    this.tamaraCredential,
    required this.applePayMerchantIdentifier,
    this.tabbyCredential,
    this.couponCredential,
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
