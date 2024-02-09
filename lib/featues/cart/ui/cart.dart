import 'package:bloc_project_test/data/cart_iteams.dart';
import 'package:bloc_project_test/featues/cart/bloc/cart_bloc.dart';
import 'package:bloc_project_test/featues/cart/cubit/price_cubit.dart';
import 'package:bloc_project_test/featues/cart/ui/product_in_cart.dart';
import 'package:bloc_project_test/featues/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();
  final PriceCubit priceCubit = PriceCubit();
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(
          create: (BuildContext context) => cartBloc,
        ),
        BlocProvider<PriceCubit>(
          create: (BuildContext context) => priceCubit,
        ),
      ],
      child: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartLoadingState:
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case CartLoadedSuccesState:
              final successState = state as CartLoadedSuccesState;
              double price = 0;
              state.products.forEach(
                (element) {
                  price += element.model.price * element.howManyInCart;
                },
              );
              priceCubit.set(price);
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Your cart"),
                  centerTitle: true,
                  leading: Builder(
                    builder: (context) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _onBackButtonTapped(context),
                      child: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                  actions: [
                    cartItems.isNotEmpty
                        ? ElevatedButton(
                            onPressed: null,
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.green),
                            ),
                            child: BlocBuilder<PriceCubit, double>(
                              builder: (context, state) {
                                return Text(
                                  '${state.toString()}\$',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      width: 20.0,
                    ),
                  ],
                ),
                body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductInCart(
                      model: successState.products[index],
                      homeBloc: BlocProvider.of<HomeBloc>(context),
                    );
                  },
                ),
              );
            default:
              return const Scaffold(
                body: Center(
                  child: Text("Error Cart"),
                ),
              );
          }
        },
      ),
    );
  }

  _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }
}
