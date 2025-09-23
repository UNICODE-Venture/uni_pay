import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:uni_pay/src/core/controllers/uni_pay_controller.dart';
import 'package:uni_pay/src/utils/extension.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';
import 'package:uni_pay/uni_pay.dart';

import '../constant/uni_text.dart';
import '../theme/colors.dart';

class UniPayDesignSystem {
  ///* Appbar for UniPay
  static AppBar appBar({
    required String title,
    Widget? leading,
    List<Widget> actions = const [],
    PreferredSizeWidget? bottom,
    bool isFromRoot = false,
  }) =>
      AppBar(
        elevation: 0,
        leading: leading ??
            BackButton(
              color: UniPayColorsPalletes.black,
              onPressed: () {
                if (isFromRoot) {
                  UniPayControllers.context.uniPop();
                } else {
                  uniStateKey.currentContext?.uniPop();
                }
              },
            ),
        flexibleSpace: GlassMorphism(
          sigmaVal: 5,
          child: Container(color: UniPayColorsPalletes.transparent),
        ),
        backgroundColor: UniPayColorsPalletes.white.withAlpha(100),
        title: Text(
          title,
          style: UniPayTheme.uniPayStyle.copyWith(
            color: UniPayColorsPalletes.black,
            fontWeight: FontWeight.bold,
            fontSize: 16.rSp,
          ),
        ),
        actions: actions,
        centerTitle: true,
        bottom: bottom,
      );

  ///* Loading Indicator
  static Widget loadingIndicator() => const Center(
        child: CircularProgressIndicator.adaptive(),
      );

  ///* Error View
  static Widget errorView({String? title, dynamic subTitle}) => Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title ?? UniPayText.somethingWentWrong,
              style: UniPayTheme.uniPayStyle,
              textAlign: TextAlign.center,
            ),
            if (subTitle != null) ...[
              10.vs,
              Text(
                subTitle.toString(),
                textAlign: TextAlign.center,
                style: UniPayTheme.uniPayStyle.copyWith(
                  color: UniPayColorsPalletes.greyTextColor,
                ),
              )
            ]
          ],
        ),
      );

  ///* Radio button checkbox
  static Widget checkBox({
    required bool status,
    ValueChanged<bool>? onChange,
    required Color activeColor,
  }) =>
      Transform.scale(
        scale: 1.5,
        child: Checkbox(
          activeColor: activeColor,
          value: status,
          shape: const CircleBorder(),
          side: BorderSide(color: Colors.grey.colorOpacity(0.3)),
          onChanged: (v) => onChange?.call(v ?? false),
          overlayColor: UniPayColorsPalletes.transparentMaterialColor,
        ),
      );

  ///* Primary button
  static Widget primaryButton(
      {required String title,
      VoidCallback? onPressed,
      bool showLoading = false,
      bool isDisabled = false,
      double? width,
      double? height,
      double marginBottom = 0,
      bool isBottomBarButton = false,
      Color backgroundColor = UniPayColorsPalletes.primaryColor}) {
    bool isButtonDisabled = (isDisabled || showLoading);
    return InkWell(
      onTap: isButtonDisabled ? null : onPressed,
      child: Container(
        width: width ?? 100.w,
        height: height ?? 50.rSp,
        margin:
            EdgeInsets.only(bottom: isBottomBarButton ? 25.rh : marginBottom),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isButtonDisabled
              ? UniPayColorsPalletes.fillColor
              : backgroundColor,
          borderRadius: 10.br,
        ),
        child: Visibility(
          visible: showLoading,
          replacement: Text(title,
              style: UniPayTheme.uniPayStyle.copyWith(
                  color: isButtonDisabled
                      ? UniPayColorsPalletes.greyTextColor
                      : UniPayColorsPalletes.white)),
          child: UniPayDesignSystem.loadingIndicator(),
        ),
      ),
    );
  }
}

class GlassMorphism extends StatelessWidget {
  final Widget child;
  final double sigmaVal;
  const GlassMorphism({Key? key, required this.child, this.sigmaVal = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigmaVal, sigmaY: sigmaVal),
      child: child,
    ));
  }
}

// class UniPayScaffold extends StatelessWidget {
//   final String title;
//   final Widget Function(BuildContext) builder;
//   const UniPayScaffold({Key? key, required this.title, required this.builder})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // extendBodyBehindAppBar: true,
//       appBar: UniPayDesignSystem.appBar(title: title),
//       body: Consumer<UniPayProivder>(
//         builder: (_, provider, __) {
//           if (provider.uniPayCurrentState.isLoading) {
//             return UniPayDesignSystem.loadingIndicator();
//           } else if (provider.uniPayCurrentState.isSuccess) {
//             return builder.call(context);
//           } else {
//             return UniPayDesignSystem.errorView();
//           }
//         },
//       ),
//     );
//   }
// }
