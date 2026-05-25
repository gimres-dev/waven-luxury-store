import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/images/t_rounded_image.dart';
import 'package:t_store/common/widgets/icons/t_circular_icon.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:t_store/features/shop/controllers/cart_controller.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final dark = THelperFunctions.isDarkMode(context);

    return Obx(() {
      if (cartController.cartItems.isEmpty) {
        return const Center(child: Text('Your cart is empty.'));
      }
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cartController.cartItems.length,
        separatorBuilder: (_, __) =>
            const SizedBox(height: TSizes.spaceBtwSections),
        itemBuilder: (_, index) {
          final item = cartController.cartItems[index];
          return Column(
            children: [
              /// Cart Item Row
              Row(
                children: [
                  TRoundedImage(
                    imageUrl: item.image ?? '',
                    width: 60,
                    height: 60,
                    isNetworkImage: item.image != null && item.image!.startsWith('http'),
                    padding: const EdgeInsets.all(TSizes.sm),
                    backgroundColor:
                        dark ? TColors.darkerGrey : TColors.light,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TBrandTitleWithVerifiedIcon(
                            title: item.brandName ?? ''),
                        Flexible(
                            child: TProductTitleText(
                                title: item.title, maxLines: 1)),
                        if (item.selectedVariation != null &&
                            item.selectedVariation!.isNotEmpty)
                          Text.rich(
                            TextSpan(
                              children: item.selectedVariation!.entries
                                  .map((e) => [
                                        TextSpan(
                                            text: '${e.key} ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                        TextSpan(
                                            text: '${e.value} ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge),
                                      ])
                                  .expand((x) => x)
                                  .toList(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),

              /// Add / Remove Buttons
              if (showAddRemoveButtons) ...[
                const SizedBox(height: TSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 70),
                        TCircularIcon(
                          icon: Iconsax.minus,
                          width: 32,
                          height: 32,
                          size: TSizes.md,
                          color: dark ? TColors.white : TColors.black,
                          backgroundColor:
                              dark ? TColors.darkerGrey : TColors.light,
                          onPressed: () =>
                              cartController.removeFromCart(item),
                        ),
                        const SizedBox(width: TSizes.spaceBtwItems),
                        Text('${item.quantity}',
                            style:
                                Theme.of(context).textTheme.titleSmall),
                        const SizedBox(width: TSizes.spaceBtwItems),
                        TCircularIcon(
                          icon: Iconsax.add,
                          width: 32,
                          height: 32,
                          size: TSizes.md,
                          color: TColors.white,
                          backgroundColor: TColors.primary,
                          onPressed: () {
                            cartController.updateQuantity(
                                item, item.quantity + 1);
                          },
                        ),
                      ],
                    ),
                    TProductPriceText(
                        price: item.totalPrice.toStringAsFixed(2)),
                  ],
                ),
              ],
            ],
          );
        },
      );
    });
  }
}
