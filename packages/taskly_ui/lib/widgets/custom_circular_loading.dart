import 'package:flutter/material.dart';

class CustomCircularLoading extends StatelessWidget {
  final double? value;
  final Color? color;

  const CustomCircularLoading({super.key, this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 2,
      value: value,
      valueColor: AlwaysStoppedAnimation(color),
    );
  }
}
