import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/data/repositories/products/product_repository.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/popups/loaders.dart';

class WishlistController extends GetxController {
  static WishlistController get instance => Get.find();

  final RxMap<String, bool> favouriteProducts = <String, bool>{}.obs;
  final RxList<ProductModel> wishlistProducts = <ProductModel>[].obs;
  final isLoading = false.obs;

  final _storage = GetStorage();
  static const _wishlistKey = 'wishlist_ids';

  @override
  void onInit() {
    super.onInit();
    _loadWishlistFromStorage();
  }

  void _saveWishlistToStorage() {
    _storage.write(_wishlistKey, favouriteProducts.keys.toList());
  }

  void _loadWishlistFromStorage() {
    final raw = _storage.read<List>(_wishlistKey);
    if (raw != null && raw.isNotEmpty) {
      for (final id in raw) {
        favouriteProducts[id.toString()] = true;
      }
      fetchWishlistProducts();
    }
  }

  bool isFavourite(String productId) => favouriteProducts[productId] ?? false;

  void toggleFavouriteProduct(String productId) {
    if (favouriteProducts.containsKey(productId)) {
      favouriteProducts.remove(productId);
      wishlistProducts.removeWhere((p) => p.id == productId);
      TLoaders.customToast(message: 'Product removed from Wishlist.');
    } else {
      favouriteProducts[productId] = true;
      TLoaders.customToast(message: 'Product added to Wishlist.');
      _fetchAndAddProduct(productId);
    }
    _saveWishlistToStorage();
  }

  Future<void> _fetchAndAddProduct(String productId) async {
    try {
      final repo = Get.find<ProductRepository>();
      final product = await repo.getProductById(productId);
      if (product != null && !wishlistProducts.any((p) => p.id == productId)) {
        wishlistProducts.add(product);
      }
    } catch (_) {}
  }

  Future<void> fetchWishlistProducts() async {
    try {
      isLoading.value = true;
      final ids = favouriteProducts.keys.toList();
      if (ids.isEmpty) return;
      final repo = Get.find<ProductRepository>();
      final products = await Future.wait(ids.map((id) => repo.getProductById(id)));
      wishlistProducts.assignAll(products.whereType<ProductModel>().toList());
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }

  List<String> get favouriteProductIds => favouriteProducts.keys.toList();
}
