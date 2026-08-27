import 'package:flutter/material.dart';
import 'package:e_shop/app/app_theme.dart';
import 'package:e_shop/features/catalog/domain/entities/product.dart';
import 'package:e_shop/features/catalog/presentation/widgets/product_info_card.dart';

class ProductDetailsBottomSheet extends StatelessWidget {
  final Product product;

  const ProductDetailsBottomSheet({super.key, required this.product});

  static Future<void> show(BuildContext context, Product product) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ProductDetailsBottomSheet(product: product),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.darkSurface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Infos Produit',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(color: Colors.white12, height: 24),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductInfoCard(product: product),
                      const SizedBox(height: 18),
                      const Text(
                        'Description',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        product.description,
                        style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
                      ),
                      const SizedBox(height: 20),
                      if (product.sizes.isNotEmpty) ...[
                        const Text(
                          'Tailles disponibles',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          children: product.sizes
                              .map((size) => Chip(
                                    label: Text(size),
                                    backgroundColor: AppColors.secondary,
                                    labelStyle: const TextStyle(color: AppColors.textPrimary),
                                  ))
                              .toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}