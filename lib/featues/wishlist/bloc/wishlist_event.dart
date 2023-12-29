part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent {}

class WishlistClickOnDeleteProduct extends WishlistEvent {
  final ProductDataModel clickedProduct;
  final HomeBloc homeBloc;

  WishlistClickOnDeleteProduct(
      {required this.clickedProduct, required this.homeBloc});
}

class WishlistClickOnCartProduct extends WishlistEvent {
  final ProductDataModel clickedProduct;

  WishlistClickOnCartProduct({required this.clickedProduct});
}
