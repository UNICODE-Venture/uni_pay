import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uni_pay/src/constant/path.dart';
import 'package:uni_pay/src/constant/uni_text.dart';
import 'package:uni_pay/src/core/controllers/uni_pay_controller.dart';
import 'package:uni_pay/src/modules/global/widgets/coupon_field.dart';
import 'package:uni_pay/src/utils/extension.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';
import 'package:uni_pay/src/views/design_system.dart';
import 'package:uni_pay/uni_pay.dart';

import '../../../theme/colors.dart';
import '../../moyasar/views/uni_pay_moyasar_view.dart';
import '../widgets/payment_tile.dart';
import '../widgets/secure_text.dart';

class UniPayPaymentOptionsView extends StatefulWidget {
  /// Child widget to be displayed in the UniPay view under the payment options
  final Widget? child;
  const UniPayPaymentOptionsView({super.key, this.child});

  @override
  State<UniPayPaymentOptionsView> createState() =>
      _UniPayPaymentOptionsViewState();
}

class _UniPayPaymentOptionsViewState extends State<UniPayPaymentOptionsView> {
  @override
  Widget build(BuildContext context) {
    final uniPayDto = UniPayControllers.uniPayData;
    final uniPayTheme = uniPayDto.uniPayThemeData;
    return ValueListenableBuilder(
        valueListenable: UniPayControllers.uniPayPaymentMethods,
        builder: (_, paymentMethod, __) {
          final transactionInfo = uniPayDto.orderInfo.transactionAmount;
          final paymentMethods = uniPayDto.credentials.paymentMethods;
          final couponCredential = uniPayDto.credentials.couponCredential;
          return Scaffold(
            appBar: uniPayTheme.uiType.isModernWithAppBar
                ? UniPayDesignSystem.appBar(
                    title: uniPayTheme.appBarTitle ?? UniPayText.checkout,
                    isFromRoot: true,
                  )
                : null,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.rSp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15.rh,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.rh),
                      child: UniPayDesignSystem.titleSubTitleWidget(
                        title: uniPayTheme.headerTitle ??
                            UniPayText.yourPaymentMethod,
                        subTitle: uniPayTheme.headerSubtitle ??
                            UniPayText.selectYourPaymentMethod,
                      ),
                    ),

                    /// Apple Pay View
                    if (Platform.isIOS && paymentMethods.isApplePay)
                      const UniApplePay(),

                    // Card payment option
                    PaymentOptionTileCard(
                      isSelected: paymentMethod.isCard,
                      paymentMethod: UniPayPaymentMethods.card,
                      title: uniPayTheme.creditCardHeaderTitle,
                    ),

                    // Tabby payment option
                    if (paymentMethods.isTabbyGateway)
                      PaymentOptionTileCard(
                        isSelected: paymentMethod.isTabby,
                        paymentMethod: UniPayPaymentMethods.tabby,
                        title: uniPayTheme.tabbyHeaderTitle,
                      ),

                    // Tamara payment option
                    if (paymentMethods.isTamaraGateway)
                      PaymentOptionTileCard(
                        isSelected: paymentMethod.isTamara,
                        paymentMethod: UniPayPaymentMethods.tamara,
                        title: uniPayTheme.tamaraHeaderTitle,
                      ),

                    // Secure Text with icon
                    const SecureText(),

                    // Child widget
                    if (widget.child != null) ...[widget.child!],

                    // Coupon Code TextField
                    30.hSpace,
                    if (couponCredential != null)
                      UniPayCouponFieldView(couponCredential: couponCredential),
                  ],
                ),
              ),
            ),
            // Pay Now Button
            bottomNavigationBar: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 20.rSp, vertical: 13.rh),
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                  color: UniPayColorsPalletes.greyBorderColor,
                  width: 1.rSp,
                )),
              ),
              child: UniPayDesignSystem.primaryButton(
                isBottomBarButton: true,
                isDisabled: paymentMethod.isNotSpecified,
                title:
                    "${UniPayText.startToPay} ${paymentMethod.payNowAmount(transactionInfo.totalAmount)}",
                trailing: UniPayDesignSystem.imgIcon(
                  "${UniAssetsPath.icons}/sar.png",
                  size: 13.rSp,
                  color: paymentMethod.isNotSpecified
                      ? UniPayColorsPalletes.greyTextColor
                      : UniPayColorsPalletes.white,
                ),
                onPressed: () {
                  // Go to Tamara view
                  if (paymentMethod.isTamara) {
                    context.uniPush(const UniPayTamara(isFromRoot: false));
                  }
                  // Go to Tabby view
                  else if (paymentMethod.isTabby) {
                    context.uniPush(const UniPayTabby(isFromRoot: false));
                  }
                  // Go to Moyasar view
                  else if (paymentMethod.isCard) {
                    context.uniPush(const UniPayCard(isFromRoot: false));
                  }
                },
              ),
            ),
          );
        });
  }
}
