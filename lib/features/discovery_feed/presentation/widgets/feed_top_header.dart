import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_shop/features/cart/presentation/providers/cart_provider.dart';

class FeedTopHeader extends ConsumerWidget {
  final int selectedTab;
  final ValueChanged<int> onTabChanged;

  const FeedTopHeader({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final cartCount = cart.length;

    return SafeArea(
      bottom: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),

            // Onglets centraux (Boutique & Découverte)
            Row(
              children: [
                _TabItem(
                  title: 'Boutique',
                  isSelected: selectedTab == 0,
                  onTap: () => onTabChanged(0),
                ),
                const SizedBox(width: 20),
                _TabItem(
                  title: 'Découverte',
                  isSelected: selectedTab == 1,
                  onTap: () => onTabChanged(1),
                ),
              ],
            ),
            Spacer(),

            // Icône Panier avec Badge dynamique
            IconButton(
              icon: Badge.count(
                count: cartCount,
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                  size: 26
                ),
              ),
              onPressed: () {},
            ),          
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white54,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),

          // Soulignage animé de l'onglet actif
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 2,
            width: isSelected ? 28 : 0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }
}