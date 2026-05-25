import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/shop/controllers/cart_controller.dart';
import 'package:t_store/features/shop/screens/cart/cart.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    this.iconColor,
    this.counterBgColor,
    this.counterTextColor,
    required this.onPressed,
  });

  final Color? iconColor, counterBgColor, counterTextColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartController = CartController.instance;

    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => const CartScreen()),
          icon: Icon(Iconsax.bag_tick_2,
              color: iconColor ?? (dark ? TColors.white : TColors.black)),
        ),
        Positioned(
          right: 0,
          child: Obx(() => Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: TColors.secondary,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    '${cartController.noOfCartItems.value}',
                    style: Theme.of(context).textTheme.labelLarge!.apply(
                          color: TColors.primary,
                          fontSizeFactor: 0.8,
                        ),
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
