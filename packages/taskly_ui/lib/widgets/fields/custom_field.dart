import 'package:flutter/material.dart';
import 'package:taskly_ui/extensions/build_context.extensions.dart';

import '../../theme/borders.dart' show borderRadiusRegular;
import '../../theme/colors.dart' show kPrimaryColor;
import '../../theme/spacing.dart' show paddingAllRegular;
import '../../typography/font_weights.dart' show AppFontWeight;

class CustomFormField extends StatelessWidget {
  final String label;
  final String? hintText;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final int maxLines;
  final String? Function(String?)? validator;
  final bool disabled;
  final AutovalidateMode autovalidateMode;
  final FloatingLabelBehavior floatingLabelBehavior;

  const CustomFormField({
    super.key,
    required this.label,
    this.hintText,
    this.suffixIcon,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.controller,
    this.maxLines = 1,
    this.validator,
    this.disabled = false,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
  });

  OutlineInputBorder _inputBorder({Color? color, BorderSide? borderSide}) {
    return OutlineInputBorder(
      borderRadius: borderRadiusRegular,
      borderSide: borderSide ?? BorderSide(color: color ?? kPrimaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      autovalidateMode: autovalidateMode,
      style: context.textTheme.bodyMedium?.copyWith(
        fontWeight: AppFontWeight.regular,
        color: context.colorScheme.onPrimaryContainer,
      ),
      keyboardType: textInputType,
      controller: controller,
      maxLines: maxLines,
      enabled: !disabled,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        floatingLabelBehavior: floatingLabelBehavior,
        filled: true,
        fillColor: context.colorScheme.onPrimary,
        labelStyle: context.textTheme.labelLarge?.copyWith(
          color: context.colorScheme.onPrimaryContainer,
          fontWeight: AppFontWeight.medium,
        ),
        hintStyle: context.textTheme.labelSmall?.copyWith(
          color: context.colorScheme.onPrimaryContainer.withValues(alpha: .6),
          fontWeight: AppFontWeight.regular,
        ),
        border: _inputBorder(borderSide: BorderSide.none),
        errorStyle: context.textTheme.labelMedium?.copyWith(
          color: context.colorScheme.error,
        ),
        errorBorder: _inputBorder(color: context.colorScheme.error),
        focusedErrorBorder: _inputBorder(color: context.colorScheme.error),
        focusedBorder: _inputBorder(),
        suffixIcon: suffixIcon,
        contentPadding: paddingAllRegular,
      ),
    );
  }
}
