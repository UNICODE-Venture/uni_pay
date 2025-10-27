import 'package:flutter/material.dart';
import 'package:uni_pay/src/constant/path.dart';
import 'package:uni_pay/src/constant/uni_text.dart';
import 'package:uni_pay/src/theme/colors.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';
import 'package:uni_pay/src/views/design_system.dart';

class SecureText extends StatelessWidget {
  const SecureText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5.rw,
      children: [
        UniPayDesignSystem.imgIcon(
          "${UniAssetsPath.icons}/secured.png",
          size: 20.rSp,
        ),
        Text(
          UniPayText.cardDataSecured,
          style: UniPayTheme.uniPaySubTitleStyle.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: 12.5.rSp,
            color: UniPayColorsPalletes.greyTextColor,
          ),
        ),
      ],
    );
  }
}
