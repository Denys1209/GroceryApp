import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_project_test/data/cart_iteams.dart';
import 'package:bloc_project_test/data/grocery_data.dart';
import 'package:bloc_project_test/data/wishlist_items.dart';
import 'package:bloc_project_test/domain/entities/product_data_model.dart';
import 'package:bloc_project_test/domain/repository/product_repository.dart';
import 'package:bloc_project_test/featues/cart/bloc/cart_bloc.dart';
import 'package:bloc_project_test/featues/cart/cubit/price_cubit.dart';
import 'package:bloc_project_test/featues/cart/models/cart_product_data_model.dart';
import 'package:flutter/material.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickedOnAddEvent>(
        homeProductWishlistButtonClickedEvent);
    on<WishlistButtonClickedOnRemoveEvent>(wishlistButtonClickedOnRemoveEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeClickOnAddProductEvent>(homeClickOnAddProductEvent);
    on<HomeClickOnMinusProductEvent>(homeClickOnMinusProductEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    final products = await event.productRepository.getAllProducts();
    emit(HomeLoadedSuccessState(products: products));
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedOnAddEvent event,
      Emitter<HomeState> emit) {
    if (!wishlistItems.contains(event.clickedProduct)) {
      wishlistItems.add(event.clickedProduct);
      emit(HomeProductItemWishlistedActionState());
    } else {
      wishlistItems.remove(event.clickedProduct);
      emit(HomeProductRemoveItemWishlistedActionState());
    }
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    if (cartItems.where((e) => e.model == event.clickedProduct).isEmpty) {
      cartItems.add(
          CartProductDataModel(howManyInCart: 1, model: event.clickedProduct));
      emit(HomeProductItemCartedActionState());
    } else {
      cartItems.removeWhere((e) => e.model == event.clickedProduct);
      emit(HomeRemoveProductState());
    }
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeClickOnAddProductEvent(
      HomeClickOnAddProductEvent event, Emitter<HomeState> emit) {
    event.clickedProduct.howManyInCart += 1;
    if (event.priceCubit != null) {
      event.priceCubit!.add(event.clickedProduct.model.price);
    }
    emit(HomeClickOnAddProductSate());
  }

  FutureOr<void> homeClickOnMinusProductEvent(
      HomeClickOnMinusProductEvent event, Emitter<HomeState> emit) {
    if (event.clickedProduct.howManyInCart > 1) {
      event.clickedProduct.howManyInCart -= 1;
      if (event.priceCubit != null) {
        event.priceCubit!.minus(event.clickedProduct.model.price);
      }
      emit(HomeClickOnMinusProductState());
    } else {
      cartItems.remove(event.clickedProduct);
      if (event.cartBloc != null) {
        event.cartBloc!.add(
            CartClickOnMinusProductEvent(clickedProduct: event.clickedProduct));
      }
      if (event.priceCubit != null) {
        event.priceCubit!.minus(event.clickedProduct.model.price);
      }
      emit(HomeRemoveProductState());
    }
  }

  FutureOr<void> wishlistButtonClickedOnRemoveEvent(
      WishlistButtonClickedOnRemoveEvent event, Emitter<HomeState> emit) {
    wishlistItems.remove(event.clickedProduct);
    emit(HomeProductRemoveItemWishlistedActionState());
  }
}
