import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/icons/t_circular_icon.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:t_store/features/shop/controllers/wishlist_controller.dart';
import 'package:t_store/features/shop/screens/home/home.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_detail.dart';
import 'package:t_store/utils/constants/sizes.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistController = WishlistController.instance;

    return Scaffold(
      appBar: TAppBar(
        title: Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(() => const HomeScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(() {
            if (wishlistController.isLoading.value) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            final wishlistProducts = wishlistController.wishlistProducts;
            if (wishlistProducts.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Text(
                    'No favourites yet.\nTap the ♡ on any product to add it here.',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return TGridLayout(
              itemCount: wishlistProducts.length,
              itemBuilder: (_, index) {
                final product = wishlistProducts[index];
                return TProductCardVertical(
                  product: product,
                  onTap: () => Get.to(() => ProductDetailScreen(product: product)),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
