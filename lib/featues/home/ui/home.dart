import 'package:bloc_project_test/core/Constants/Constants.dart';
import 'package:bloc_project_test/domain/repository/product_repository.dart';
import 'package:bloc_project_test/domain/repository/user_repository.dart';
import 'package:bloc_project_test/featues/home/bloc/home_bloc.dart';
import 'package:bloc_project_test/featues/home/ui/product_tile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeBloc homeBloc;
  late UserRepository userRepository;

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    userRepository = RepositoryProvider.of<UserRepository>(context);
    homeBloc.add(
      HomeInitialEvent(
        productRepository: ProductRepository(),
      ),
    );
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
                drawer: _drawer(userRepository.currentUser),
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

  _drawer(User? user) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: DrawerHeader(
              padding: const EdgeInsets.all(0),
              decoration: const BoxDecoration(
                color: Constants.drawerColor,
              ),
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  color: Constants.drawerColor,
                ),
                accountName: const Text(
                  "Abhishek Mishra",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text("${user?.email}"),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 165, 255, 137),
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 30.0, color: Colors.blue),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Add a new product'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Constants.addProcutPageRount);
            },
          ),
          ListTile(
            leading: const Icon(Icons.workspace_premium),
            title: const Text(' Go Premium '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.video_label),
            title: const Text(' Saved Videos '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text(' Edit Profile '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () {
              context.read<UserRepository>().signOut();
              Navigator.pop(context);
              Navigator.pushNamed(context, Constants.signUpPageRount);
            },
          ),
        ],
      ),
    );
  }
}
