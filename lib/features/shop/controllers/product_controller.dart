import 'package:get/get.dart';
import 'package:t_store/data/repositories/products/product_repository.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/popups/loaders.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  final _productRepository = Get.put(ProductRepository());

  @override
  void onInit() {
    super.onInit();
    fetchFeaturedProducts();
  }

  Future<void> fetchFeaturedProducts() async {
    try {
      isLoading.value = true;
      final products = await _productRepository.getFeaturedProducts();
      featuredProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      return await _productRepository.getAllFeaturedProducts();
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  String getProductPrice(ProductModel product) {
    if (product.productType == ProductType.single) {
      return (product.salePrice != null && product.salePrice! > 0)
          ? product.salePrice!.toStringAsFixed(2)
          : product.price.toStringAsFixed(2);
    }
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;
    for (final variation in product.productVariations ?? []) {
      final price = variation.salePrice > 0 ? variation.salePrice : variation.price;
      if (price < smallestPrice) smallestPrice = price;
      if (price > largestPrice) largestPrice = price;
    }
    if (smallestPrice == largestPrice) return smallestPrice.toStringAsFixed(2);
    return '\$${smallestPrice.toStringAsFixed(2)} - \$${largestPrice.toStringAsFixed(2)}';
  }

  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0) return null;
    final percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  String getProductStockStatus(int stock) => stock > 0 ? 'In Stock' : 'Out of Stock';
}
