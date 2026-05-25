import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/controllers/banner_controller.dart';
import 'package:t_store/features/shop/controllers/product_controller.dart';
import 'package:t_store/features/shop/screens/all_products/all_products.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_categories.dart';
import 'package:t_store/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_detail.dart';
import 'package:t_store/features/shop/screens/search/search.dart';
import 'package:t_store/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerController = BannerController.instance;
    final productController = ProductController.instance;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  const THomeAppBar(),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  TSearchContainer(
                    text: 'Search in Store',
                    showBorder: true,
                    showBackground: true,
                    onTap: () => Get.to(() => const SearchScreen()),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: TSizes.spaceBtwItems),
                        THomeCategories(),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  Obx(() {
                    if (bannerController.isLoading.value) {
                      return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
                    }
                    if (bannerController.allBanners.isEmpty) return const SizedBox.shrink();
                    return TPromoSlider(banners: bannerController.allBanners);
                  }),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  TSectionHeading(
                    title: 'Popular Products',
                    onPressed: () => Get.to(() => const AllProducts()),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Obx(() {
                    if (productController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (productController.featuredProducts.isEmpty) {
                      return const Center(child: Text('No products found.'));
                    }
                    return TGridLayout(
                      itemCount: productController.featuredProducts.length,
                      itemBuilder: (_, index) {
                        final product = productController.featuredProducts[index];
                        return TProductCardVertical(
                          product: product,
                          onTap: () => Get.to(() => ProductDetailScreen(product: product)),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
