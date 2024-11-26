import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uni_pay/src/utils/extension.dart';

import '../../uni_pay.dart';
import '../constant/uni_text.dart';
import '../core/controllers/uni_pay_controller.dart';
import '../modules/moyasar/views/moyasar_card_widget.dart';
import '../modules/moyasar/views/uni_pay_moyasar_view.dart';
import 'design_system.dart';

class UniPayGatewayView extends StatefulWidget {
  const UniPayGatewayView({Key? key}) : super(key: key);

  @override
  State<UniPayGatewayView> createState() => _UniPayGatewayViewState();
}

class _UniPayGatewayViewState extends State<UniPayGatewayView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UniPayDesignSystem.appBar(title: UniPayText.checkout),
      body: _allPaymentView(),
    );
  }

  Widget _allPaymentView() {
    return ValueListenableBuilder(
        valueListenable: UniPayControllers.uniPayPaymentMethods,
        builder: (context, uniPayPaymentMethods, __) {
          final transactionInfo =
              UniPayControllers.uniPayData.orderInfo.transactionAmount;
          final paymentMethods =
              UniPayControllers.uniPayData.credentials.paymentMethods;
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Apple Pay View if Platform is IOS
                if (Platform.isIOS) ...[
                  const UniApplePay(),
                  30.vs,
                ],
                // Moyasar View
                CardPaymentWidget(
                  widgetData: WidgetData(
                    currentStatus: uniPayPaymentMethods.isCard,
                    locale: UniPayControllers.uniPayData.locale,
                    onChange: (s) => UniPayControllers.changePaymentMethod(
                        UniPayPaymentMethods.card),
                  ),
                ),

                // Tamara View
                if (paymentMethods.isTamaraGateway) ...[
                  const Divider(),
                  TamaraSplitPlanWidget(
                    widgetData: WidgetData(
                      installment: UniPayControllers
                          .uniPayData.credentials.tamaraCredential?.installment,
                      currentStatus: uniPayPaymentMethods.isTamara,
                      locale: UniPayControllers.uniPayData.locale,
                      totalAmount: UniPayControllers
                          .uniPayData.orderInfo.transactionAmount.totalAmount,
                      onChange: (s) => UniPayControllers.changePaymentMethod(
                          UniPayPaymentMethods.tamara),
                    ),
                  ),
                ],

                // Tabby View

                if (paymentMethods.isTabbyGateway) ...[
                  const Divider(),
                  TabbySplitPlanWidget(
                    widgetData: WidgetData(
                      currentStatus: uniPayPaymentMethods.isTabby,
                      locale: UniPayControllers.uniPayData.locale,
                      totalAmount: UniPayControllers
                          .uniPayData.orderInfo.transactionAmount.totalAmount,
                      onChange: (s) => UniPayControllers.changePaymentMethod(
                          UniPayPaymentMethods.tabby),
                    ),
                  ),
                ],
                const Spacer(),

                // Pay Now Button
                UniPayDesignSystem.primaryButton(
                  isBottomBarButton: true,
                  isDisabled: uniPayPaymentMethods.isNotSpecified,
                  title:
                      "${UniPayText.payNow} (${"${uniPayPaymentMethods.payNowAmount(transactionInfo.totalAmount, UniPayControllers.uniPayData.credentials.tamaraCredential?.installment)} ${transactionInfo.currency.currencyCode}"})",
                  onPressed: () {
                    // Go to Tamara view
                    if (uniPayPaymentMethods.isTamara) {
                      context.uniPush(const UniPayTamara());
                    }
                    // Go to Tabby view
                    else if (uniPayPaymentMethods.isTabby) {
                      context.uniPush(const UniPayTabby());
                    }
                    // Go to Moyasar view
                    else if (uniPayPaymentMethods.isCard) {
                      context.uniPush(const UniPayCard());
                    }
                  },
                ),
              ],
            ),
          );
        });
  }
}
