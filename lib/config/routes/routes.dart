import 'package:bloc_project_test/core/Constants/Constants.dart';
import 'package:bloc_project_test/featues/cart/ui/cart.dart';
import 'package:bloc_project_test/featues/home/ui/home.dart';
import 'package:bloc_project_test/featues/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Constants.homePageRount:
        return _materialRoute(const Home());
      case Constants.cartPageRount:
        return _materialRoute(const Cart());
      case Constants.wishlistPageRount:
        return _materialRoute(
          Wishlist(),
        );
      default:
        return _materialRoute(const Home());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
