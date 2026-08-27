import 'package:flutter/material.dart';
import 'package:e_shop/app/app_theme.dart';
import '../../domain/entities/product.dart';

class ProductInfoCard extends StatelessWidget {
  final Product product;

  const ProductInfoCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkSurface,
      elevation: 0,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.white12, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.black26,
              ),
              clipBehavior: Clip.antiAlias,
              child: product.mainImage.isNotEmpty
                  ? Image.network(
                      product.mainImage,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const Icon(
                        Icons.broken_image,
                        color: Colors.white54,
                      ),
                    )
                  : const Icon(
                      Icons.image_not_supported,
                      color: Colors.white54,
                    ),
            ),
            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.brand.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 11,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${product.price.toStringAsFixed(2)} €',
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}