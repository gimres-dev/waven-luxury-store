import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/shop/models/order_model.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instanceFor(
    app: Firebase.app(),
    databaseId: 'default',
  );

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.currentUser?.uid ?? '';
      if (userId.isEmpty) throw 'Unable to find user info.';
      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .get();
      return result.docs.map((d) => OrderModel.fromSnapshot(d)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e) {
      throw 'Something went wrong.';
    }
  }

  Future<void> saveOrder(OrderModel order) async {
    try {
      final userId = AuthenticationRepository.instance.currentUser?.uid ?? '';
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .add(order.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } catch (e) {
      throw 'Something went wrong.';
    }
  }
}