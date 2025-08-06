import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import '../../theme/spacing.dart' show verticalSpaceLarge, paddingAllRegular;
import '../buttons/custom_buttons.dart' show CustomPrimaryButton;

class CustomErrorWidget extends StatelessWidget {
  final String? errorMessage;
  final String? retryMessage;
  final VoidCallback? onRetry;

  const CustomErrorWidget({super.key, this.errorMessage, this.onRetry, this.retryMessage = 'Retry'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingAllRegular,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 70, color: context.colorScheme.error),
          verticalSpaceLarge,
          if (errorMessage != null) ...[
            Text(
              errorMessage!,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpaceLarge,
          ],
          CustomPrimaryButton(onPressed: onRetry, text: retryMessage),
        ],
      ),
    );
  }
}
