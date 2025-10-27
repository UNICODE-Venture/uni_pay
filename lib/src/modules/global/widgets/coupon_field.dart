import 'package:flutter/material.dart';
import 'package:uni_pay/src/constant/path.dart';
import 'package:uni_pay/src/constant/uni_text.dart';
import 'package:uni_pay/src/core/controllers/uni_pay_controller.dart';
import 'package:uni_pay/src/theme/colors.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';
import 'package:uni_pay/src/utils/utils.dart';
import 'package:uni_pay/src/views/design_system.dart';
import 'package:uni_pay/uni_pay.dart';

import 'text_field.dart';

class UniPayCouponFieldView extends StatefulWidget {
  final CouponCredential couponCredential;
  const UniPayCouponFieldView({super.key, required this.couponCredential});

  @override
  State<UniPayCouponFieldView> createState() => _UniPayCouponFieldViewState();
}

class _UniPayCouponFieldViewState extends State<UniPayCouponFieldView> {
  /// To manage loading state while applying coupon
  bool isCouponLoading = false;

  /// Is the coupon was applied successfully
  bool isCouponApplied = false;

  @override
  void initState() {
    super.initState();
    UniPayControllers.toggleCouponFieldStatus(
        widget.couponCredential.isCouponFieldDefaultOpen);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 13.rh,
      children: [
        InkWell(
          onTap: () {
            UniPayControllers.isCouponFieldVisible.value =
                !UniPayControllers.isCouponFieldVisible.value;
          },
          child: Text(
            UniPayText.doYouHaveCoupon,
            style: UniPayTheme.uniPayStyle.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 13.rSp,
              color: UniPayColorsPalletes.primaryColor,
            ),
          ),
        ),
        ValueListenableBuilder(
            valueListenable: UniPayControllers.isCouponFieldVisible,
            builder: (_, isShow, __) {
              return UniPayDesignSystem.animatedCrossFadeWidget(
                animationStatus: isShow,
                shownIfFalse: const SizedBox(),
                shownIfTrue: ValueListenableBuilder(
                    valueListenable: UniPayControllers.couponTextController,
                    builder: (_, value, __) {
                      bool isTextNotEmpty = value.text.trim().isNotEmpty;
                      bool isTextValid = isTextNotEmpty &&
                          widget.couponCredential.minCouponLength <=
                              value.text.trim().length;
                      return UniPayTextField(
                        enabled: !isCouponApplied,
                        controller: UniPayControllers.couponTextController,
                        onValChange: widget.couponCredential.onCouponValChanged,
                        fillColor: isTextNotEmpty
                            ? UniPayColorsPalletes.white
                            : UniPayColorsPalletes.greyBorderColor,
                        hintText: widget.couponCredential.hintText ??
                            UniPayText.enterCouponCodeHere,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(11.rSp),
                          child: _couponIconWidget('coupon'),
                        ),
                        suffixIcon: TextButton(
                          onPressed: () async {
                            if (isTextValid &&
                                !isCouponLoading &&
                                widget.couponCredential.onCouponApplied !=
                                    null) {
                              setState(() => isCouponLoading = true);
                              bool isApplied = await widget
                                  .couponCredential.onCouponApplied!
                                  .call(value.text.trim());
                              setState(() {
                                isCouponLoading = false;
                                isCouponApplied = isApplied;
                              });

                              uniPrint("Coupon applied: $isCouponApplied");
                            }
                          },
                          child: Visibility(
                            visible: isCouponLoading,
                            replacement:
                                UniPayDesignSystem.animatedCrossFadeWidget(
                              animationStatus: isCouponApplied,
                              shownIfFalse: Text(
                                UniPayText.apply,
                                style: UniPayTheme.uniPayStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.rSp,
                                  color: isCouponApplied
                                      ? UniPayColorsPalletes.cyan
                                      : isTextValid
                                          ? UniPayColorsPalletes.primaryColor
                                          : UniPayColorsPalletes.greyTextColor,
                                ),
                              ),
                              shownIfTrue: _couponIconWidget("check", true),
                            ),
                            child: SizedBox(
                              width: 15.rSp,
                              height: 15.rSp,
                              child: UniPayDesignSystem.loadingIndicator(),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }),
      ],
    );
  }

  Widget _couponIconWidget(String icon, [bool isFromAppliedCoupon = false]) {
    return UniPayDesignSystem.imgIcon(
      '${UniAssetsPath.icons}/$icon.png',
      size: isFromAppliedCoupon ? 20.rSp : 17.rSp,
    );
  }
}
