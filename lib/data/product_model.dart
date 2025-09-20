import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0) // har bir model uchun unique typeId
class Product {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final String image;

  @HiveField(5)
  final String category;

  @HiveField(6)
  final double rating;

  @HiveField(7)
  final int count;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.rating,
    required this.count,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      category: json['category'],
      rating: (json['rating']?['rate'] as num).toDouble(),
      count: json['rating']?['count'] ?? 0,
    );
  }
}
