import '../data/api_service.dart';
import '../data/product_model.dart';

class ProductRepository {
  final ApiService apiService;

  ProductRepository(this.apiService);

  Future<List<Product>> getProducts([String query = ""]) {
    return apiService.fetchProducts(query);
  }

  // 🔥 Category bo‘yicha mahsulotlar
  Future<List<Product>> getProductsByCategory(String category) {
    return apiService.fetchProductsByCategory(category);
  }
}
