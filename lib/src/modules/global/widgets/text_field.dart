import 'package:flutter/material.dart';
import 'package:uni_pay/src/theme/colors.dart';
import 'package:uni_pay/src/utils/extension.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';
import 'package:uni_pay/src/views/design_system.dart';
import 'package:uni_pay/uni_pay.dart';

class UniPayTextField extends StatefulWidget {
  const UniPayTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.textAlign,
    this.linesNumber = 1,
    this.height,
    this.prefixIcon,
    this.hintText = '',
    this.validationText,
    this.keyboardType = TextInputType.text,
    this.onValChange,
    this.onTap,
    this.focus,
    this.suffixIcon,
    this.isReadOnly = false,
    this.showFocusedBorder = false,
    this.enabled = true,
    this.contentPadding,
    this.fillColor,
    this.textInputAction,
  });

  // Controller for the text field
  final TextEditingController controller;
  final String? labelText;
  final TextAlign? textAlign;
  final int linesNumber;
  final double? height;
  final Widget? prefixIcon;
  final String hintText;
  final String? validationText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onValChange;
  final VoidCallback? onTap;
  final FocusNode? focus;
  final Widget? suffixIcon;
  final bool isReadOnly;
  final bool showFocusedBorder;
  final bool enabled;
  final EdgeInsets? contentPadding;
  final Color? fillColor;
  final TextInputAction? textInputAction;

  @override
  State<UniPayTextField> createState() => _UniPayTextFieldState();
}

class _UniPayTextFieldState extends State<UniPayTextField> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: UniPayDesignSystem.kDefaultDuration,
      decoration: BoxDecoration(
        borderRadius: 10.rSp.br,
        color: widget.focus == null
            ? UniPayColorsPalletes.transparent
            : widget.focus?.hasFocus == true
                ? UniPayColorsPalletes.transparent
                : UniPayColorsPalletes.greyBorderColor,
        border:
            Border.all(color: UniPayColorsPalletes.greyColor5, width: 1.5.rSp),
      ),
      child: ClipRRect(
        borderRadius: 10.rSp.br,
        child: TextFormField(
          onTapOutside: (event) =>
              FocusScope.of(uniStateKey.currentContext!).unfocus(),
          key: widget.key,
          controller: widget.controller,
          focusNode: widget.focus,
          validator: (String? val) {
            return widget.validationText != null &&
                    (widget.controller.value.text.trim() == '')
                ? widget.validationText
                : null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: UniPayTheme.defaultTitle500Style(
            color: widget.enabled
                ? UniPayColorsPalletes.secondaryColor
                : UniPayColorsPalletes.greyColor3,
          ),
          cursorColor: UniPayColorsPalletes.primaryColor,
          readOnly: widget.isReadOnly,
          textAlign: widget.textAlign ?? TextAlign.start,
          enabled: widget.enabled,
          maxLines: widget.linesNumber,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction ?? TextInputAction.done,
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap?.call();
            }
          },
          onChanged: (String val) {
            widget.onValChange?.call(val);
          },
          obscureText: widget.keyboardType == TextInputType.visiblePassword,
          textDirection: widget.keyboardType == TextInputType.phone
              ? TextDirection.ltr
              : null,
          decoration: InputDecoration(
            hintTextDirection: widget.keyboardType == TextInputType.phone
                ? TextDirection.ltr
                : null,
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            labelText: widget.labelText,
            labelStyle: UniPayTheme.defaultTitle500Style(
                color: UniPayColorsPalletes.greyColor3),
            hintText: widget.hintText,
            hintStyle: UniPayTheme.title13Style400,
            alignLabelWithHint: true,
            filled: true,
            isDense: true,
            fillColor: widget.fillColor ?? UniPayColorsPalletes.transparent,
            contentPadding: widget.contentPadding ??
                EdgeInsets.symmetric(horizontal: 12.rSp, vertical: 13.rSp),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: widget.showFocusedBorder
                ? OutlineInputBorder(
                    borderRadius: 10.rSp.br,
                    gapPadding: 0,
                    borderSide: BorderSide(
                      color: UniPayColorsPalletes.greyColor8,
                      width: 1.5.rSp,
                    ),
                  )
                : null,
            errorBorder: widget.controller.text.isEmpty
                ? OutlineInputBorder(
                    borderRadius: 10.rSp.br,
                    gapPadding: 0,
                    borderSide: BorderSide(
                      color: UniPayColorsPalletes.redColor,
                      width: 2.rSp,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
