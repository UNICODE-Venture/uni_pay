import 'package:tabby_flutter_inapp_sdk_fork/tabby_flutter_inapp_sdk_fork.dart';

import 'uni_pay_address.dart';

class UniPayCustomerInfo {
  ///* Customer name
  late String fullName;

  ///* Customer phone number
  late String phoneNumber;

  ///* Customer email
  late String email;

  ///* Customer address
  late UniPayAddress address;

  ///* Customer joined date
  late DateTime joinedAtDate;

  ///* Loyalty level of the buyer.
  late int loyaltyLevel;

  UniPayCustomerInfo({
    required this.fullName,
    required this.phoneNumber,
    this.email = "",
    required this.address,
    DateTime? joinedAtDate,
    this.loyaltyLevel = 0,
  }) : joinedAtDate = joinedAtDate ?? DateTime.now();

  UniPayCustomerInfo.fromJson(Map<String, dynamic> data) {
    fullName = data['fullName'];
    phoneNumber = data['phone_number'];
    email = data['email'];
    address = UniPayAddress.fromJson(data['address']);
    loyaltyLevel = data['loyaltyLevel'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['address'] = address.toJson();
    data['joinedAtDate'] = joinedAtDate.toIso8601String();
    data['loyaltyLevel'] = loyaltyLevel;
    return data;
  }

  @override
  String toString() {
    return 'UniPayCustomerInfo(fullName: $fullName, phoneNumber: $phoneNumber, email: $email, address: $address, joinedAtDate: $joinedAtDate)';
  }

  /// Convert to Tabby Buyer model
  Buyer get tabbyBuyer => Buyer(
        email: email,
        phone: phoneNumber,
        name: fullName,
      );
}
