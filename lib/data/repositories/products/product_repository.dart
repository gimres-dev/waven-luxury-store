import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instanceFor(
    app: Firebase.app(),
    databaseId: 'default',
  );

  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db.collection('Products').get();
      return snapshot.docs.map((d) => ProductModel.fromSnapshot(d)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } catch (e) {
      throw 'Something went wrong fetching products.';
    }
  }

  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .get();
      return snapshot.docs.map((d) => ProductModel.fromSnapshot(d)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } catch (e) {
      throw 'Something went wrong.';
    }
  }

  Future<ProductModel?> getProductById(String productId) async {
    try {
      final doc = await _db.collection('Products').doc(productId).get();
      if (doc.exists) return ProductModel.fromSnapshot(doc);
      return null;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } catch (e) {
      throw 'Something went wrong.';
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('CategoryId', isEqualTo: categoryId)
          .get();
      return snapshot.docs.map((d) => ProductModel.fromSnapshot(d)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } catch (e) {
      throw 'Something went wrong.';
    }
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final snapshot = await _db.collection('Products').get();
      final all = snapshot.docs.map((d) => ProductModel.fromSnapshot(d)).toList();
      if (query.trim().isEmpty) return all;
      return all
          .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } catch (e) {
      throw 'Something went wrong.';
    }
  }
}