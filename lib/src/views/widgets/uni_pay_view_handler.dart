import 'package:flutter/material.dart';
import 'package:uni_pay/src/modules/global/views/uni_pay_options_view.dart';
import 'package:uni_pay/src/utils/extension.dart';

import '../../../uni_pay.dart';
import '../../modules/moyasar/views/uni_pay_moyasar_view.dart';

import '../../core/controllers/uni_pay_controller.dart';
import '../../utils/extension/size_extension.dart';
import '../design_system.dart';
import '../uni_pay_all_view.dart';

class UniPayViewHandler extends StatefulWidget {
  /// Child widget to be displayed in the UniPay view under the payment options
  final Widget? child;
  const UniPayViewHandler({Key? key, this.child}) : super(key: key);

  @override
  State<UniPayViewHandler> createState() => _UniPayViewHandlerState();
}

class _UniPayViewHandlerState extends State<UniPayViewHandler> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _viewHandler());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: UniPayDesignSystem.loadingIndicator());
  }

  Future _viewHandler() async {
    ScreenSizes.init(context);

    // Get the payment data
    UniPayData uniPayData = UniPayControllers.uniPayData;

    // Payment methods requested by client
    List<UniPayPaymentMethods> paymentMethods =
        uniPayData.credentials.paymentMethods;

    bool isSingleGatewayPayment = paymentMethods.length == 1;

    // Case 1:  Tamara checkout
    if (isSingleGatewayPayment && paymentMethods.first.isTamara) {
      context.uniPushReplacement(const UniPayTamara());
    }

    // Case 2:  Tabby checkout
    else if (isSingleGatewayPayment && paymentMethods.first.isTabby) {
      context.uniPushReplacement(const UniPayTabby());
    }
    // Case 3: Moyasar checkout
    else if ((isSingleGatewayPayment && paymentMethods.first.isMoyasar) ||
        (paymentMethods.length == 2 &&
            !paymentMethods.isTamaraGateway &&
            !paymentMethods.isTabbyGateway)) {
      context.uniPushReplacement(const UniPayCard());
    }

    // Case 4: Modern UI with all payment methods
    else if (uniPayData.uniPayThemeData.uiType.isModernUI) {
      context.uniPushReplacement(UniPayPaymentOptionsView(child: widget.child));
    }

    // Case 4: All payment methods
    else {
      context.uniPushReplacement(UniPayGatewayView(child: widget.child));
    }
  }
}
