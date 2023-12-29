class ProductDataModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final String imageUrl;

  ProductDataModel(
      {required this.id,
      required this.name,
      required this.category,
      required this.price,
      required this.imageUrl});

  static ProductDataModel fromMap(Map<String, dynamic> map) {
    return ProductDataModel(
        id: map['id']!,
        name: map['name']!,
        category: map['category']!,
        price: map['price'],
        imageUrl: map['imageUrl']!);
  }
}
