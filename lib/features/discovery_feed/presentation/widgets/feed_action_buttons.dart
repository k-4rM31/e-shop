import 'package:e_shop/features/catalog/presentation/widgets/product_comments_bottom_sheet.dart';
import 'package:e_shop/features/catalog/presentation/widgets/product_details_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_shop/app/app_theme.dart';
import 'package:e_shop/features/cart/presentation/providers/cart_provider.dart';
import 'package:e_shop/features/catalog/domain/entities/product.dart';
import 'package:e_shop/features/catalog/presentation/providers/wishlist_provider.dart';

class FeedActionButtons extends ConsumerWidget {
  final Product product;

  const FeedActionButtons({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistProvider);
    final cart = ref.watch(cartProvider);

    final isLiked = wishlist.contains(product.id);
    final isInCart = cart.any((p) => p.id == product.id);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // BOUTTON LIKE/FAVORI
        _ActionButton(
          icon: isLiked ? Icons.favorite : Icons.favorite_border,
          color: isLiked ? AppColors.primary : AppColors.onDark,
          label: 'Favoris',
          onTap: () {
            ref.read(wishlistProvider.notifier).toggleLike(product.id);
          },
        ),
        const SizedBox(height: 16),

        // BOUTTON COMMENTAIRES
        _ActionButton(
          icon: Icons.chat_bubble_outline,
          color: AppColors.onDark,
          label: 'Avis',
          onTap: () => ProductCommentsBottomSheet.show(context, product),
        ),
        const SizedBox(height: 16),

        // BOUTTON INFOS PRODUIT
        _ActionButton(
          icon: Icons.info_outline_rounded,
          color: AppColors.onDark,
          label: 'Infos',
          onTap: () => ProductDetailsBottomSheet.show(context, product),
        ),
        const SizedBox(height: 16),

        // BOUTTON PANIER
        _ActionButton(
          icon: isInCart ? Icons.shopping_bag : Icons.shopping_bag_outlined,
          color: isInCart ? AppColors.secondary : AppColors.onDark,
          label: isInCart ? 'Ajouté' : 'Panier',
          onTap: () {
            ref.read(cartProvider.notifier).addToCart(product);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.title} ajouté au panier !'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
        ),
        const SizedBox(height: 16),

        // BOUTTON PARTAGER
        _ActionButton(
          icon: Icons.share_rounded,
          color: AppColors.onDark,
          label: 'Partager',
          onTap: () {
            // Action de partage
          },
        ),
      ],
    );
  }

  // Modal Bottom Sheet Commentaires 

  // Modal Bottom Sheet Info Produit
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.onDark,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}