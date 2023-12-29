import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_project_test/data/cart_iteams.dart';
import 'package:bloc_project_test/featues/cart/models/cart_product_data_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartClickOnAddProductEvent>(cartClickOnAddProduct);
    on<CartClickOnMinusProductEvent>(cartClickOnMinusProduct);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    emit(CartLoadedSuccesState(products: cartItems));
  }

  FutureOr<void> cartClickOnAddProduct(
      CartClickOnAddProductEvent event, Emitter<CartState> emit) {
    event.clickedProduct.howManyInCart += 1;
    emit(CartLoadedSuccesState(products: cartItems));
  }

  FutureOr<void> cartClickOnMinusProduct(
      CartClickOnMinusProductEvent event, Emitter<CartState> emit) {
    if (event.clickedProduct.howManyInCart > 1) {
      event.clickedProduct.howManyInCart -= 1;
      emit(CartLoadedSuccesState(products: cartItems));
    } else {
      cartItems.remove(event.clickedProduct);
      emit(CartLoadedSuccesState(products: cartItems));
    }
  }
}
