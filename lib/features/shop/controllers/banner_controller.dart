import 'package:get/get.dart';
import 'package:t_store/features/shop/models/banner_model.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  final isLoading = false.obs;
  final currentIndex = 0.obs;
  final RxList<BannerModel> allBanners = <BannerModel>[].obs;

  // Local banners — no Firebase needed
  static final List<BannerModel> _localBanners = [
    BannerModel(
      imageUrl: TImages.promoBanner1,
      targetScreen: 'home',
      active: true,
      isLocal: true,
    ),
    BannerModel(
      imageUrl: TImages.promoBanner2,
      targetScreen: 'store',
      active: true,
      isLocal: true,
    ),
    BannerModel(
      imageUrl: TImages.promoBanner3,
      targetScreen: 'home',
      active: true,
      isLocal: true,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    allBanners.assignAll(_localBanners);
  }
}
