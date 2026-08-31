# 🛍️ E-Shop — Application Mobile E-Commerce & Feed Interactif

**E-Shop** est une application Flutter moderne combinant l'expérience d'une boutique e-commerce classique avec un fil d'actualité vidéo/photo vertical immersif inspiré des réseaux sociaux (TikTok / Reels). Elle offre une navigation hybride ultra-fluide grâce au swipe horizontal et au state management réactif basé sur **Flutter Riverpod**.

---

## Aperçu des Fonctionnalités

### Navigation Hybride & Entête Dynamique
* **Défilement Horizontal (Swipe PageView) :** Basculement instantané entre le module **Boutique** (index `0`) et le module **Découverte** (index `1`).
* **Header Interactif (`FeedTopHeader`) :** Indicateur d'onglet actif avec soulignage animé et intégration du badge du panier en temps réel.

### Module Boutique (`features/catalog`)
* **Barre de recherche instantanée :** Filtrage dynamique par nom de produit et marque.
* **Filtres par catégories :** Choix dynamique via des `ChoiceChip` défilables horizontalement.
* **Grille Produit Responsive :** Affichage adaptatif avec image principale, prix, marque et titre.

### Module Découverte (`features/discovery_feed`)
* **Feed Vidéo/Photo Plein Écran :** Scroll vertical infini des articles présentés sous forme de vidéos ou photos HD.
* **Gestes & Animations d'Interaction :** Double-tap sur l'écran pour liker un produit, déclenchant une animation de cœur volante au point exact du toucher et l'ajout automatique à la wishlist (`wishlistProvider`).
* **Informations & Actions Superposées :**
  * Description produit extensible inline (`InlineExpandableText`).
  * Boutons d'action rapides (Like, Partage, Commentaires).
  * Bouton d'achat direct ouvrant la fiche produit.

### Module Panier (`features/cart`)
* **Gestion centralisée de la commande :** Ajout d'articles avec variantes (tailles, couleurs) et quantités.
* **Calcul automatique :** Mise à jour en temps réel du total et décompte dynamique du badge dans la barre supérieure.

---

## Architecture & Structure du Projet

Le projet suit une **architecture orientée fonctionnalités (Feature-First / Clean Architecture)** pour garantir la scalabilité, la réutilisabilité des composants et un testabilité optimale.



``` text
e-shop.git/
├── .gitignore
├── .metadata
├── README.md
├── analysis_options.yaml
├── android/
├── ios/
├── lib/
│   ├── app/
│   │   ├── app.dart
│   │   ├── app_router.dart
│   │   └── app_theme.dart
│   ├── core/
│   │   ├── constants/
│   │   │   └── app_constants.dart
│   │   ├── errors/
│   │   │   └── failure.dart
│   │   ├── network/
│   │   │   └── api_client.dart
│   │   └── usecases/
│   │       └── use_case.dart
│   ├── features/
│   │   ├── account/
│   │   │   └── presentation/
│   │   │       └── pages/
│   │   │           └── account_page.dart
│   │   ├── cart/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   └── cart_local_data_source.dart
│   │   │   │   ├── models/
│   │   │   │   │   └── cart_item_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── cart_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── cart_item.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── cart_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       └── add_item_to_cart.dart
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── cart_page.dart
│   │   │       ├── providers/
│   │   │       │   └── cart_provider.dart
│   │   │       └── widgets/
│   │   │           └── cart_item_tile.dart
│   │   ├── catalog/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   └── catalog_remote_data_source.dart
│   │   │   │   ├── models/
│   │   │   │   │   └── product_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── catalog_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── product.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── catalog_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       └── get_products.dart
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── catalog_page.dart
│   │   │       ├── providers/
│   │   │       │   ├── catalog_provider.dart
│   │   │       │   └── wishlist_provider.dart
│   │   │       └── widgets/
│   │   │           ├── product_card.dart
│   │   │           ├── product_comments_bottom_sheet.dart
│   │   │           ├── product_details_bottom_sheet.dart
│   │   │           └── product_info_card.dart
│   │   ├── checkout/
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── order.dart
│   │   │   │   └── usecases/
│   │   │   │       └── place_order.dart
│   │   │   └── presentation/
│   │   │       └── pages/
│   │   │           └── checkout_page.dart
│   │   ├── discovery_feed/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   └── discovery_feed_remote_data_source.dart
│   │   │   │   ├── models/
│   │   │   │   │   └── shoppable_video_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── discovery_feed_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── shoppable_video.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── discovery_feed_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       └── get_discovery_feed.dart
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── discovery_feed_page.dart
│   │   │       └── widgets/
│   │   │           ├── feed_action_buttons.dart
│   │   │           ├── feed_media_view.dart
│   │   │           ├── feed_top_header.dart
│   │   │           ├── feed_video_player.dart
│   │   │           ├── inline_expandable_text.dart
│   │   │           ├── like_heart_overlay.dart
│   │   │           └── shoppable_video_card.dart
│   │   ├── orders/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   └── orders_remote_data_source.dart
│   │   │   │   ├── models/
│   │   │   │   │   └── order_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── orders_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── order_summary.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── orders_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       └── get_order_history.dart
│   │   │   └── presentation/
│   │   │       └── pages/
│   │   │           └── order_history_page.dart
│   │   └── product_details/
│   │       ├── domain/
│   │       │   ├── entities/
│   │       │   │   └── product_details.dart
│   │       │   └── usecases/
│   │       │       └── get_product_details.dart
│   │       └── presentation/
│   │           ├── pages/
│   │           │   └── product_details_page.dart
│   │           └── widgets/
│   │               └── add_to_cart_button.dart
│   └── main.dart
├── linux/
├── macos/
├── pubspec.lock
├── pubspec.yaml
├── test/
│   └── widget_test.dart
├── web/
└── windows/
```