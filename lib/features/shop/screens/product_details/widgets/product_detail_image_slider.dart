import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/curved_edges/curved_edge_widget.dart';
import 'package:t_store/common/widgets/icons/t_circular_icon.dart';
import 'package:t_store/common/widgets/images/t_rounded_image.dart';
import 'package:t_store/features/shop/controllers/wishlist_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final wishlistController = WishlistController.instance;
    final allImages = [
      if (product.thumbnail != null) product.thumbnail!,
      ...(product.images ?? []),
    ];

    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              child: Padding(
                padding:
                    const EdgeInsets.all(TSizes.productImageRadius * 2),
                child: Center(
                  child: allImages.isNotEmpty
                      ? Image(
                          image: NetworkImage(allImages.first),
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.image_not_supported),
                        )
                      : const Icon(Icons.image_not_supported),
                ),
              ),
            ),
            if (allImages.length > 1)
              Positioned(
                right: 0,
                bottom: 30,
                left: TSizes.defaultSpace,
                child: SizedBox(
                  height: 80,
                  child: ListView.separated(
                    itemCount: allImages.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: TSizes.spaceBtwItems),
                    itemBuilder: (_, index) => TRoundedImage(
                      width: 80,
                      backgroundColor:
                          dark ? TColors.dark : TColors.white,
                      border: Border.all(color: TColors.primary),
                      padding: const EdgeInsets.all(TSizes.sm),
                      imageUrl: allImages[index],
                      isNetworkImage: true,
                    ),
                  ),
                ),
              ),
            TAppBar(
              showBackArrow: true,
              actions: [
                Obx(() => TCircularIcon(
                      icon: wishlistController.isFavourite(product.id)
                          ? Iconsax.heart5
                          : Iconsax.heart,
                      color: wishlistController.isFavourite(product.id)
                          ? Colors.red
                          : null,
                      onPressed: () => wishlistController
                          .toggleFavouriteProduct(product.id),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
