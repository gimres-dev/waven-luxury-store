import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/features/authentication/models/user_model.dart';
import 'package:t_store/features/authentication/screens/signup/verify_email.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loaders.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// -- Variables
  final hidePassword = true.obs; 
  final privacyPolicy = true.obs; 
  
  final email = TextEditingController(); 
  final lastName = TextEditingController(); 
  final username = TextEditingController(); 
  final password = TextEditingController(); 
  final firstName = TextEditingController(); 
  final phoneNumber = TextEditingController(); 
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); 

  /// -- SIGNUP Logic
  /// Change: Changed from 'void' to 'Future<void>' to properly handle async exceptions.
  Future<void> signup() async {
    try {
      // 1. Start Loading
      TFullScreenLoader.openLoadingDialog('Processing your information...', TImages.docerAnimation);

      // 2. Check Internet Connectivity
      // Note: NetworkManager is now initialized globally in GeneralBindings.
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // 3. Form Validation
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // 4. Privacy Policy Check
      if (!privacyPolicy.value) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'In order to create account, you must read and accept the Privacy Policy & Terms of Use.',
        );
        return;
      }

      // 5. Register user in Firebase Authentication
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(
        email.text.trim(), 
        password.text.trim(),
      );

      // 6. Save Authenticated user data in Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      /// Change: Use '.instance' (Get.find) instead of 'Get.put' inside the function.
      final userRepository = UserRepository.instance;
      await userRepository.saveUserRecord(newUser);

      // 7. Remove Loader
      TFullScreenLoader.stopLoading();

      // 8. Show Success Message
      TLoaders.successSnackBar(
        title: 'Congratulations', 
        message: 'Your account has been created! Verify email to continue.'
      );

      // 9. Move to Verify Email Screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));

    } catch (e) {
  TFullScreenLoader.stopLoading();
  TLoaders.errorSnackBar(title: 'Oh Snap!', message: (e as dynamic).message.toString());
}
  }
}