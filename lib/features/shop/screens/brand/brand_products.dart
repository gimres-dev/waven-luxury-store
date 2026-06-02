import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/brand/brand_card.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:t_store/data/repositories/products/product_repository.dart';
import 'package:t_store/features/shop/models/brand_model.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_detail.dart';
import 'package:t_store/utils/constants/sizes.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final RxList<ProductModel> products = <ProductModel>[].obs;
    final isLoading = true.obs;

    // Fetch products for this brand
    Future.microtask(() async {
      try {
        final repo = Get.find<ProductRepository>();
        final all = await repo.getFeaturedProducts();
        products.assignAll(
          all.where((p) =>
              p.brand?.name.toLowerCase() == brand.name.toLowerCase()).toList(),
        );
      } catch (_) {
      } finally {
        isLoading.value = false;
      }
    });

    return Scaffold(
      appBar: TAppBar(
        title: Text(brand.name,
            style: Theme.of(context).textTheme.headlineMedium),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Brand card at top
              TBrandCard(showBorder: true, brand: brand),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Products grid
              Obx(() {
                if (isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (products.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text('No products found for this brand.'),
                    ),
                  );
                }
                return TGridLayout(
                  itemCount: products.length,
                  itemBuilder: (_, index) {
                    final product = products[index];
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