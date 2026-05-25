import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/chips/choice_chip.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/t_rounded_container.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final attributes = product.productAttributes ?? [];

    return Column(
      children: [
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Column(
            children: [
              Row(
                children: [
                  const TSectionHeading(
                      title: 'Variation', showActionButton: false),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const TProductTitleText(
                              title: 'Price : ', smallSize: true),
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(
                                    decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          TProductPriceText(
                              price: (product.salePrice != null &&
                                      product.salePrice! > 0)
                                  ? product.salePrice!.toStringAsFixed(2)
                                  : product.price.toStringAsFixed(2)),
                        ],
                      ),
                      Row(
                        children: [
                          const TProductTitleText(
                              title: 'Stock : ', smallSize: true),
                          Text(
                            product.stock > 0 ? 'In Stock' : 'Out of Stock',
                            style:
                                Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              if (product.description != null &&
                  product.description!.isNotEmpty)
                TProductTitleText(
                  title: product.description!,
                  smallSize: true,
                  maxLines: 4,
                ),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        // Render each attribute group (Color, Size, etc.)
        ...attributes.map((attr) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TSectionHeading(
                    title: attr.name, showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                Wrap(
                  spacing: 8,
                  children: attr.values
                      .map((value) => TChoiceChip(
                            text: value,
                            selected: attr.values.first == value,
                            onSelected: (_) {},
                          ))
                      .toList(),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
              ],
            )),
      ],
    );
  }
}
