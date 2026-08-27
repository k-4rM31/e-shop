import 'package:flutter/material.dart';
import 'package:e_shop/app/app_theme.dart';
import 'package:e_shop/features/catalog/domain/entities/product.dart';

class ProductCommentsBottomSheet extends StatefulWidget {
  final Product product;
  const ProductCommentsBottomSheet({ super.key, required this.product });

  static Future<void> show(BuildContext context, Product product) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ProductCommentsBottomSheet(product: product),
    );
  }

  @override
  State<ProductCommentsBottomSheet> createState() => _ProductCommentsBottomSheetState();
}

class _ProductCommentsBottomSheetState extends State<ProductCommentsBottomSheet> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.darkSurface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Poignée de glissement
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
                'Avis des clients',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(color: Colors.white12, height: 24),

              // Contenu (commentaires) défilable 
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Container(
                        constraints: BoxConstraints(minHeight: constraints.maxHeight),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: const Text(
                          'Aucun commentaire pour le moment.',
                          style: TextStyle(color: Colors.white54, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const Divider(color: Colors.white12, height: 24),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          decoration: const InputDecoration(
                            hintText: 'Ajouter un commentaire...',
                            hintStyle: TextStyle(color: Colors.white38),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(9999)),
                            ),
                            
                            isDense: true,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send_rounded, color: AppColors.secondary),
                        onPressed: () {
                          if (_commentController.text.trim().isNotEmpty) {
                            // Logique d'envoi du commentaire ici
                            _commentController.clear();
                          }
                        },
                      ),
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
