import 'dart:ffi';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:bloc_project_test/domain/repository/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/physics.dart';
import 'package:formz/formz.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._productRepository) : super(ProductState());

  final ProductRepository _productRepository;

  void emitName(String name) {
    emit(
      state.copyWith(
          name: name,
          isValid: (name.isNotEmpty &&
              state.price.toString().isNotEmpty &&
              state.description.isNotEmpty &&
              state.image != null)),
    );
  }

  void emitPrice(double price) {
    emit(
      state.copyWith(
        price: price,
        isValid: (state.name.isNotEmpty &&
            price.toString().isNotEmpty &&
            state.description.isNotEmpty &&
            state.image != null),
      ),
    );
  }

  void emitDescription(String description) {
    emit(
      state.copyWith(
        description: description,
        isValid: (state.name.isNotEmpty &&
            state.price.toString().isNotEmpty &&
            description.isNotEmpty &&
            state.image != null),
      ),
    );
  }

  void emitImage(Uint8List image) {
    emit(
      state.copyWith(
        image: image,
        isValid: (state.name.isNotEmpty &&
            !state.price.isNegative &&
            state.description.isNotEmpty),
      ),
    );
  }

  Future<void> productSubmitForm() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _productRepository.createProduct(
        state.name,
        state.description,
        state.price,
        state.image!,
      );
      emit(const ProductState(
        status: FormzSubmissionStatus.success,
      ));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
        ),
      );
    }
  }
}
