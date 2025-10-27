// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:uni_pay/src/utils/extension.dart';
import 'package:uni_pay/uni_pay.dart';

import '../../views/widgets/payment_result_view.dart';

class UniPayControllers {
  UniPayControllers._();
  static late BuildContext context;

  /// Here the payement related data will be stored
  static UniPayData? _uniPayData;

  ///* Uni Pay Data to be used for payment request
  static UniPayData get uniPayData {
    if (_uniPayData == null) {
      throw Exception(
          "UniPay has not been initialized yet! kindly call UniPayServices.initUniPay() or pass the required data to widget you're calling first to proceed the payment ;)");
    }
    return _uniPayData!;
  }

  ///* Set UniPayData
  static void setUniPayData(
    UniPayData data,
    BuildContext appContext, {
    bool isInitTabbySdk = true,
  }) {
    _uniPayData = data;
    context = appContext;

    // Initialize Tabby SDK
    if (isInitTabbySdk && data.credentials.paymentMethods.isTabbyGateway) {
      UniTabbyServices.initTabbySDK(
        data.credentials.tabbyCredential,
        env: data.environment.tabbyEnv,
      );
    }

    // Coupon default visibility
    if (data.credentials.couponCredential != null) {
      toggleCouponFieldStatus(
          data.credentials.couponCredential!.isCouponFieldDefaultOpen);
    }
  }

  ///* Initialize Tamara all payment methods
  static ValueNotifier<UniPayCurrentState> tamaraNotifier =
      ValueNotifier<UniPayCurrentState>(UniPayCurrentState.notSpecified);

  ///* Tamara checkout data
  static TamaraCheckoutData tamaraCheckout = TamaraCheckoutData();
  static Future<TamaraCheckoutData?> initTamaraPay() async {
    tamaraNotifier.value = UniPayCurrentState.loading;

    //* Check for Tamara checkout
    tamaraCheckout = await UniTamara.generateTamaraCheckoutUrls(uniPayData);
    //* Check for Moyasar gateway
    tamaraNotifier.value = tamaraCheckout.isSuccess
        ? UniPayCurrentState.success
        : UniPayCurrentState.failed;
    return tamaraCheckout;
  }

  ///* State changes
  UniPayCurrentState uniPayCurrentState = UniPayCurrentState.notSpecified;

  ///* Uni Pay payment status
  static UniPayStatus uniPayStatus = UniPayStatus.failed;

  ///* Handle and call the callback function for payment status
  static Future handlePaymentsResponseAndCallback(
    BuildContext context, {
    required UniPayResponse response,
    bool isFromApplePay = false,
    bool isFromRootView = false,
    required UniPayPaymentMethods paymentMethod,
  }) async {
    uniPayStatus = response.status;

    if (!isFromApplePay) {
      // Navigate to payment result view
      context
          .uniPushReplacement(PaymentResultView(paymentMethod: paymentMethod));
      await Future.delayed(const Duration(seconds: 2));

      /// Pop the payment result view and go back to the previous screen
      // UniPayControllers.context.uniParentPop();
      // On success go back to the app screen

      if (uniPayStatus.isSuccess) {
        UniPayControllers.context.uniParentPop();
      }
      // On failed go back to the payment screen again!
      else {
        if (isFromRootView) {
          UniPayControllers.context.uniParentPop();
        } else {
          uniStateKey.currentContext?.uniParentPop();
        }
      }
    }

    //* Success
    if (response.status.isSuccess) {
      uniPayData.onPaymentSucess.call(response);
    }
    //* Failed
    else {
      uniPayData.onPaymentFailed.call(response);
    }
  }

  ///* Payment Methods
  static ValueNotifier<UniPayPaymentMethods> uniPayPaymentMethods =
      ValueNotifier(UniPayPaymentMethods.notSpecified);
  static void changePaymentMethod(UniPayPaymentMethods paymentMethod) {
    if (uniPayPaymentMethods.value != paymentMethod) {
      uniPayPaymentMethods.value = paymentMethod;
    } else {
      uniPayPaymentMethods.value = UniPayPaymentMethods.notSpecified;
    }
  }

  ///* Initialize Tamara all payment methods
  static ValueNotifier<UniPayCurrentState> tabbyNotifier =
      ValueNotifier<UniPayCurrentState>(UniPayCurrentState.notSpecified);

  ///* Tamara checkout data
  static TabbySessionData? tabbySession;
  static Future<TabbySessionData?> initTabbyCheckoutSession() async {
    tabbyNotifier.value = UniPayCurrentState.loading;

    // Create Tabby session
    tabbySession = await UniTabbyServices.createTabbySession(uniPayData);
    tabbyNotifier.value = tabbySession != null
        ? UniPayCurrentState.success
        : UniPayCurrentState.failed;
    return tabbySession;
  }

  // ------------- Coupon Code Management ------------- //
  static final couponTextController = TextEditingController();
  static ValueNotifier<bool> isCouponFieldVisible = ValueNotifier(false);

  ///  Change coupon field visibility
  static toggleCouponFieldStatus(bool isDefaultOpn) {
    if (isCouponFieldVisible.value != isDefaultOpn) {
      isCouponFieldVisible.value = isDefaultOpn;
    }
  }
}
