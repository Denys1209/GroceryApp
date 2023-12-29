import 'package:bloc_project_test/data/cart_iteams.dart';
import 'package:bloc_project_test/data/wishlist_items.dart';
import 'package:bloc_project_test/featues/cart/models/cart_product_data_model.dart';
import 'package:bloc_project_test/featues/home/bloc/home_bloc.dart';
import 'package:bloc_project_test/featues/home/models/home_product_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductTileWidget extends StatefulWidget {
  final ProductDataModel productDataModel;

  const ProductTileWidget({
    super.key,
    required this.productDataModel,
  });

  @override
  State<ProductTileWidget> createState() => _ProductTileWidgetState();
}

class _ProductTileWidgetState extends State<ProductTileWidget> {
  late final HomeBloc homeBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeBloc = context.read<HomeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        bool isInWishlisted = wishlistItems.contains(widget.productDataModel);
        bool isInCart = cartItems
            .where((e) => e.model == widget.productDataModel)
            .isNotEmpty;
        CartProductDataModel? productInCart = cartItems
            .where((e) => e.model == widget.productDataModel)
            .firstOrNull;
        return Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.productDataModel.imageUrl))),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.productDataModel.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(widget.productDataModel.category),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${widget.productDataModel.price}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          homeBloc
                              .add(HomeProductWishlistButtonClickedOnAddEvent(
                            clickedProduct: widget.productDataModel,
                          ));
                        },
                        icon: _generateFavoriteIcon(isInWishlisted),
                      ),
                      _generateCartIcon(isInCart, productInCart),
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  _generateFavoriteIcon(bool isClicked) {
    if (isClicked) {
      return const Icon(
        Icons.favorite,
        color: Colors.red,
      );
    } else {
      return const Icon(
        Icons.favorite_border_outlined,
      );
    }
  }

  _generateCartIcon(bool isClicked, CartProductDataModel? product) {
    if (!isClicked) {
      return IconButton(
        onPressed: () {
          homeBloc.add(HomeProductCartButtonClickedEvent(
              clickedProduct: widget.productDataModel));
        },
        icon: const Icon(
          Icons.shopping_bag_outlined,
        ),
      );
    } else {
      return Row(
        children: [
          IconButton(
            onPressed: () {
              homeBloc
                  .add(HomeClickOnAddProductEvent(clickedProduct: product!));
            },
            icon: const Icon(
              Icons.add_circle_outline,
              color: Colors.green,
            ),
          ),
          Text(product!.howManyInCart.toString()),
          IconButton(
            onPressed: () {
              homeBloc
                  .add(HomeClickOnMinusProductEvent(clickedProduct: product!));
            },
            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
          ),
        ],
      );
    }
  }
}
