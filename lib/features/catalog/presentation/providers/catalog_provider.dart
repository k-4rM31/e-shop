import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_shop/features/catalog/data/repositories/catalog_repository_impl.dart';
import 'package:e_shop/features/catalog/domain/entities/product.dart';
import 'package:e_shop/features/catalog/domain/repositories/catalog_repository.dart';

// Fournit l'instance de notre repository. 
// avec une vraie API, on ne changera le code qu'ici !
final catalogRepositoryProvider = Provider<ProductRepository>((ref) {
  return CatalogRepositoryImpl();
});

// Controller & État (AsyncValue gère nativement Loading/Data/Error)
final catalogControllerProvider = AsyncNotifierProvider<CatalogController, List<Product>>(
  CatalogController.new,
);

class CatalogController extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() {
    return ref.read(catalogRepositoryProvider).fetchFeedProducts();
  }

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(catalogRepositoryProvider).fetchFeedProducts(),
    );
  }
}