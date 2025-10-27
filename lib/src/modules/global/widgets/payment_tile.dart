import 'package:flutter/material.dart';
import 'package:uni_pay/src/core/controllers/uni_pay_controller.dart';
import 'package:uni_pay/src/theme/colors.dart';
import 'package:uni_pay/src/utils/extension.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';

import '../../../constant/path.dart';
import '../../../utils/uni_enums.dart';

class PaymentOptionTileCard extends StatelessWidget {
  final bool isSelected;
  final VoidCallback? onSelect;
  final UniPayPaymentMethods paymentMethod;
  final String? title;

  const PaymentOptionTileCard({
    super.key,
    this.isSelected = false,
    this.onSelect,
    required this.paymentMethod,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect ??
          () {
            UniPayControllers.changePaymentMethod(paymentMethod);
          },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 15.rSp, vertical: 9.rSp),
        decoration: BoxDecoration(
          borderRadius: 10.rSp.br,
          border: Border.all(
            width: 1.5.rSp,
            color: isSelected
                ? UniPayColorsPalletes.cyan
                : UniPayColorsPalletes.greyColor5,
          ),
        ),
        child: Row(
          spacing: 10.rw,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: 22.rSp,
              width: 22.rSp,
              decoration: BoxDecoration(
                border: isSelected
                    ? Border.all(width: 6.rSp, color: UniPayColorsPalletes.cyan)
                    : null,
                shape: BoxShape.circle,
                color: isSelected
                    ? UniPayColorsPalletes.white
                    : UniPayColorsPalletes.greyColor5,
              ),
            ),
            Expanded(
              child: Text(
                title ?? paymentMethod.title,
                style: UniPayTheme.uniPayStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.5.rSp,
                  color: UniPayColorsPalletes.grayTextColor,
                ),
              ),
            ),
            5.hSpace,
            Image.asset(
              paymentMethod.icon,
              fit: BoxFit.contain,
              width: paymentMethod.isBNPL
                  ? 50.rw
                  : paymentMethod.isApplePay
                      ? 35.rw
                      : 95.rw,
              height: 35.rh,
              package: UniAssetsPath.packageName,
            ),
          ],
        ),
      ),
    );
  }
}
