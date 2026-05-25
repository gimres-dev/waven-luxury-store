import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:t_store/data/repositories/products/product_repository.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_detail.dart';
import 'package:t_store/utils/constants/sizes.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final _repo = Get.find<ProductRepository>();

  List<ProductModel> _results = [];
  bool _isLoading = false;
  bool _hasSearched = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _search(String query) async {
    if (query.trim().isEmpty) {
      setState(() { _results = []; _hasSearched = false; });
      return;
    }
    setState(() { _isLoading = true; _hasSearched = true; });
    try {
      final results = await _repo.searchProducts(query.trim());
      setState(() => _results = results);
    } catch (e) {
      setState(() => _results = []);
    } finally {
      setState(() => _isLoading = false);
    }
  }

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
                controller: _searchController,
                autofocus: true,
                textInputAction: TextInputAction.search,
                onChanged: _search,
                onFieldSubmitted: _search,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.search_normal),
                  hintText: 'Search for clothes, shoes...',
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () { _searchController.clear(); _search(''); },
                        )
                      : null,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else if (!_hasSearched)
                Center(
                  child: Column(children: [
                    const Icon(Iconsax.search_status, size: 100, color: Colors.grey),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Text('Type to search for products',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ]),
                )
              else if (_results.isEmpty)
                Center(
                  child: Column(children: [
                    const Icon(Iconsax.close_circle, size: 100, color: Colors.grey),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Text('No results for "${_searchController.text}"',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center),
                  ]),
                )
              else
                TGridLayout(
                  itemCount: _results.length,
                  itemBuilder: (_, index) {
                    final product = _results[index];
                    return TProductCardVertical(
                      product: product,
                      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
