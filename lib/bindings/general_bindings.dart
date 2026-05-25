import 'package:get/get.dart';
import 'package:t_store/data/repositories/address/address_repository.dart';
import 'package:t_store/data/repositories/categories/category_repository.dart';
import 'package:t_store/data/repositories/orders/order_repository.dart';
import 'package:t_store/data/repositories/products/product_repository.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/features/shop/controllers/banner_controller.dart';
import 'package:t_store/features/shop/controllers/cart_controller.dart';
import 'package:t_store/features/shop/controllers/category_controller.dart';
import 'package:t_store/features/shop/controllers/product_controller.dart';
import 'package:t_store/features/shop/controllers/wishlist_controller.dart';
import 'package:t_store/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    // ── Utilities ────────────────────────────────────────────────────────────
    Get.put(NetworkManager());

    // ── Repositories ─────────────────────────────────────────────────────────
    Get.put(UserRepository());
    Get.put(CategoryRepository());
    Get.put(ProductRepository());
    Get.put(AddressRepository());
    Get.put(OrderRepository());

    // ── Controllers ──────────────────────────────────────────────────────────
    Get.put(BannerController());   // local banners, no Firebase
    Get.put(UserController());
    Get.put(CategoryController());
    Get.put(ProductController());
    Get.put(CartController());
    Get.put(WishlistController());
  }
}
