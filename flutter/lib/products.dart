import 'package:flutter/material.dart';
import 'package:flutter_restapi/controller/product_controller.dart'; // Assuming this controller fetches product data, which will now be watches.
import 'package:flutter_restapi/product_detail.dart';
import 'package:get/get.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductController controller = Get.find();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => controller.fetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    // Elegant color scheme for a branded watch theme
    final Color primaryColor = Colors.deepPurple[900]!; // Darker, luxurious
    final Color accentColor = Colors.amber[600]!; // Gold-like accent
    final Color backgroundColor =
        Colors.grey[100]!; // Lighter background for contrast
    final Color cardColor = Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Luxury Timepieces', // New title: Branded Watches
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 4, // Added a subtle shadow
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: primaryColor));
        }

        return RefreshIndicator(
          onRefresh: () async {
            controller.fetchProducts(); // Refreshing watch data
          },
          color: primaryColor,
          child: GridView.builder(
            padding: const EdgeInsets.all(16), // Slightly more padding
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16, // Increased spacing
              mainAxisSpacing: 16, // Increased spacing
              childAspectRatio:
                  0.8, // Adjusted for watch images, slightly taller
            ),
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final product = controller.products[index];

              return Card(
                color: cardColor,
                elevation: 8, // More pronounced shadow for luxury feel
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ), // More rounded corners
                ),
                child: InkWell(
                  onTap: () {
                    Get.to(() => ProductDetailPage(product: product));
                  },
                  child: Column(
                    // Changed Stack to Column for better control of content flow
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            // 1. Watch image as background
                            Positioned.fill(
                              child: Image.network(
                                product.thumbnail,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) => const Icon(
                                      Icons.watch, // Watch icon if image fails
                                      size: 60,
                                      color: Colors.grey,
                                    ),
                                loadingBuilder: (
                                  context,
                                  child,
                                  loadingProgress,
                                ) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                      color: accentColor,
                                    ),
                                  );
                                },
                              ),
                            ),

                            // 2. Subtle gradient overlay for text readability on image
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 80, // Height of the gradient
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.7),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ),

                            // [NEW] "Limited Stock" or "Sold Out" badge
                            if (index % 3 == 0) // Example condition for badge
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red[700],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'Limited Stock',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                            // Watch brand label
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Chip(
                                label: Text(
                                  product.brand,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                                backgroundColor: primaryColor.withOpacity(0.8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: TextStyle(
                                color:
                                    primaryColor, // Use primary color for title
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}', // Format price
                              style: TextStyle(
                                color: accentColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
