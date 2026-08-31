import 'package:e_shop/features/catalog/domain/entities/product.dart';
import 'package:e_shop/features/catalog/domain/repositories/catalog_repository.dart';

class CatalogRepositoryImpl implements ProductRepository {
  
  // A FAIRE: injection "CatalogRemoteDataSource" ici.
  // Pour l'instant, on met les fausses données directement.
  
  @override
  Future<List<Product>> fetchFeedProducts() async {
    // Simulation du délai réseau (2 secondes)
    await Future.delayed(const Duration(seconds: 2));
    
    // Retour des produits statiques
    return const [
      Product(
        id: 'prod_1',
        title: 'Sneakers Urban Flow',
        brand: 'Nike',
        price: 129.99,
        category: 'shoes',
        videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        imageUrls: ['https://images.unsplash.com/photo-1542291026-7eec264c27ff'],
        description: 'Baskets confortables parfaites pour un usage quotidien en ville.',
        sizes: ['40', '41', '42', '43'],
      ),
      Product(
        id: 'prod_2',
        title: 'Veste Automne Minimaliste',
        brand: 'ZARA',
        price: 89.90,
        category: 'shoes',
        videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        imageUrls: ['https://images.unsplash.com/photo-1551028719-00167b16eac5'],
        description: 'Veste légère et stylée pour la mi-saison.',
        sizes: ['S', 'M', 'L'],
      ),
      Product(
        id: 'prod_3',
        title: 'Montre Classique Or',
        brand: 'Fossil',
        price: 159.00,
        category: 'shoes',
        // Pas de vidéo ici pour tester le comportement "Image seule"
        imageUrls: [
          'https://images.unsplash.com/photo-1524592094714-0f0654e20314',
          'https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3'
        ],
        description: 'Montre élégante et résistante à l\'eau (50m).',
      ),
    ];
  }
}