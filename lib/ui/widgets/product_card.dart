import 'package:flutter/material.dart';
import '../../data/product_model.dart';
import '../show_product_page.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final List<Product> products; // qo‘shildi

  const ProductCard({super.key, required this.product, required this.products});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ShowProductPage(
              product: product,
              products: products, // related list
            ),
          ),
        );
      },
      child: Card(
        elevation: 1,
        shadowColor: Colors.redAccent,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Stack orqali rasm + rating
            Expanded(
              child: Stack(
                children: [
                  // Mahsulot rasmi
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    child: Center(
                      child: Image.network(
                        product.image,
                        height: 140,
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => const Icon(
                          Icons.broken_image,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),

                  // Rating (yuqori o‘ng burchakda)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 14,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            product.rating.toStringAsFixed(1), // ⭐ 4.5 kabi
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Product title
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                product.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
            ),

            // 🔹 Narx
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(
                "\$${product.price}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.deepOrange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
