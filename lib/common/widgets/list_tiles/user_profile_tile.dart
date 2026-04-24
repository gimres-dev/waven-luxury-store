import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/images/t_circular_image.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          Positioned(
            bottom: -45,
            left: 10,
            child: Text(
              'WAVEN',
              style: TextStyle(
                fontSize: 90,
                fontWeight: FontWeight.bold,
                color: TColors.white.withOpacity(0.04),
              ),
            ),
          ),
          Positioned(
            top: -10,
            right: 80,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: TColors.white.withOpacity(0.10),
                  width: 1.2,
                ),
              ),
            ),
          ),
          Positioned(
            top: -2,
            right: 88,
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: TColors.white.withOpacity(0.06),
                  width: 0.8,
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 55,
            child: Transform.rotate(
              angle: 0.785,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: TColors.secondary.withOpacity(0.45),
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 130,
            child: Column(
              children: [
                Row(
                  children: [
                    _dot(4, 0.08),
                    const SizedBox(width: 6),
                    _dot(3, 0.06),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    _dot(3, 0.06),
                    const SizedBox(width: 6),
                    _dot(2.5, 0.05),
                  ],
                ),
              ],
            ),
          ),       
          ListTile(
            leading: const TCircularImage(
              image: TImages.user,
              width: 50,
              height: 50,
              padding: 0,
            ),
            title: Text(
              'Haritha Gimres',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: TColors.white),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'harithagimres@gmail.com',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: TColors.white),
                ),
                const SizedBox(height: TSizes.xs),
                Row(
                  children: [
                    const Icon(Iconsax.award, color: TColors.secondary, size: 14),
                    const SizedBox(width: TSizes.xs),
                    Text(
                      'WAVEN Elite Member',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .apply(color: TColors.secondary),
                    ),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              onPressed: onPressed,
              icon: const Icon(Iconsax.edit, color: TColors.white),
            ),
          ),
        ],
      ),
    );
  }
  Widget _dot(double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: TColors.white.withOpacity(opacity),
      ),
    );
  }
}