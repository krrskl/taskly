import 'package:flutter/material.dart';

import '../../theme/borders.dart' show borderRadiusSmall;
import '../../theme/colors.dart' show kPrimaryColor;
import 'custom_base_button.dart' show CustomBaseButton, ButtonSize;

class CustomPrimaryButton extends CustomBaseButton {
  const CustomPrimaryButton({
    super.key,
    super.onPressed,
    super.text,
    super.size = ButtonSize.medium,
    super.centered = true,
    super.textStyle,
    super.textColor,
    super.padding,
    super.color = kPrimaryColor,
    super.child,
    super.borderRadius = borderRadiusSmall,
    super.loading = false,
    super.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBaseButton(
      centered: centered,
      padding: padding,
      size: size,
      text: text,
      onPressed: onPressed,
      textStyle: textStyle,
      textColor: textColor,
      color: color,
      borderRadius: borderRadius,
      rawSize: rawSize,
      loading: loading,
      disabled: disabled || onPressed == null || loading,
      child: child,
    );
  }
}
