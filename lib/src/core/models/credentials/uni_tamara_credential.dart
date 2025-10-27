import 'package:uni_pay/uni_pay.dart';

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
