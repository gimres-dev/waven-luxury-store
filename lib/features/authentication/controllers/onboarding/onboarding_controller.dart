import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/authentication/screens/login/login.dart';
import 'package:get_storage/get_storage.dart';
class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();
  final pageController = PageController();
  Rx<int> currentPageindex = 0.obs;
  void updatePageIndicator(index) => currentPageindex.value = index;
  void dotNavigationClick(index) {
    currentPageindex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage() {
    if (currentPageindex.value == 2) {
      final storage = GetStorage();
      storage.write('IsFirstTime', false);
      Get.offAll(const LoginScreen());
    } else {
      int page = currentPageindex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage() {
    currentPageindex.value = 2;
    pageController.jumpToPage(2);
  }
}
