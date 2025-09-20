import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../repository/product_repository.dart';
import '../../data/api_service.dart';
import '../../viewmodel/product_viewmodel.dart';
import '../ui/widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  final String category;

  const ProductListScreen({super.key, required this.category});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ProductViewModel(ProductRepository(ApiService()))
            ..fetchProducts(widget.category),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.category, style: const TextStyle(fontSize: 18)),
          backgroundColor: Colors.deepOrange,
        ),
        body: Consumer<ProductViewModel>(
          builder: (context, vm, child) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.products.isEmpty) {
              return const Center(child: Text("No products found"));
            }

            // 🔍 Search bar + GridView
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      vm.search(value); // qidiruv ishlaydi
                    },
                    decoration: InputDecoration(
                      hintText: "Search product...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(9),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 3,
                          mainAxisSpacing: 3,
                        ),
                    itemCount: vm.filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: vm.filteredProducts[index],
                        products: vm.filteredProducts, // related list
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
