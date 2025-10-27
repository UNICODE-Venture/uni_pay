import 'package:uni_pay/src/core/keys/api_keys.dart';

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
