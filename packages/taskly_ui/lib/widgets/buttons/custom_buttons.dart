// import 'package:flutter/material.dart';

// import '../../typography/font_weights.dart';
// import '../custom_circular_loading.dart';

// enum ButtonSize { small, medium, large }

// extension on ButtonSize {
//   double get fontSize {
//     switch (this) {
//       case ButtonSize.small:
//         return 13;
//       case ButtonSize.medium:
//         return 14;
//       case ButtonSize.large:
//         return 16;
//     }
//   }

//   double get height {
//     switch (this) {
//       case ButtonSize.small:
//         return 32;
//       case ButtonSize.medium:
//         return 40;
//       case ButtonSize.large:
//         return 52;
//     }
//   }

//   EdgeInsets get padding {
//     switch (this) {
//       case ButtonSize.small:
//         return edgeSymmetricHorizontalTiny;
//       case ButtonSize.medium:
//       case ButtonSize.large:
//         return edgeSymmetricHorizontalSmall;
//     }
//   }
// }

// class CustomBaseButton extends StatelessWidget {
//   const CustomBaseButton({
//     super.key,
//     this.onPressed,
//     this.color,
//     this.text,
//     this.textColor,
//     this.iconColor,
//     this.icon,
//     this.size = ButtonSize.medium,
//     this.centered = true,
//     this.textStyle,
//     this.padding,
//     this.child,
//     this.rawSize,
//     this.borderRadius = borderRadiusSmall,
//     this.loading = false,
//     this.disabled = false,
//   });

//   final void Function()? onPressed;
//   final Color? color;
//   final String? text;
//   final Color? textColor;
//   final Color? iconColor;
//   final IconData? icon;
//   final ButtonSize size;
//   final bool centered;
//   final TextStyle? textStyle;
//   final EdgeInsetsGeometry? padding;
//   final Widget? child;
//   final double? rawSize;
//   final BorderRadiusGeometry borderRadius;
//   final bool loading;
//   final bool disabled;

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: borderRadiusSmall,
//       child: SizedBox(
//         height: size.height,
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: color,
//             disabledBackgroundColor: kWhiteColor.withValues(alpha: .1),
//             shape: RoundedRectangleBorder(borderRadius: borderRadius),
//             padding: padding ?? size.padding,
//           ),
//           onPressed: onPressed,
//           child: child ??
//               Row(
//                 mainAxisAlignment: centered
//                     ? MainAxisAlignment.center
//                     : MainAxisAlignment.start,
//                 children: [
//                   if (icon != null) ...[
//                     CustomIcon(
//                       icon: icon!,
//                       color: iconColor,
//                       rawSize: rawSize,
//                     ),
//                     if (text != null) horizontalSpaceSmall,
//                   ],
//                   if (text != null) ...[
//                     Text(
//                       text!,
//                       style: textStyle ??
//                           context.textTheme.titleLarge?.copyWith(
//                             color: !disabled
//                                 ? textColor
//                                 : kWhiteColor.withValues(alpha: .1),
//                             fontSize: size.fontSize,
//                             fontWeight: AppFontWeight.semiBold,
//                           ),
//                     ),
//                   ],
//                   if (loading) ...[
//                     Container(
//                       width: 24,
//                       height: 24,
//                       margin: const EdgeInsets.only(left: 8.0),
//                       padding: const EdgeInsets.all(2.0),
//                       child: CustomCircularLoading(
//                         color: context.colorScheme.onPrimary.withValues(
//                           alpha: .6,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//         ),
//       ),
//     );
//   }
// }

// class CustomPrimaryButton extends CustomBaseButton {
//   const CustomPrimaryButton({
//     super.key,
//     super.onPressed,
//     super.text,
//     super.icon,
//     super.size = ButtonSize.medium,
//     super.centered = true,
//     super.textStyle,
//     super.textColor,
//     super.padding,
//     super.color = kPrimaryColor,
//     super.child,
//     super.borderRadius = borderRadiusSmall,
//     super.loading = false,
//     super.disabled = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CustomBaseButton(
//       centered: centered,
//       padding: padding,
//       icon: icon,
//       size: size,
//       text: text,
//       onPressed: onPressed,
//       textStyle: textStyle,
//       textColor: textColor,
//       color: color,
//       borderRadius: borderRadius,
//       rawSize: rawSize,
//       loading: loading,
//       disabled: disabled || onPressed == null || loading,
//       child: child,
//     );
//   }
// }
