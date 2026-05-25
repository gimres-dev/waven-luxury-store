import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/authentication/models/user_model.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instanceFor(
    app: Firebase.app(),
    databaseId: 'default',
  );

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e) {
      throw 'Something went wrong.';
    }
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      final userId = AuthenticationRepository.instance.currentUser?.uid ?? '';
      final doc = await _db.collection('Users').doc(userId).get();
      return doc.exists ? UserModel.fromSnapshot(doc) : UserModel.empty();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e) {
      throw 'Something went wrong.';
    }
  }

  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db.collection('Users').doc(updatedUser.id).update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e) {
      throw 'Something went wrong.';
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      final userId = AuthenticationRepository.instance.currentUser?.uid ?? '';
      await _db.collection('Users').doc(userId).update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e) {
      throw 'Something went wrong.';
    }
  }
}