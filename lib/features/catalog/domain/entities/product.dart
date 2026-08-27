class Product {
  final String id;
  final String title;
  final String brand;
  final double price;
  final String? videoUrl;
  final List<String> imageUrls;
  final String description;
  final List<String> sizes;

  const Product({
    required this.id,
    required this.title,
    required this.brand,
    required this.price,
    this.videoUrl,
    required this.imageUrls,
    this.description = '',
    this.sizes = const [],
  });

  bool get hasVideo => videoUrl != null && videoUrl!.isNotEmpty;
  String get mainImage => imageUrls.isNotEmpty ? imageUrls.first : '';
}