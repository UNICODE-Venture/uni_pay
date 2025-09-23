import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:moyasar/moyasar.dart';
import 'package:uni_pay/src/modules/tamara/core/models/tamara_snippet.dart';
import 'package:uni_pay/src/utils/extension.dart';

import '../../core/controllers/uni_pay_controller.dart';

class ApiKeys {
  ///* Keys -------------------------------
  static String get tamaraBaseUrl =>
      UniPayControllers.uniPayData.environment.tamaraBaseUrl;

  static String tamaraProductionBaseUrl = "https://api.tamara.co";
  static String tamaraBaseUrlForDev = "https://api-sandbox.tamara.co";
  static String tamaraVerifyOrder = "$tamaraBaseUrl/orders";

  //* Merchant Urls
  static const String uniBaseURl = "https://unicodesolutions.co";
  static const String successUrl = "$uniBaseURl/success";
  static const String failedUrl = "$uniBaseURl/failed";
  static const String cancelUrl = "$uniBaseURl/cancelled";
  static String approved = "approved";
  static String get tamaraCheckoutUrl => "$tamaraBaseUrl/checkout";

  static Map<String, String> get tamaraHeaders => UniPayControllers
      .uniPayData.credentials.tamaraCredential!.token.tamaraHeaders;

  ///* Process payment --------------------------------
  static PaymentConfig get moyasarPaymentConfig {
    final uniPayData = UniPayControllers.uniPayData;
    PaymentConfig config = PaymentConfig(
      publishableApiKey:
          uniPayData.credentials.moyasarCredential!.publishableKey,
      amount: UniPayControllers
          .uniPayData.orderInfo.transactionAmount.totalAmount.amountInHalala,
      description: uniPayData.orderInfo.description,
      applePay: ApplePayConfig(
        manual: false,
        saveCard: false,
        label: uniPayData.appName,
        merchantId: uniPayData.credentials.applePayMerchantIdentifier,
      ),
      metadata:
          uniPayData.metaData ?? {"orderId": uniPayData.orderInfo.orderId},
    );
    return config;
  }

  ///* Web view options
  static InAppWebViewSettings webViewGroupOptions = InAppWebViewSettings(
    disableDefaultErrorPage: true,
    useShouldOverrideUrlLoading: true,
    cacheEnabled: false,
    applePayAPIEnabled: true,
    allowsInlineMediaPlayback: true,
  );
  // InAppWebViewGroupOptions =>    InAppWebViewGroupOptions(
  //   crossPlatform: InAppWebViewOptions(
  //       useShouldOverrideUrlLoading: true, cacheEnabled: false),
  //   android: AndroidInAppWebViewOptions(disableDefaultErrorPage: true),
  //   ios: IOSInAppWebViewOptions(
  //       applePayAPIEnabled: true, allowsInlineMediaPlayback: true),
  // );

  ///* Moyasar
  static String moyasarBaseUrl = "https://api.moyasar.com/v1";
  static String moyasarPaymentsUrl = "$moyasarBaseUrl/payments";

  ///  ------------ Tabby ---------------- ///
  /// Get the tabby base Url
  static String tabbyBaseUrl = "https://api.tabby.ai/api/v1";

  /// Get the tabby payments Url
  static String tabbyPaymentsUrl = "$tabbyBaseUrl/payments";

  /// Get the tabby payment Url by [ID]
  static Uri tabbyPaymentUrlById(String trxnId) =>
      Uri.parse("$tabbyPaymentsUrl/$trxnId");

  /// Get the tabby capture Url
  static Uri tabbyCaptureUrl(String trxnId) =>
      Uri.parse("$tabbyPaymentsUrl/$trxnId/captures");

  /// Get the Tamara campaign CDN
  static WebUri tamaraCampaignCDN(TamaraSnippet campaign,
          [bool isFromCheckout = false]) =>
      WebUri(
          "https://cdn-sandbox.tamara.co/widget-v2/tamara-widget.html?lang=${campaign.locale.code}&public_key=${campaign.psKey}&country=${campaign.countryCode}&amount=${campaign.transactionAmount.formattedValue}&inline_type=${isFromCheckout ? 2 : 3}");
}
