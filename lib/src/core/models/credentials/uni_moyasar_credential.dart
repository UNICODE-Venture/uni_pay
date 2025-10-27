import 'dart:convert';

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
