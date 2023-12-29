part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

abstract class CartActionState extends CartState {}

class CartLoadedSuccesState extends CartState {
  final List<CartProductDataModel> products;
  CartLoadedSuccesState({
    required this.products,
  });
}

class CartLoadingState extends CartState {}
