import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishlistProvider = NotifierProvider<WishlistNotifier, Set<String>>(WishlistNotifier.new);

class WishlistNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() {
    return <String>{};
  }

  void addLike(String productId) {
    if (!state.contains(productId)) {
      state = {...state, productId};
    }
  }

  void toggleLike(String productId) {
    if (state.contains(productId)) {
      // state = {...state}..remove(productId);
      state = state.where((id) => id != productId).toSet();
    } else {
      state = {...state, productId};
    }
  }
}