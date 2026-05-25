import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

/// A widget for displaying an animated loading indicator (Lottie or PNG) with optional text and action button.
class TAnimationLoaderWidget extends StatelessWidget {
  const TAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text, animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// -- Display the Animation (Lottie) or Static Image (PNG/JPG)
          /// This check prevents the 'Malformed JSON' error when using a PNG path.
          animation.endsWith('.json')
              ? Lottie.asset(animation, width: MediaQuery.of(context).size.width * 0.8)
              : Image.asset(animation, width: MediaQuery.of(context).size.width * 0.8),
          
          const SizedBox(height: TSizes.defaultSpace),

          /// -- Descriptive Text
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TSizes.defaultSpace),

          /// -- Optional Action Button
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    onPressed: onActionPressed,
                    style: OutlinedButton.styleFrom(backgroundColor: TColors.dark),
                    child: Text(
                      actionText!,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.light),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}