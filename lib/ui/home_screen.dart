import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repository/product_repository.dart';
import '../data/api_service.dart';
import '../viewmodel/product_viewmodel.dart';
import 'widgets/product_card.dart';
import 'widgets/banner_slider.dart';
import 'category_screen.dart';
import 'profile_screen.dart';
import 'like_screen.dart';


/// Asosiy HomeScreen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),
    const CategoryScreen(),
    const LikeScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ProductViewModel(ProductRepository(ApiService()))..fetchProducts(),
      child: Scaffold(

        resizeToAvoidBottomInset: true,

        backgroundColor: Colors.white,

        appBar: _currentIndex == 0
            ? AppBar(
                title: const Text(
                  "Marketplace",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.deepOrange,
              )
            : null,

        body: _screens[_currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          elevation: 10,
          backgroundColor: Colors.white70,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepOrange,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: "Category",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Like"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}

/// Home Content (search + banner + grid)
class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  bool _isSearching = false;
  List<dynamic> _searchResults = [];

  void _onSearchChanged(String query, ProductViewModel vm) {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults.clear();
      });
    } else {
      setState(() {
        _isSearching = true;
        _searchResults = vm.products
            .where(
              (product) =>
                  product.title.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (context, vm, child) {
        if (vm.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              /// Search bar
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    suffixIcon: const Icon(Icons.search),
                  ),
                  onChanged: (value) => _onSearchChanged(value, vm),
                ),
              ),

              /// Search active bo‘lsa faqat search natijalari chiqadi
              if (_isSearching)
                _searchResults.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("Bunday mahsulot mavjud emas"),
                      )
                    : GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: _searchResults[index],
                            products: vm.products,
                          );
                        },
                      )
              /// Search bo‘lmasa eski content chiqadi
              else ...[
                const BannerSlider(),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
