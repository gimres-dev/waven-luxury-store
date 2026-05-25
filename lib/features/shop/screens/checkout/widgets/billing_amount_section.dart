import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/shop/controllers/cart_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/pricing_calculator.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return Obx(() {
      final subtotal = cartController.totalCartPrice.value;
      final shippingFee = TPricingCalculator.calculateShippingCost(subtotal, 'US');
      final tax = TPricingCalculator.calculateTax(subtotal, 'US');
      final total = subtotal + double.parse(shippingFee) + double.parse(tax);

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
              Text('\$${subtotal.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Shipping Fee',
                  style: Theme.of(context).textTheme.bodyMedium),
              Text('\$$shippingFee',
                  style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium),
              Text('\$$tax',
                  style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order Total',
                  style: Theme.of(context).textTheme.bodyMedium),
              Text('\$${total.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ],
      );
    });
  }
}
