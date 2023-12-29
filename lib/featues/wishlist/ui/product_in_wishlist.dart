import 'package:bloc_project_test/data/cart_iteams.dart';
import 'package:bloc_project_test/featues/home/bloc/home_bloc.dart';
import 'package:bloc_project_test/featues/home/models/home_product_data_model.dart';
import 'package:bloc_project_test/featues/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductInWishlist extends StatefulWidget {
  final HomeBloc homeBloc;
  final ProductDataModel model;
  const ProductInWishlist(
      {super.key, required this.model, required this.homeBloc});

  @override
  State<ProductInWishlist> createState() => _ProductInWishlistState();
}

class _ProductInWishlistState extends State<ProductInWishlist> {
  late final WishlistBloc wishlistBloc;

  @override
  void initState() {
    wishlistBloc = BlocProvider.of<WishlistBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        bool isInCart =
            cartItems.where((e) => e.model == widget.model).isNotEmpty;
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
                        image: NetworkImage(widget.model.imageUrl))),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.model.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(widget.model.category),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${widget.model.price}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          widget.homeBloc.add(
                            HomeProductCartButtonClickedEvent(
                                clickedProduct: widget.model),
                          );
                        },
                        icon: Icon(Icons.shopping_bag_outlined,
                            color: (isInCart ? Colors.green : Colors.black)),
                      ),
                      IconButton(
                        onPressed: () {
                          wishlistBloc.add(
                            WishlistClickOnDeleteProduct(
                              clickedProduct: widget.model,
                              homeBloc: widget.homeBloc,
                            ),
                          );
                        },
                        icon: const Icon(Icons.remove_circle_outline,
                            color: Colors.red),
                      ),
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
}
