import 'package:flutter/material.dart';
import 'package:flutter_restapi/model/product_model.dart';
import 'package:get/get.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.deepPurple[900]!;
    final Color accentColor = Colors.amber[600]!;
    final Color backgroundColor = Colors.grey[100]!;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Detail Produk"),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar utama produk
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  product.images,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (_, __, ___) => const Center(
                        child: Icon(Icons.image_not_supported, size: 50),
                      ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              product.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 8),

            // Brand & Category
            Row(
              children: [
                Chip(
                  label: Text(product.brand),
                  backgroundColor: primaryColor.withOpacity(0.8),
                  labelStyle: const TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 10),
                Chip(
                  label: Text(product.category),
                  backgroundColor: Colors.grey[300],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Price
            Text(
              "Rp ${product.price.toStringAsFixed(0)}",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),

            // Rating & Stock
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < product.rating ? Icons.star : Icons.star_border,
                      color: Colors.orange,
                      size: 20,
                    );
                  }),
                ),
                Text("Stok: ${product.stock}"),
              ],
            ),

            const SizedBox(height: 20),

            // Description
            const Text(
              "Deskripsi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(product.description, style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 30),

            // Tombol kembali
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back),
                label: const Text("Kembali"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
