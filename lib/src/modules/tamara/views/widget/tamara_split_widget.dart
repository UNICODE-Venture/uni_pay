import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';
import 'package:uni_pay/src/views/widgets/payment_options_widget.dart';
import 'package:uni_pay/uni_pay.dart';

import '../../../../constant/uni_text.dart';
import '../../../../core/controllers/web_view_controller.dart';

class TamaraSplitPlanWidget extends StatelessWidget {
  final WidgetData widgetData;

  const TamaraSplitPlanWidget({Key? key, required this.widgetData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSizes.init(context);
    UniPayText.isEnglish = widgetData.locale.isEnglish;
    return UniPaymentOptionWidget(
      title: UniPayText.tamaraSplitBill(widgetData.installment!),
      subTitle: UniPayText.tamaraSplitBillSubTitle,
      image: "tamara",
      currentStatus: widgetData.currentStatus,
      onChange: widgetData.onChange,
      activeColor: widgetData.activeColor,
      uniPayPaymentMethods: UniPayPaymentMethods.tamara,
      onLearnMorePressed: () {
        WebViewController.openBrowserPopUp(
          url: WebUri(
            UniTamara.getTamaraCDN(
                price: widgetData.totalAmount ?? 0, locale: widgetData.locale),
          ),
        );
      },
    );
  }
}
