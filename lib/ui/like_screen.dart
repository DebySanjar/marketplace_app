import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/product_model.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  late Box<Product> cartBox;

  @override
  void initState() {
    super.initState();
    cartBox = Hive.box<Product>(
      'cartBox',
    ); // main.dart da ochilgan bo‘lishi kerak
  }

  void _removeItem(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("O‘chirish"),
        content: const Text("Rostdan ham ushbu mahsulotni o‘chirmoqchimisiz?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Bekor qilish
            child: const Text("Yo‘q"),
          ),
          TextButton(
            onPressed: () async {
              await cartBox.deleteAt(index); // Hive’dan o‘chirish
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text("Ha", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: const Text("Savatcha", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ValueListenableBuilder(
        valueListenable: cartBox.listenable(),
        builder: (context, Box<Product> box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text(
                "Savatcha bo‘sh",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final product = box.getAt(index);
              if (product == null) return const SizedBox();

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      leading: Image.network(
                        product.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                      title: Text(
                        product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        "💲${product.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          // 🔹 TODO: Buy logikasi yoziladi
                        },
                        child: const Text("Buy"),
                      ),
                    ),
                    Positioned(
                      right: 3,
                      top: 3,
                      child: GestureDetector(
                        onTap: () => _removeItem(index),
                        child: const CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.delete,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
