import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:t_store/features/shop/controllers/product_controller.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_detail.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;

    return Scaffold(
      appBar: const TAppBar(
          title: Text('Popular Products'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              DropdownButtonFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.sort)),
                onChanged: (value) {},
                items: [
                  'Name',
                  'Higher Price',
                  'Lower Price',
                  'Sale',
                  'Newest',
                  'Popularity'
                ]
                    .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                    .toList(),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.featuredProducts.isEmpty) {
                  return const Center(child: Text('No products found.'));
                }
                return TGridLayout(
                  itemCount: controller.featuredProducts.length,
                  itemBuilder: (_, index) {
                    final product = controller.featuredProducts[index];
                    return TProductCardVertical(
                      product: product,
                      onTap: () => Get.to(
                          () => ProductDetailScreen(product: product)),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
