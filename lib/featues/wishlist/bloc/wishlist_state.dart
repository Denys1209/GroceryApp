part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

abstract class WishlistActionState extends WishlistState {}

final class WishlistInitial extends WishlistState {}

class WishlistLoadingState extends WishlistState {}

class WishlistLoadedSuccesState extends WishlistState {
  final List<ProductDataModel> products;
  WishlistLoadedSuccesState({
    required this.products,
  });
}
