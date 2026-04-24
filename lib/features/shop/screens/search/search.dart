import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/utils/constants/sizes.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Search', style: Theme.of(context).textTheme.headlineMedium),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.search_normal),
                  hintText: 'Search for clothes, shoes...',
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Center(
                child: Column(
                  children: [
                    const Icon(Iconsax.search_status, size: 100, color: Colors.grey),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Text('Type to search for products', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}