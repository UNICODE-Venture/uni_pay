import 'package:uni_pay/uni_pay.dart';

class TamaraData {
  late String orderReferenceId;
  late TotalAmount totalAmount;

  late String description;
  late String countryCode;
  late String paymentType;
  late String locale;

  late List<Items> items;
  late ConsumerModel consumer;
  late ShippingAddress shippingAddress;
  late TaxAmount taxAmount;
  late ShippingAmount shippingAmount;
  late MerchantUrl merchantUrl;
  Map<String, dynamic>? additionalData;

  TamaraData({
    required this.orderReferenceId,
    required this.totalAmount,
    required this.description,
    required this.countryCode,
    this.paymentType = "PAY_BY_INSTALMENTS",
    required this.locale,
    required this.items,
    required this.consumer,
    required this.shippingAddress,
    required this.taxAmount,
    required this.shippingAmount,
    required this.merchantUrl,
    this.additionalData,
  });

  TamaraData.fromJson(Map<String, dynamic> json) {
    orderReferenceId = json['order_reference_id'];
    totalAmount = TotalAmount.fromJson(json['total_amount']);
    description = json['description'];
    countryCode = json['country_code'];
    paymentType = json['payment_type'];
    locale = json['locale'];
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
    consumer = ConsumerModel.fromJson(json['consumer']);
    shippingAddress = ShippingAddress.fromJson(json['shipping_address']);
    taxAmount = TaxAmount.fromJson(json['tax_amount']);
    shippingAmount = ShippingAmount.fromJson(json['shipping_amount']);
    merchantUrl = MerchantUrl.fromJson(json['merchant_url']);
    additionalData = json['additional_data'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['order_reference_id'] = orderReferenceId;
    data['total_amount'] = totalAmount.toJson();
    data['description'] = description;
    data['country_code'] = countryCode;
    data['payment_type'] = paymentType;
    data['locale'] = locale;
    data['items'] = items.map((e) => e.toJson()).toList();
    data['consumer'] = consumer.toJson();
    data['shipping_address'] = shippingAddress.toJson();
    data['tax_amount'] = taxAmount.toJson();
    data['shipping_amount'] = shippingAmount.toJson();
    data['merchant_url'] = merchantUrl.toJson();
    if (additionalData != null) data['additional_data'] = additionalData;
    return data;
  }
}

class TotalAmount {
  late final num amount;
  String currency = "SAR";
  TotalAmount({
    required this.amount,
    this.currency = "SAR",
  });

  TotalAmount.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currency = json['currency'] ?? "SAR";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['amount'] = amount;
    data['currency'] = currency;
    return data;
  }
}

class Items {
  late String referenceId;
  late String type;
  late String name;
  late String sku;
  late int quantity;
  late TotalAmount totalAmount;
  Items({
    required this.referenceId,
    required this.type,
    required this.name,
    required this.sku,
    required this.quantity,
    required this.totalAmount,
  });

  Items.fromJson(Map<String, dynamic> json) {
    referenceId = json['reference_id'];
    type = json['type'];
    name = json['name'];
    sku = json['sku'];
    quantity = json['quantity'];
    totalAmount = TotalAmount.fromJson(json['total_amount']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['reference_id'] = referenceId;
    data['type'] = type;
    data['name'] = name;
    data['sku'] = sku;
    data['quantity'] = quantity;
    data['total_amount'] = totalAmount.toJson();
    return data;
  }
}

class ConsumerModel {
  late String firstName;
  late String lastName;
  late String phoneNumber;
  late String email;
  ConsumerModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
  });

  ConsumerModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    return data;
  }
}

class ShippingAddress {
  late String firstName;
  late String lastName;
  late String line1;
  late String city;
  late String countryCode;
  ShippingAddress({
    required this.firstName,
    required this.lastName,
    required this.line1,
    required this.city,
    required this.countryCode,
  });

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    line1 = json['line1'];
    city = json['city'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['line1'] = line1;
    data['city'] = city;
    data['country_code'] = countryCode;
    return data;
  }
}

class TaxAmount {
  late String amount;
  String currency = "SAR";
  TaxAmount({
    required this.amount,
    this.currency = "SAR",
  });

  TaxAmount.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['amount'] = amount;
    data['currency'] = currency;
    return data;
  }
}

class ShippingAmount {
  late String amount;
  String currency = "SAR";

  ShippingAmount({
    required this.amount,
    this.currency = "SAR",
  });

  ShippingAmount.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['amount'] = amount;
    data['currency'] = currency;
    return data;
  }
}
