import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:t_store/features/shop/models/banner_model.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instanceFor(
    app: Firebase.app(),
    databaseId: 'default',
  );

  Future<List<BannerModel>> fetchActiveBanners() async {
    try {
      final snapshot = await _db
          .collection('Banners')
          .where('Active', isEqualTo: true)
          .get();
      return snapshot.docs
          .map((d) => BannerModel.fromSnapshot(d))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } catch (e) {
      throw 'Something went wrong fetching banners.';
    }
  }
}