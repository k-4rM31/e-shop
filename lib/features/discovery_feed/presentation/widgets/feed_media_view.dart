import 'package:e_shop/features/discovery_feed/presentation/widgets/feed_video_player.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/features/catalog/domain/entities/product.dart';

class FeedMediaView extends StatefulWidget {
  final Product product;
  final bool isCurrentPage;

  const FeedMediaView({super.key, required this.product, this.isCurrentPage = true});

  @override
  State<FeedMediaView> createState() => _FeedMediaViewState();
}

class _FeedMediaViewState extends State<FeedMediaView> {
  int _currentImageIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    // CAS VIDÉO : Si le produit possède une vidéo
    if (widget.product.hasVideo) {
      return FeedVideoPlayer(
        videoUrl: widget.product.videoUrl!,
        isCurrentPage: widget.isCurrentPage,
      );
    }

    // CAS GALERIE : Si le produit n'a que des images
    final images = widget.product.imageUrls;

    if (images.isEmpty) {
      return Container(
        color: Colors.grey[900],
        child: const Center(
          child: Icon(Icons.image_not_supported, color: Colors.white54, size: 48),
        ),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        // Défilement horizontal des images
        PageView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: images.length,
          onPageChanged: (index) {
            setState(() => _currentImageIndex = index);
          },
          itemBuilder: (context, index) {
            return Image.network(
              images[index],
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const Center(
                child: Icon(Icons.broken_image, color: Colors.white54, size: 48),
              ),
            );
          },
        ),

        // Dégradé sombre en bas pour assurer la lisibilité des textes.
        IgnorePointer(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black87],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),

        // Badge compteur d'images (ex: 1/10)
        if (images.length > 1)
          Positioned(
            bottom: 160,
            right: 0,
            left: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${_currentImageIndex + 1}/${images.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}