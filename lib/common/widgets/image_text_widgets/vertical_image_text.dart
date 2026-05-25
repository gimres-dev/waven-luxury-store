import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TVerticalImageText extends StatelessWidget {
  const TVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = TColors.white,
    this.backgroundColor,
    this.onTap,
    this.isNetworkImage = false,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(TSizes.sm * 1.5),
              decoration: BoxDecoration(
                color: backgroundColor ?? (dark ? TColors.primary : TColors.white),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                    color: TColors.secondary.withValues(alpha: 0.2), width: 1),
              ),
              child: Center(
                child: Image(
                  image: isNetworkImage
                      ? NetworkImage(image) as ImageProvider
                      : AssetImage(image),
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image_not_supported, size: 20),
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title.isEmpty ? '???' : title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                shadows: [
                  Shadow(color: Colors.black, blurRadius: 6),
                ],
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}