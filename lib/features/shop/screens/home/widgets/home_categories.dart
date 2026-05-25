import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:t_store/features/shop/controllers/category_controller.dart';
import 'package:t_store/features/shop/screens/sub_category/sub_categories.dart';
import 'package:t_store/utils/constants/colors.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Obx(() {
      if (controller.isLoading.value) {
        return const SizedBox(
          height: 80,
          child: Center(child: CircularProgressIndicator(color: TColors.white)),
        );
      }
      if (controller.allCategories.isEmpty) {
        return const SizedBox(
          height: 80,
          child: Center(
            child: Text('No categories', style: TextStyle(color: TColors.white)),
          ),
        );
      }
      return SizedBox(
        height: 80,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: controller.allCategories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 20), // ✅ gap
          itemBuilder: (_, index) {
            final category = controller.allCategories[index];
            return TVerticalImageText(
              image: category.image,
              title: category.name,
              textColor: Colors.white,
              isNetworkImage: category.image.startsWith('http'),
              onTap: () => Get.to(() => SubCategoriesScreen(category: category)),
            );
          },
        ),
      );
    });
  }
}