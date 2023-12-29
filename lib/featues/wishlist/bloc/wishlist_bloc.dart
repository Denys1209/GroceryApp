import 'dart:async';
import 'package:bloc_project_test/data/cart_iteams.dart';
import 'package:bloc_project_test/data/wishlist_items.dart';
import 'package:bloc_project_test/featues/cart/models/cart_product_data_model.dart';
import 'package:bloc_project_test/featues/home/bloc/home_bloc.dart';
import 'package:bloc_project_test/featues/home/models/home_product_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistClickOnDeleteProduct>(wishlistClickOnDeleteProduct);
    on<WishlistClickOnCartProduct>(wishlistClickOnCartProduct);
  }

  FutureOr<void> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistState> emit) async {
    emit(WishlistLoadingState());
    emit(
      WishlistLoadedSuccesState(products: wishlistItems),
    );
  }

  FutureOr<void> wishlistClickOnDeleteProduct(
      WishlistClickOnDeleteProduct event, Emitter<WishlistState> emit) {
    event.homeBloc.add(WishlistButtonClickedOnRemoveEvent(
      clickedProduct: event.clickedProduct,
    ));
    emit(WishlistLoadedSuccesState(products: wishlistItems));
  }

  FutureOr<void> wishlistClickOnCartProduct(
      WishlistClickOnCartProduct event, Emitter<WishlistState> emit) {
    cartItems.add(
        CartProductDataModel(howManyInCart: 1, model: event.clickedProduct));
  }
}
