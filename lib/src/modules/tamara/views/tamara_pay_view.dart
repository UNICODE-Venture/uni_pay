import 'package:flutter/material.dart';
import 'package:uni_pay/src/constant/uni_text.dart';
import 'package:uni_pay/src/modules/tamara/views/widget/tamara_checkout_view.dart';
import 'package:uni_pay/src/views/design_system.dart';
import 'package:uni_pay/uni_pay.dart';

import '../../../core/controllers/uni_pay_controller.dart';
import '../core/models/tamara_urls.dart';

class UniPayTamara extends StatefulWidget {
  /// A view to process payment using Tamara payment gateway
  ///
  /// If you wish to use it as a standalone view,
  ///
  /// then kindly call `UniPayServices.initUniPay()` first before using this widget.

  const UniPayTamara({Key? key, this.isFromRoot = true}) : super(key: key);
  final bool isFromRoot;
  @override
  State<UniPayTamara> createState() => _UniPayTamaraState();
}

class _UniPayTamaraState extends State<UniPayTamara> {
  @override
  void initState() {
    UniPayControllers.initTamaraPay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UniPayDesignSystem.appBar(
          title: UniPayText.checkoutByTamara, isFromRoot: widget.isFromRoot),
      body: ValueListenableBuilder(
        valueListenable: UniPayControllers.tamaraNotifier,
        builder: (_, status, __) {
          final tamaraCheckout = UniPayControllers.tamaraCheckout;
          if (status.isLoading) {
            return UniPayDesignSystem.loadingIndicator();
          } else if (status.isSuccess && tamaraCheckout.isSuccess) {
            final tamaraCredential =
                UniPayControllers.uniPayData.credentials.tamaraCredential!;
            final merchantUrls = tamaraCredential.merchantUrl;
            return TamaraCheckoutView(
              tamaraUrls: TamaraUrls(
                checkoutUrl: tamaraCheckout.checkoutUrl,
                successUrl: merchantUrls.success,
                failedUrl: merchantUrls.failure,
                cancelUrl: merchantUrls.cancel,
                authoriseOrder: tamaraCredential.authoriseOrder,
                captureOrder: tamaraCredential.captureOrder,
              ),
              onPaymentSuccess: (order) {
                UniTamara.processTamaraPayment(
                  context,
                  UniPayStatus.success,
                  transactionId: order.orderId,
                  isFromRoot: widget.isFromRoot,
                );
              },
              onPaymentFailed: () {
                UniTamara.processTamaraPayment(
                  context,
                  UniPayStatus.failed,
                  isFromRoot: widget.isFromRoot,
                );
              },
              onPaymentCanceled: () {
                UniTamara.processTamaraPayment(
                  context,
                  UniPayStatus.cancelled,
                  isFromRoot: widget.isFromRoot,
                );
              },
            );
          } else {
            return UniPayDesignSystem.errorView(
              title: UniPayText.paymentFailedByTamara,
            );
          }
        },
      ),
    );
  }
}
