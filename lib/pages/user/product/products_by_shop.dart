import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/models/product_model.dart';
import 'package:takeout/services/product_service.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/formfields/customtextfield_widget.dart';

class ProductsByShop extends StatefulWidget {
  final int merchantId;

  const ProductsByShop({super.key, required this.merchantId});

  @override
  State<ProductsByShop> createState() => _ProductsByShopState();
}

class _ProductsByShopState extends State<ProductsByShop> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _searchController.addListener(_filterProducts);
  }

  Future<void> _loadProducts() async {
    try {
      final products = await ProductService().getProductsByShopId(
        widget.merchantId,
      );
      setState(() {
        _allProducts = products;
        _filteredProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts =
          _allProducts
              .where((product) => product.name.toLowerCase().contains(query))
              .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = "title.merchant_product".tr();
    final searchPlaceholder = "input.search_product".tr();
    return Scaffold(
      appBar: AppBarWidget(title: title),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(child: Text('Error: $_error'))
              : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: 12,
                    ),
                    child: CustomTextField(
                      label: '',
                      hint: searchPlaceholder,
                      controller: _searchController,
                      isDense: true,
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                  Expanded(
                    child:
                        _filteredProducts.isEmpty
                            ? const Center(child: Text('No products found.'))
                            : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: GridView.builder(
                                padding: const EdgeInsets.only(bottom: 20),
                                itemCount: _filteredProducts.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                      childAspectRatio: 3 / 3.5,
                                    ),
                                itemBuilder: (context, index) {
                                  return Text('');
                                  // ProductCard(
                                  //   product: _filteredProducts[index],
                                  // );
                                },
                              ),
                            ),
                  ),
                ],
              ),
    );
  }
}
