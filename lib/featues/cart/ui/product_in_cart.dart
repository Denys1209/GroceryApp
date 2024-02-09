import 'package:bloc_project_test/featues/cart/bloc/cart_bloc.dart';
import 'package:bloc_project_test/featues/cart/cubit/price_cubit.dart';
import 'package:bloc_project_test/featues/cart/models/cart_product_data_model.dart';
import 'package:bloc_project_test/featues/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductInCart extends StatefulWidget {
  final CartProductDataModel model;
  final HomeBloc homeBloc;
  const ProductInCart({super.key, required this.model, required this.homeBloc});

  @override
  State<ProductInCart> createState() => _ProductInCartState();
}

class _ProductInCartState extends State<ProductInCart> {
  late final CartBloc cartBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    cartBloc = BlocProvider.of<CartBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
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
                    image: NetworkImage(
                      widget.model.model.imageUrl,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.model.model.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(widget.model.model.description),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${widget.model.model.price}",
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
                            HomeClickOnAddProductEvent(
                              clickedProduct: widget.model,
                              cartBloc: cartBloc,
                              priceCubit: BlocProvider.of<PriceCubit>(context),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: Colors.green,
                        ),
                      ),
                      Text(widget.model.howManyInCart.toString()),
                      IconButton(
                        onPressed: () {
                          widget.homeBloc.add(
                            HomeClickOnMinusProductEvent(
                              clickedProduct: widget.model,
                              cartBloc: cartBloc,
                              priceCubit: BlocProvider.of<PriceCubit>(context),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red,
                        ),
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
