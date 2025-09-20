import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/product_viewmodel.dart';
import '../repository/product_repository.dart';
import '../data/api_service.dart';
import 'widgets/product_card.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String? _selectedCategory;

  // 🔥 Kategoriya ro‘yxati (label = UI uchun, key = API uchun)
  final List<Map<String, String>> categories = [
    {"label": "All Product ", "key": "All Product"},
    {"label": "Electronics", "key": "electronics"},
    {"label": "Jewelery", "key": "jewelery"},
    {"label": "Men's clothing", "key": "men's clothing"},
    {"label": "Women's clothing", "key": "women's clothing"},
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = "All Product"; // default
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ProductViewModel(ProductRepository(ApiService()))..fetchProducts(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Categories",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepOrange,
        ),
        body: Column(
          children: [
            // 🔹 Category ro‘yxati
            SizedBox(
              height: 46,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = _selectedCategory == category["key"];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category["key"];
                      });

                      final vm = context.read<ProductViewModel>();
                      if (category["key"] == "All Product") {
                        vm.fetchProducts();
                      } else {
                        vm.fetchProductsByCategory(category["key"]!);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.deepOrange
                            : Colors.grey[300],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),

                      child: Center(
                        child: Text(
                          category["label"]!, // 👈 ekranda faqat label
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // 🔹 Mahsulotlar grid ko‘rinishda
            Expanded(
              child: Consumer<ProductViewModel>(
                builder: (context, vm, child) {
                  if (vm.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (vm.products.isEmpty) {
                    return const Center(child: Text("Mahsulot topilmadi"));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                    itemCount: vm.products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: vm.products[index],
                        products: vm.products,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
