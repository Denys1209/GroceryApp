import 'package:bloc_project_test/featues/home/bloc/home_bloc.dart';
import 'package:bloc_project_test/featues/wishlist/bloc/wishlist_bloc.dart';
import 'package:bloc_project_test/featues/wishlist/ui/product_in_wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => wishlistBloc,
      child: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is! WishlistActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistLoadingState:
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case WishlistLoadedSuccesState:
              final successState = state as WishlistLoadedSuccesState;
              return Scaffold(
                appBar: _buildAppBar(),
                body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductInWishlist(
                      model: successState.products[index],
                      homeBloc: BlocProvider.of<HomeBloc>(context),
                    );
                  },
                ),
              );
            default:
              return const Scaffold(
                body: Center(
                  child: Text("Error wishlist"),
                ),
              );
          }
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text("Your wishlist"),
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
