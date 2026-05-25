import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/data/repositories/orders/order_repository.dart';
import 'package:t_store/features/shop/controllers/address_controller.dart';
import 'package:t_store/features/shop/controllers/cart_controller.dart';
import 'package:t_store/features/shop/models/order_model.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loaders.dart';
import 'package:uuid/uuid.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final isLoading = false.obs;
  final RxList<OrderModel> orders = <OrderModel>[].obs;
  final _orderRepository = Get.put(OrderRepository());

  @override
  void onInit() {
    fetchUserOrders();
    super.onInit();
  }

  Future<void> fetchUserOrders() async {
    try {
      isLoading.value = true;
      final userOrders = await _orderRepository.fetchUserOrders();
      orders.assignAll(userOrders);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> processOrder(double totalAmount) async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'Processing your order...',
        'assets/images/animations/72462-check-register.json',
      );

      final cartController = CartController.instance;
      final userId = AuthenticationRepository.instance.currentUser?.uid ?? '';

      String shippingAddress = 'No address selected';
      try {
        final addressController = AddressController.instance;
        final selected = addressController.selectedAddress.value;
        if (selected.id.isNotEmpty) {
          shippingAddress =
              '${selected.name}, ${selected.street}, ${selected.city}, ${selected.state} ${selected.postalCode}, ${selected.country}';
        }
      } catch (_) {}

      final order = OrderModel(
        id: const Uuid().v4(),
        userId: userId,
        status: OrderStatus.processing,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: 'Paypal',
        items: cartController.cartItems.toList(),
        shippingAddress: shippingAddress,
      );

      await _orderRepository.saveOrder(order);
      cartController.clearCart();

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'Order Placed!',
        message: 'Your order has been placed successfully.',
      );
      fetchUserOrders();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
