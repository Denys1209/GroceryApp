import 'package:bloc_project_test/core/Constants/Constants.dart';
import 'package:bloc_project_test/featues/home/bloc/home_bloc.dart';
import 'package:bloc_project_test/featues/home/ui/product_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeBloc,
      child: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {
          if (state is HomeNavigateToCartPageActionState) {
            _onCartPressed(context);
          } else if (state is HomeNavigateToWishlistPageActionState) {
            _onWishlistPressed(context);
          } else if (state is HomeProductItemCartedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item carted'),
              ),
            );
          } else if (state is HomeProductItemWishlistedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item wishlisted'),
              ),
            );
          } else if (state is HomeProductRemoveItemWishlistedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item removed from your wishlist'),
              ),
            );
          } else if (state is HomeRemoveProductState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item removed from your cart'),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoadingState:
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case HomeLoadedSuccessState:
              final successState = state as HomeLoadedSuccessState;
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text('Grocery App'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HomeWishlistButtonNavigateEvent());
                        },
                        icon: const Icon(Icons.favorite_border)),
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HomeCartButtonNavigateEvent());
                        },
                        icon: const Icon(Icons.shopping_bag_outlined)),
                  ],
                ),
                drawer: _drawer(),
                body: ListView.builder(
                    itemCount: successState.products.length,
                    itemBuilder: (context, index) {
                      return ProductTileWidget(
                        productDataModel: successState.products[index],
                      );
                    }),
              );

            case HomeErrorState:
              return const Scaffold(
                body: Center(
                  child: Text("Error during loading"),
                ),
              );
            default:
              return const Scaffold(
                body: Center(
                  child: Text("Error"),
                ),
              );
          }
        },
      ),
    );
  }

  void _onCartPressed(BuildContext context) {
    Navigator.pushNamed(context, Constants.cartPageRount);
  }

  void _onWishlistPressed(BuildContext context) {
    Navigator.pushNamed(context, Constants.wishlistPageRount);
  }

  _drawer() {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Your account'),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
            ),
            title: const Text('Page 1'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.train,
            ),
            title: const Text('Page 2'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
