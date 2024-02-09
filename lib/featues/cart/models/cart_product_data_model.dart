import 'package:bloc_project_test/domain/entities/product_data_model.dart';

class CartProductDataModel {
  ProductDataModel model;
  int howManyInCart;

  CartProductDataModel({
    required this.howManyInCart,
    required this.model,
  });
}
