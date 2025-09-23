import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:uni_pay/src/constant/uni_text.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';
import 'package:uni_pay/src/views/design_system.dart';

import '../../constant/path.dart';
import '../../core/controllers/uni_pay_controller.dart';

class PaymentResultView extends StatefulWidget {
  const PaymentResultView({Key? key}) : super(key: key);

  @override
  State<PaymentResultView> createState() => _PaymentResultViewState();
}

class _PaymentResultViewState extends State<PaymentResultView> {
  @override
  void initState() {
    super.initState();
    _setLottieImage();
  }

  LottieComposition? lottieComposition;

//* Loading lottie file
  void _setLottieImage() async {
    AssetLottie assetLottie = AssetLottie(
      UniPayControllers.uniPayStatus.isSuccess
          ? UniAssetsPath.success
          : UniAssetsPath.failed,
      package: UniAssetsPath.packageName,
    );
    lottieComposition = await assetLottie.load();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: UniPayDesignSystem.appBar(
          leading: Container(),
          title: UniPayText.paymentStatus,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //* Icon
            SizedBox(
              width: 100.w,
              height: 40.h,
              child: lottieComposition != null
                  ? Lottie(composition: lottieComposition)
                  : const CircularProgressIndicator.adaptive(),
            ),
            SizedBox(height: 8.h),
            //* Title
            //* Subtitle
          ],
        ));
  }
}
