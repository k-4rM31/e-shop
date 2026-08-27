import 'package:e_shop/features/catalog/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchFeedProducts();
}