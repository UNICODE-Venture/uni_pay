import 'package:flutter/material.dart';
import 'package:tabby_flutter_inapp_sdk_fork/tabby_flutter_inapp_sdk_fork.dart';
import 'package:uni_pay/src/constant/uni_text.dart';
import 'package:uni_pay/src/views/design_system.dart';
import 'package:uni_pay/uni_pay.dart';

import '../../../core/controllers/uni_pay_controller.dart';

class UniPayTabby extends StatefulWidget {
  /// A view to process payment using Tabby payment gateway
  ///
  /// If you wish to use it as a standalone view,
  ///
  /// then kindly call `UniPayServices.initUniPay()` first before using this widget.

  const UniPayTabby({Key? key, this.isFromRoot = true}) : super(key: key);
  final bool isFromRoot;

  @override
  State<UniPayTabby> createState() => _UniPayTabbyState();
}

class _UniPayTabbyState extends State<UniPayTabby> {
  @override
  void initState() {
    UniPayControllers.initTabbyCheckoutSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UniPayDesignSystem.appBar(
          title: UniPayText.checkoutByTabby, isFromRoot: widget.isFromRoot),
      body: ValueListenableBuilder(
        valueListenable: UniPayControllers.tabbyNotifier,
        builder: (_, status, __) {
          final tabbySession = UniPayControllers.tabbySession;
          if (status.isLoading) {
            return UniPayDesignSystem.loadingIndicator();
          } else if (status.isSuccess && tabbySession != null) {
            return TabbyWebView(
              webUrl: tabbySession.availableProducts.installments?.webUrl ?? "",
              onResult: (WebViewResult resultCode) {
                // Case 1: Payment success
                if (resultCode == WebViewResult.authorized) {
                  UniTabbyServices.processTabbyPayment(
                    context,
                    UniPayStatus.success,
                    transactionId: tabbySession.paymentId,
                    isFromRoot: widget.isFromRoot,
                  );
                }
                // Case 2: Payment canceled
                else if (resultCode == WebViewResult.close ||
                    resultCode == WebViewResult.rejected) {
                  UniTabbyServices.processTabbyPayment(
                    context,
                    UniPayStatus.cancelled,
                    isFromRoot: widget.isFromRoot,
                  );
                }
                // Case 3: Payment failed
                else {
                  UniTabbyServices.processTabbyPayment(
                    context,
                    UniPayStatus.failed,
                    isFromRoot: widget.isFromRoot,
                  );
                }
              },
            );
          } else {
            return UniPayDesignSystem.errorView(
              title: UniPayText.tabbyErrorMsg,
              subTitle: UniPayText.somethingWentWrong,
            );
          }
        },
      ),
    );
  }
}
