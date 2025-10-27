import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uni_pay/src/constant/uni_text.dart';
import 'package:uni_pay/src/core/keys/api_keys.dart';
import 'package:uni_pay/src/modules/tamara/core/models/tamara_callback.dart';
import 'package:uni_pay/src/utils/extension.dart';
import 'package:uni_pay/src/utils/utils.dart';
import 'package:uni_pay/uni_pay.dart';

import '../../../../core/controllers/uni_pay_controller.dart';

import 'package:http/http.dart' as http_client;

class UniTamara {
  UniTamara._();
  static ValueNotifier<UniPayCurrentState> currentStateNotifier =
      ValueNotifier(UniPayCurrentState.loading);

  ///* Generate checkout urls for tamara
  static Future<TamaraCheckoutData> generateTamaraCheckoutUrls(
      UniPayData uniPayData) async {
    final order = uniPayData.orderInfo;
    final customer = uniPayData.customerInfo;
    TamaraData tamaraData = TamaraData(
      orderReferenceId: order.orderId,
      totalAmount: TotalAmount(
        amount: order.transactionAmount.totalAmount,
        currency: order.transactionAmount.currency.currencyCode,
      ),
      description: order.description,
      countryCode: uniPayData.customerInfo.address.country.countryCode,
      locale: uniPayData.locale.localeCode,
      items: order.items
          .map((item) => Items(
                referenceId: item.id,
                type: item.itemType,
                name: item.name,
                sku: item.sku,
                quantity: item.quantity,
                totalAmount: TotalAmount(
                  amount: item.totalPrice,
                  currency: order.transactionAmount.currency.currencyCode,
                ),
              ))
          .toList(),
      consumer: ConsumerModel(
        firstName: customer.fullName.firstName,
        lastName: customer.fullName.lastName,
        phoneNumber: customer.phoneNumber,
        email: customer.email,
      ),
      shippingAddress: ShippingAddress(
        firstName: customer.fullName.firstName,
        lastName: customer.fullName.lastName,
        line1: customer.address.addressName,
        city: customer.address.city,
        countryCode: customer.address.country.countryCode,
      ),
      taxAmount: TaxAmount(
        amount: order.transactionAmount.totalAmount.vat.formattedString,
        currency: order.transactionAmount.currency.currencyCode,
      ),
      shippingAmount: ShippingAmount(
        amount: order.transactionAmount.totalAmount.formattedString,
        currency: order.transactionAmount.currency.currencyCode,
      ),
      merchantUrl: uniPayData.credentials.tamaraCredential!.merchantUrl,
      additionalData: uniPayData.metaData,
    );

    TamaraCheckoutData checkout =
        await UniTamara.tamaraCheckout(tamaraData, uniPayData);
    return checkout;
  }

  ///* Call tamara checkout
  static Future<TamaraCheckoutData> tamaraCheckout(
      TamaraData tamaraData, UniPayData uniPayData) async {
    TamaraCheckoutData checkout = TamaraCheckoutData();
    try {
      String data = jsonEncode(tamaraData.toJson());
      uniLog(tamaraData.toJson());
      http_client.Response response = await http_client.post(
        Uri.parse(ApiKeys.tamaraCheckoutUrl),
        headers: ApiKeys.tamaraHeaders,
        body: data,
      );
      uniLog(
          "${ApiKeys.tamaraCheckoutUrl} - ${ApiKeys.tamaraHeaders}---> ${response.body}");
      final responseBody = json.decode(response.body);
      if (response.statusCode.isSuccess) {
        checkout = TamaraCheckoutData.fromJson(responseBody);
        // if (checkout.checkoutUrl.isNotEmpty) return checkout;
      } else {
        checkout.errorMessage =
            responseBody["message"] ?? UniPayText.somethingWentWrong;
        checkout.errors = responseBody["errors"] ?? "";
      }
    } on HttpException catch (e) {
      uniPrint(e.message);
    }

    return checkout;
  }

  ///* Process the Tamara payment
  static void processTamaraPayment(
    BuildContext context,
    UniPayStatus status, {
    String? transactionId,
    bool isFromRoot = true,
  }) {
    UniPayResponse response = UniPayResponse(status: status);
    //* Success
    if (status.isSuccess) {
      response.transactionDetails.type = UniPayPaymentMethods.tamara;
      response.transactionId = transactionId ??
          "TAMARA_TRXN_${UniPayControllers.uniPayData.orderInfo.orderId}}";
    }
    UniPayControllers.handlePaymentsResponseAndCallback(
      context,
      response: response,
      isFromRootView: isFromRoot,
      paymentMethod: UniPayPaymentMethods.tamara,
    );
    // //* Cancelled
    // else if (status.isCancelled) {
    //   uniPayProivder.uniPayData.onPaymentFailed.call(response);
    // }
    // //* Failed
    // else {
    //   uniPayProivder.uniPayData.onPaymentFailed.call(response);
    // }
  }

  ///* Authorise tamara order
  static Future<TamaraCallBackResponse> authoriseAndCaptureTamaraOrder({
    required TamaraCallBackResponse tamaraCallBackResponse,
    required bool captureOrder,
  }) async {
    http_client.Response response = await http_client.post(
      Uri.parse(
          "${ApiKeys.tamaraVerifyOrder}/${tamaraCallBackResponse.orderId}/authorise"),
      headers: ApiKeys.tamaraHeaders,
    );

    uniPrint("Autorise called with: ${response.body}");

    if (response.statusCode.isSuccess) {
      final data = json.decode(response.body);
      String orderId = data["order_id"] ?? "";

      UniPayStatus paymentStatus =
          (orderId.isNotEmpty && orderId == tamaraCallBackResponse.orderId)
              ? UniPayStatus.success
              : UniPayStatus.failed;

      if (captureOrder && paymentStatus.isSuccess) {
        final captureResponse = await UniTamara.captureOrder(
            tamaraCallBackResponse.tamaraCaptureOrder);
        paymentStatus = captureResponse.paymentStatus;
      }
      tamaraCallBackResponse.paymentStatus = paymentStatus;
    } else {
      tamaraCallBackResponse.paymentStatus = UniPayStatus.failed;
    }

    return tamaraCallBackResponse;
  }

  ///* Capture order
  static Future<TamaraCaptureOrderResponse> captureOrder(
      TamaraCaptureOrder tamaraCaptureOrder) async {
    TamaraCaptureOrderResponse captureOrderResponse =
        TamaraCaptureOrderResponse();

    try {
      String bodyData = json.encode(tamaraCaptureOrder.toJson());
      http_client.Response response = await http_client.post(
        Uri.parse(tamaraCaptureOrder.environment.tamaraCapturePayment),
        headers: tamaraCaptureOrder.tamaraToken.tamaraHeaders,
        body: bodyData,
      );
      final data = json.decode(response.body);
      if (response.statusCode.isSuccess) {
        String orderId = data["order_id"] ?? "";
        bool isSuccess =
            orderId.isNotEmpty && orderId == tamaraCaptureOrder.orderId;

        captureOrderResponse =
            TamaraCaptureOrderResponse.fromJson(data, isSuccess);
      } else {
        captureOrderResponse.message = data["message"] ?? "";
      }
    } catch (e) {
      captureOrderResponse.message = e.toString();
    }
    uniPrint("Capture called ${captureOrderResponse.toJson()}");
    return captureOrderResponse;
  }

  ///* Get order information
  static Future<UniPayResponse> getTransactionInfo(
      TamaraApiData tamaraApiData) async {
    UniPayResponse uniPayResponse =
        UniPayResponse(status: UniPayStatus.notFound);

    try {
      http_client.Response response = await http_client.get(
        Uri.parse(tamaraApiData.environment
            .tamaraTransactionApi(tamaraApiData.orderId)),
        headers: tamaraApiData.tamaraToken.tamaraHeaders,
      );
      final data = json.decode(response.body);
      uniLog("Saif got this data -------->$data");
      if (response.statusCode.isSuccess) {
        uniPayResponse = UniPayResponse.fromTamara(data, tamaraApiData.orderId);
      } else {
        uniPayResponse.errorMessage = data["message"] ?? "No order found!";
      }
    } catch (e) {
      uniPayResponse.errorMessage = e.toString();
    }

    uniLog("Get transaction called ${uniPayResponse.toMap()}");
    return uniPayResponse;
  }

  ///* CDN of payment
  static String getTamaraCDN({
    required num price,
    required UniPayLocale locale,
  }) {
    return "https://cdn.tamara.co/widget/tamara-introduction.html?lang=${locale.name}&price=$price&currency=SAR&countryCode=SA&colorType=default&showBorder=true&paymentType=installment&numberOfInstallments=3&disableInstallment=false&disablePaylater=true&widgetType=product-widget";
  }
}
