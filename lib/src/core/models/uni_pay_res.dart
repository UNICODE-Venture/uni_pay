import 'package:uni_pay/src/utils/extension.dart';

import '../../utils/uni_enums.dart';

class UniPayResponse {
  late String transactionId;
  late UniPayStatus status;
  late num amount;
  late num fee;
  UniPayCurrency currency = UniPayCurrency.sar;
  late String description;
  late String amountFormatted;
  late String ip;
  late String createdAt;
  late String invoiceId;
  late UniPayTransactionDetails transactionDetails;
  late String errorMessage;
  late Map<String, dynamic>? metadata;

  UniPayResponse({
    this.transactionId = "",
    this.status = UniPayStatus.notSpecified,
    this.amount = 0,
    this.fee = 0,
    this.description = "",
    this.amountFormatted = "",
    this.ip = "",
    this.createdAt = "",
    this.invoiceId = "",
    this.errorMessage = "",
    UniPayTransactionDetails? transactionDetails,
    this.metadata,
  }) : transactionDetails = transactionDetails ?? UniPayTransactionDetails();

  UniPayResponse.fromMap(Map<String, dynamic> json) {
    transactionId = json['id'] ?? "";
    status = (json['status'] == 'paid' && transactionId.isNotEmpty)
        ? UniPayStatus.success
        : UniPayStatus.failed;

    amount = (json['amount'] ?? 0).toString().toNum.halalaToAmount;
    fee = (json['fee'] ?? 0).toString().toNum.halalaToAmount;
    currency = UniPayCurrency.sar;
    // json['currency'] ?? ""
    description = json['description'] ?? "";
    amountFormatted = json['amount_format'] ?? "0 SAR";
    ip = json['ip'] ?? "N/A";
    createdAt = json['created_at'] ?? "";
    invoiceId = json['invoice_id'] ?? "";
    errorMessage = json['errorMessage'] ?? "";
    transactionDetails = UniPayTransactionDetails.fromMap(json['source'] ?? {});
    metadata = json['metadata'];
  }

  UniPayResponse.fromTamara(Map<String, dynamic> json, String orderId) {
    transactionId = json['order_id'] ?? "";

    amount = (json['total_amount']['amount'] ?? 0).toString().toNum;

    fee = 0;
    currency = UniPayCurrency.sar;

    description = json['description'] ?? "";
    amountFormatted = "$amount SAR";
    ip = "N/A";
    createdAt = json['created_at'] ?? "";
    invoiceId = json['order_number'] ?? "";

    bool isSuccess = transactionId.isNotEmpty && transactionId == orderId;

    status = isSuccess ? UniPayStatus.success : UniPayStatus.notFound;

    errorMessage = "N/A";
    transactionDetails = UniPayTransactionDetails.fromTamara(
        json['order_reference_id'] ?? invoiceId);

    metadata = json['additional_data'];
  }

  Map<String, dynamic> toMap() => {
        'transaction_id': transactionId,
        'paymentStatus': status.index,
        'amount': amount,
        'fee': fee,
        'currency': currency.name,
        'description': description,
        'amount_format': amountFormatted,
        'ip': ip,
        'created_at': createdAt,
        'invoice_id': invoiceId,
        'errorMessage': errorMessage,
        'source': transactionDetails.toMap(),
        'metadata': metadata,
      };
}

class UniPayTransactionDetails {
  late UniPayPaymentMethods type;
  late String name;
  late String cardNumber;
  late UniPayCardType cardType;

  late String message;
  late String gatewayId;
  late String referenceNumber;

  UniPayTransactionDetails({
    this.type = UniPayPaymentMethods.notSpecified,
    this.cardType = UniPayCardType.notSpecified,
    this.name = "",
    this.cardNumber = "",
    this.message = "",
    this.gatewayId = "",
    this.referenceNumber = "",
  });

  UniPayTransactionDetails.fromMap(Map<String, dynamic> json) {
    type = (json['type'] ?? "creditcard").toString().uniPayPaymentMethod;
    cardType = (json['company'] ?? "").toString().cardType;
    name = json['name'] ?? "N/A";
    cardNumber = json['number'] ?? "";
    message = json['message'] ?? "";

    gatewayId = json['gateway_id'] ?? "";
    referenceNumber = json['reference_number'] ?? "";
  }

  UniPayTransactionDetails.fromTamara(this.referenceNumber) {
    type = UniPayPaymentMethods.tamara;
    cardType = UniPayCardType.tamara;
    name = UniPayCardType.tamara.name;
    cardNumber = "N/A";
    message = "N/A";
    gatewayId = "N/A";
  }

  Map<String, dynamic> toMap() => {
        'type': type.name,
        'cardType': cardType.name,
        'name': name,
        'cardNumber': cardNumber,
        'message': message,
        'gateway_id': gatewayId,
        'reference_number': referenceNumber,
      };
}
