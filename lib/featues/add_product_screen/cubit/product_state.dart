part of 'product_cubit.dart';

final class ProductState extends Equatable {
  const ProductState({
    this.name = "",
    this.description = "",
    this.price = 0,
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.image,
  });
  final String name;
  final String description;
  final double price;
  final Uint8List? image;
  final FormzSubmissionStatus status;
  final bool isValid;
  @override
  List<Object> get props => [name, description, price, status, isValid];

  ProductState copyWith({
    String? description,
    FormzSubmissionStatus? status,
    bool? isValid,
    Uint8List? image,
    String? name,
    double? price,
  }) {
    return ProductState(
      description: description ?? this.description,
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
    );
  }
}
