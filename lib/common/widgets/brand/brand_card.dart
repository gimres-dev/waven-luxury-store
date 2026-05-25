import 'package:flutter/material.dart';
import 'package:t_store/common/styles/rounded_container.dart';
import 'package:t_store/common/widgets/images/t_circular_image.dart';
import 'package:t_store/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:t_store/features/shop/models/brand_model.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key,
    this.showBorder = true,
    this.onTap,
    this.brand,
  });

  final bool showBorder;
  final VoidCallback? onTap;
  final BrandModel? brand; // ✅ accepts real data

  @override
  Widget build(BuildContext context) {
    final brandName = brand?.name ?? 'Brand';
    final productCount = brand?.productsCount ?? 0;
    final imageUrl = brand?.image ?? '';
    final isNetwork = imageUrl.startsWith('http');

    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        borderColor: TColors.secondary,
        radius: 12,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TCircularImage(
              isNetworkImage: isNetwork,
              image: isNetwork ? imageUrl : TImages.clothIcon,
              width: 45,
              height: 45,
              padding: 6,
              backgroundColor: Colors.transparent,
              overlayColor: isNetwork ? null : TColors.primary,
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TBrandTitleWithVerifiedIcon(
                    title: brandName, // ✅ real brand name
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    '$productCount products', // ✅ real count
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium!.apply(
                          color: TColors.darkGrey,
                          letterSpacingDelta: 0.5,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}