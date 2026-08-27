import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_shop/features/catalog/domain/entities/product.dart';

final cartProvider = NotifierProvider<CartNotifier, List<Product>>(CartNotifier.new);

class CartNotifier extends Notifier<List<Product>> {
  @override
  List<Product> build() {
    return [];
  }

  void addToCart(Product product) {
    state = [...state, product];
  }
}