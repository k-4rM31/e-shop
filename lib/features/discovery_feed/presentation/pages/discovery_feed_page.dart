import 'package:e_shop/features/catalog/presentation/providers/wishlist_provider.dart';
import 'package:e_shop/features/discovery_feed/presentation/widgets/feed_media_view.dart';
import 'package:e_shop/features/discovery_feed/presentation/widgets/feed_top_header.dart';
import 'package:e_shop/features/discovery_feed/presentation/widgets/like_heart_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_shop/app/app_theme.dart';
import 'package:e_shop/features/catalog/domain/entities/product.dart';
import 'package:e_shop/features/catalog/presentation/providers/catalog_provider.dart';
import 'package:e_shop/features/discovery_feed/presentation/widgets/feed_action_buttons.dart';
import 'package:e_shop/features/discovery_feed/presentation/widgets/inline_expandable_text.dart';

class DiscoveryFeedScreen extends ConsumerStatefulWidget {
  const DiscoveryFeedScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DiscoveryFeedScreenState();
}

class _DiscoveryFeedScreenState extends ConsumerState<DiscoveryFeedScreen> {
  int _selectedTab = 1;
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final catalogState = ref.watch(catalogControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.darkSurface,
      body: Stack(
        children: [
          catalogState.when(
            // ÉTAT : SUCCÈS
            data: (products) {
              if (products.isEmpty) {
                return const Center(
                  child: Text(
                    'Aucun produit trouvé',
                    style: TextStyle(color: AppColors.onDark),
                  ),
                );
              }
          
              // Défilement vertical plein écran
              return PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: products.length,
                onPageChanged: (index) {
                  setState(() => _currentPageIndex = index);
                },
                itemBuilder: (context, index) {
                  final product = products[index];
                  return FeedTile(
                    product: product, 
                    isCurrentPage: index == _currentPageIndex
                  );
                },
              );
            },
          
            // ÉTAT : CHARGEMENT
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          
            // ÉTAT : ERREUR
            error: (error, stackTrace) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: AppColors.error, size: 48),
                  const SizedBox(height: 12),
                  Text(
                    'Erreur : $error',
                    style: const TextStyle(color: AppColors.onDark),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => ref.read(catalogControllerProvider.notifier).reload(),
                    child: const Text('Réessayer'),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: FeedTopHeader(
              selectedTab: _selectedTab,
              onTabChanged: (index) {
                setState(() => _selectedTab = index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FeedTile extends ConsumerStatefulWidget {
  final Product product;
  final bool isCurrentPage;

  const FeedTile({super.key, required this.product, required this.isCurrentPage});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedTileState();
}


class _FeedTileState extends ConsumerState<FeedTile> {
  final List<HeartAnimationData> _hearts = [];

  void _onDoubleTapDown(TapDownDetails details) {
    // Position exacte du tap sur l'écran
    final position = details.localPosition;

    setState(() {
      _hearts.add(HeartAnimationData(position: position));
    });

    // Mettre le produit en favori
    ref.read(wishlistProvider.notifier).addLike(widget.product.id);
    // ref.read(favoritesProvider.notifier).toggleFavorite(widget.product.id);
  }

  void _removeHeart(Key id) {
    setState(() {
      _hearts.removeWhere((heart) => heart.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Arrière-plan Média avec Détecteur de Double Tap
        GestureDetector(
          onDoubleTapDown: _onDoubleTapDown,
          onDoubleTap: () {}, // Requis pour que onDoubleTapDown s'active
          child: FeedMediaView(product: product, isCurrentPage: widget.isCurrentPage),
        ),

        // Overlay des cœurs animés apparus au double tap
        ..._hearts.map(
          (heart) => AnimatedHeartIcon(
            key: heart.id,
            position: heart.position,
            onAnimationComplete: () => _removeHeart(heart.id),
          ),
        ),

        // Boutton d'achat immédiat
        Positioned(
          right: 16,
          bottom: 40,
          child: FilledButton(
            onPressed: (){}, 
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero
              )
            ),
            child: Text('Acheter')
          )
        ),

        // les boutton action de la feed
        Positioned(
          right: 16,
          bottom: 100,
          child: FeedActionButtons(product: product),
        ),

        // Informations Produit en bas à gauche
        Positioned(
          left: 16,
          bottom: 40,
          right: 130, // Espace réservé pour la future barre d'actions à droite
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // La marque du produit
              Text(
                widget.product.brand,
                style: const TextStyle(color: AppColors.onDark, fontSize: 13),
              ),
              // const SizedBox(height: 2),

              // Nom du Produit
              Text(
                widget.product.title,
                style: const TextStyle(
                  color: AppColors.onDark,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),

              // La description du produit
              if (product.description.isNotEmpty) ...[
                InlineExpandableText(
                  text: product.description,
                  maxLines: 2,
                  style: const TextStyle(color: AppColors.onDark, fontSize: 12, height: 1.3),
                  linkStyle: const TextStyle(color: AppColors.onDark, fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 6),
              ],

              // Le Prix du produit
              Text(
                '${widget.product.price.toStringAsFixed(2)} €',
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}