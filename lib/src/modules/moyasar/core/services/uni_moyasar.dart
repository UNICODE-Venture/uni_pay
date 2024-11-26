import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http_client;
import 'package:moyasar/moyasar.dart';
import 'package:uni_pay/src/constant/uni_text.dart';
import 'package:uni_pay/src/utils/extension.dart';
import 'package:uni_pay/uni_pay.dart';

import '../../../../core/controllers/uni_pay_controller.dart';
import '../../../../core/keys/api_keys.dart';
import '../../../../utils/utils.dart';

class UniPayMoyasarGateway {
  UniPayMoyasarGateway._();

  ///* Process the moyasar payment
  static Future processMoyasarPayment(BuildContext context,
      {required dynamic result, bool isFromApplePay = false}) async {
    if (result is! PaymentCanceledError) {
      UniPayResponse uniPayResponse = UniPayResponse();
      if (result is PaymentResponse) {
        uniLog(result.status);
        if (result.status == PaymentStatus.paid) {
          uniPayResponse.transactionId = result.id;
          uniPayResponse.amount = result.amount.halalaToAmount;
          uniPayResponse.fee = result.fee.halalaToAmount;
          uniPayResponse.status = UniPayStatus.success;
          uniPayResponse.amountFormatted = result.amountFormat;
          uniPayResponse.ip = result.ip ?? "N/A";
          uniPayResponse.createdAt = result.createdAt;
          uniPayResponse.invoiceId = result.invoiceId ?? "N/A";
          uniPayResponse.description = result.description ?? "N/A";
          UniPayTransactionDetails transactionDetails =
              UniPayTransactionDetails();
          //* Card pay
          final source = result.source;
          if (source is CardPaymentResponseSource) {
            transactionDetails.type = UniPayPaymentMethods.card;
            transactionDetails.name = source.name;
            transactionDetails.cardType = source.company.name.cardType;
            transactionDetails.cardNumber = source.number;
            transactionDetails.message = source.message ?? "";
            transactionDetails.gatewayId = source.gatewayId;
            transactionDetails.referenceNumber = source.referenceNumber ?? "";
          }
          //* Apple pay
          else if (source is ApplePayPaymentResponseSource) {
            transactionDetails.type = UniPayPaymentMethods.applePay;
            transactionDetails.name = UniPayPaymentMethods.applePay.name;
            transactionDetails.cardType = UniPayCardType.mada;
            transactionDetails.cardNumber = source.number;
            transactionDetails.message = source.message ?? "";
            transactionDetails.gatewayId = source.gatewayId;
            transactionDetails.referenceNumber = source.referenceNumber ?? "";
          }
          uniPayResponse.transactionDetails = transactionDetails;
        } else {
          uniPayResponse.status = UniPayStatus.failed;
          uniPayResponse.errorMessage = UniPayText.paymentFailed;
        }
      } else if (result is ValidationError) {
        uniPayResponse.status = UniPayStatus.failed;
        uniPayResponse.transactionDetails.message = result.message;
        uniPayResponse.errorMessage = UniPayText.paymentFailed;
      }

      return UniPayControllers.handlePaymentsResponseAndCallback(
        context,
        response: uniPayResponse,
        isFromApplePay: isFromApplePay,
      );
    }
  }

  ///* Get the payment by meta-data
  static Future<UniPayResponse> searchPaymentByMetaData({
    required MoyasarCredential credential,
    required String orderId,
  }) async {
    UniPayResponse uniPayResponse = UniPayResponse(
      status: UniPayStatus.failed,
      errorMessage: UniPayText.noTransactionFound,
    );
    try {
      Uri paymentVerifyUrl = Uri.parse(
          "${ApiKeys.moyasarPaymentsUrl}/?metadata[orderId]=$orderId");

      Map<String, String> headerData = {
        "authorization": credential.moyasarAuthKey
      };
      http_client.Response response =
          await http_client.get(paymentVerifyUrl, headers: headerData);
      Map<String, dynamic> responseData = json.decode(response.body) ?? {};
      if (responseData["payments"] != null &&
          responseData["payments"].isNotEmpty) {
        uniPayResponse = UniPayResponse.fromMap(responseData["payments"].first);
      } else {
        uniPayResponse.errorMessage =
            responseData["message"] ?? UniPayText.noTransactionFound;
      }
    } catch (e) {
      uniPayResponse.errorMessage = e.toString();
    }
    return uniPayResponse;
  }
}
