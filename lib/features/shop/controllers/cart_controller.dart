import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/features/shop/models/cart_item_model.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/popups/loaders.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt noOfCartItems = 0.obs;

  final _storage = GetStorage();
  static const _cartKey = 'cart_items';

  @override
  void onInit() {
    super.onInit();
    _loadCartFromStorage();
    ever(cartItems, (_) {
      _computeTotals();
      _saveCartToStorage();
    });
  }

  void _saveCartToStorage() {
    final jsonList = cartItems.map((item) => item.toJson()).toList();
    _storage.write(_cartKey, jsonEncode(jsonList));
  }

  void _loadCartFromStorage() {
    final raw = _storage.read<String>(_cartKey);
    if (raw != null && raw.isNotEmpty) {
      try {
        final List decoded = jsonDecode(raw);
        cartItems.assignAll(
          decoded.map((e) => CartItemModel.fromMap(Map<String, dynamic>.from(e))).toList(),
        );
      } catch (_) {
        _storage.remove(_cartKey);
      }
    }
  }

  void addToCart(ProductModel product) {
    if (product.stock < 1) {
      TLoaders.customToast(message: 'This product is out of stock.');
      return;
    }
    final cartItem = _convertToCartItem(product, 1);
    final index = cartItems.indexWhere(
      (i) => i.productId == cartItem.productId && i.variationId == cartItem.variationId,
    );
    if (index >= 0) {
      cartItems[index].quantity += 1;
      cartItems.refresh();
    } else {
      cartItems.add(cartItem);
    }
    TLoaders.customToast(message: '${product.title} added to cart.');
  }

  void removeFromCart(CartItemModel item) {
    final index = cartItems.indexWhere(
      (i) => i.productId == item.productId && i.variationId == item.variationId,
    );
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
        cartItems.refresh();
      } else {
        cartItems.removeAt(index);
      }
    }
  }

  void removeItemFromCart(CartItemModel item) {
    cartItems.removeWhere(
      (i) => i.productId == item.productId && i.variationId == item.variationId,
    );
  }

  void updateQuantity(CartItemModel item, int quantity) {
    final index = cartItems.indexWhere(
      (i) => i.productId == item.productId && i.variationId == item.variationId,
    );
    if (index >= 0) {
      if (quantity <= 0) {
        cartItems.removeAt(index);
      } else {
        cartItems[index].quantity = quantity;
        cartItems.refresh();
      }
    }
  }

  void clearCart() {
    cartItems.clear();
    _storage.remove(_cartKey);
  }

  void _computeTotals() {
    double total = 0;
    int count = 0;
    for (final item in cartItems) {
      total += item.totalPrice;
      count += item.quantity;
    }
    totalCartPrice.value = total;
    noOfCartItems.value = count;
  }

  CartItemModel _convertToCartItem(ProductModel product, int quantity) {
    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: product.displayPrice,
      image: product.thumbnail,
      brandName: product.brand?.name,
      quantity: quantity,
    );
  }

  int getItemQuantityInCart(String productId, [String variationId = '']) {
    final index = cartItems.indexWhere(
      (i) => i.productId == productId && i.variationId == variationId,
    );
    return index >= 0 ? cartItems[index].quantity : 0;
  }
}
