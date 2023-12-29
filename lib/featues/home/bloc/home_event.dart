part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductWishlistButtonClickedOnAddEvent extends HomeEvent {
  final ProductDataModel clickedProduct;

  HomeProductWishlistButtonClickedOnAddEvent({
    required this.clickedProduct,
  });
}

class WishlistButtonClickedOnRemoveEvent extends HomeEvent {
  final ProductDataModel clickedProduct;

  WishlistButtonClickedOnRemoveEvent({
    required this.clickedProduct,
  });
}

class HomeProductCartButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;

  HomeProductCartButtonClickedEvent({
    required this.clickedProduct,
  });
}

class HomeWishlistButtonNavigateEvent extends HomeEvent {}

class HomeCartButtonNavigateEvent extends HomeEvent {}

class HomeClickOnMinusProductEvent extends HomeEvent {
  final CartProductDataModel clickedProduct;
  final CartBloc? cartBloc;

  HomeClickOnMinusProductEvent({required this.clickedProduct, this.cartBloc});
}

class HomeClickOnAddProductEvent extends HomeEvent {
  final CartProductDataModel clickedProduct;

  HomeClickOnAddProductEvent({required this.clickedProduct});
}
