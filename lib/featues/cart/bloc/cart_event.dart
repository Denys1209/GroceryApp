part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartClickOnMinusProductEvent extends CartEvent {
  final CartProductDataModel clickedProduct;

  CartClickOnMinusProductEvent({required this.clickedProduct});
}

class CartClickOnAddProductEvent extends CartEvent {
  final CartProductDataModel clickedProduct;

  CartClickOnAddProductEvent({required this.clickedProduct});
}
