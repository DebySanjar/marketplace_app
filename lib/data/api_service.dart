import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/product_model.dart';

class ApiService {
  final String baseUrl = "https://fakestoreapi.com/";

  Future<List<Product>> fetchProducts([String query = ""]) async {
    final url = query.isEmpty
        ? Uri.parse("$baseUrl/products")
        : Uri.parse("$baseUrl/products/?title=$query");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  // 🔥 CATEGORY bo‘yicha mahsulotlarni olish
  Future<List<Product>> fetchProductsByCategory(String category) async {
    final url = Uri.parse("$baseUrl/products/category/$category");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load products by category");
    }
  }
}
