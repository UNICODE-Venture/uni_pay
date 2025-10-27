import 'package:flutter/material.dart';
import 'package:uni_pay/src/constant/uni_text.dart';
import 'package:uni_pay/src/views/widgets/uni_pay_view_handler.dart';
import 'package:uni_pay/uni_pay.dart';

import '../constant/locale.dart';

import '../core/controllers/uni_pay_controller.dart';
import '../theme/colors.dart';

final uniStateKey = GlobalKey<NavigatorState>();

class UniPay extends StatefulWidget {
  ///* Provide the context of the app
  final BuildContext context;

  ///* Uni Pay Data to be used for payment request
  final UniPayData uniPayData;

  /// Child widget to be displayed in the UniPay view under the payment options
  final Widget? child;

  const UniPay({
    Key? key,
    required this.context,
    required this.uniPayData,
    this.child,
  }) : super(key: key);

  @override
  State<UniPay> createState() => _UniPayState();
}

class _UniPayState extends State<UniPay> {
  @override
  void initState() {
    super.initState();
    UniPayControllers.setUniPayData(widget.uniPayData, widget.context);
  }

  @override
  Widget build(BuildContext context) {
    final uniPayData = widget.uniPayData;
    UniPayText.isEnglish = uniPayData.locale.isEnglish;
    UniPayColorsPalletes.primaryColor = uniPayData.uniPayThemeData.primaryColor;

    return MaterialApp(
      navigatorKey: uniStateKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: LocalizationsData.localizationsDelegate,
      supportedLocales: LocalizationsData.supportLocale,
      theme: UniPayTheme.theme,
      locale: uniPayData.locale.currentLocale,
      home: UniPayViewHandler(child: widget.child),
    );
  }
}
