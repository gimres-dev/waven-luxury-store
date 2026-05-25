import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/images/t_circular_image.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return ClipRect(
      child: Stack(
        children: [
          Positioned(
            bottom: -45, left: 10,
            child: Text('WAVEN', style: TextStyle(fontSize: 90, fontWeight: FontWeight.bold, color: TColors.white.withValues(alpha: 0.04))),
          ),
          Positioned(top: -10, right: 80,
            child: Container(width: 50, height: 50,
              decoration: BoxDecoration(shape: BoxShape.circle,
                border: Border.all(color: TColors.white.withValues(alpha: 0.10), width: 1.2))),
          ),
          Positioned(top: -2, right: 88,
            child: Container(width: 34, height: 34,
              decoration: BoxDecoration(shape: BoxShape.circle,
                border: Border.all(color: TColors.white.withValues(alpha: 0.06), width: 0.8))),
          ),
          Positioned(top: 8, right: 55,
            child: Transform.rotate(angle: 0.785,
              child: Container(width: 12, height: 12,
                decoration: BoxDecoration(border: Border.all(color: TColors.secondary.withValues(alpha: 0.45), width: 1.0))))),
          Obx(() {
            final user = controller.user.value;
            final pic = user.profilePicture;
            return ListTile(
              leading: TCircularImage(
                image: pic.isNotEmpty ? pic : TImages.user,
                width: 50, height: 50, padding: 0,
                isNetworkImage: pic.isNotEmpty,
              ),
              title: Text(
                user.fullName.isNotEmpty ? user.fullName : 'Your Name',
                style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(user.email.isNotEmpty ? user.email : 'your@email.com',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white)),
                  const SizedBox(height: TSizes.xs),
                  Row(children: [
                    const Icon(Iconsax.award, color: TColors.secondary, size: 14),
                    const SizedBox(width: TSizes.xs),
                    Text('WAVEN Elite Member',
                        style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.secondary)),
                  ]),
                ],
              ),
              trailing: IconButton(
                onPressed: onPressed,
                icon: const Icon(Iconsax.edit, color: TColors.white),
              ),
            );
          }),
        ],
      ),
    );
  }
}
