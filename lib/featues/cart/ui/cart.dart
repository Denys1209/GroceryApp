import 'package:bloc_project_test/featues/cart/bloc/cart_bloc.dart';
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

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartBloc>(
      create: (context) => cartBloc,
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
              return Scaffold(
                appBar: _buildAppBar(),
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

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text("Your cart"),
      centerTitle: true,
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
    );
  }

  _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }
}
