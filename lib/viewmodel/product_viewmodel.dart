import 'package:flutter/foundation.dart';
import '../data/product_model.dart';
import '../repository/product_repository.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository repository;
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;

  bool get isLoading => _isLoading;

  List<Product> filteredProducts = [];

  ProductViewModel(this.repository);

  Future<void> fetchProducts([String query = ""]) async {
    _isLoading = true;
    notifyListeners();
    try {
      _products = await repository.getProducts(query);
    } catch (e) {
      if (kDebugMode) print("Error: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  // 🔥 Category bo‘yicha mahsulotlarni olish
  Future<void> fetchProductsByCategory(String category) async {
    _isLoading = true;
    notifyListeners();
    try {
      _products = await repository.getProductsByCategory(category);
    } catch (e) {
      if (kDebugMode) print("Error: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    if (query.isEmpty) {
      filteredProducts = products;
    } else {
      filteredProducts = products
          .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
