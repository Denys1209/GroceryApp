class ProductDataModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  ProductDataModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl});

  static ProductDataModel fromMap(Map<String, dynamic> map) {
    return ProductDataModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        price: map['price'],
        imageUrl: map['imageUrl']);
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "description": description,
        "imageUrl": imageUrl,
        "id": id,
      };
}
