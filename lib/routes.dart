import 'package:dentist_app/datasources/models/product.model.dart';
import 'package:dentist_app/pages/home/detail_product/detail_product.page.dart';
import 'package:dentist_app/pages/home/home.page.dart';
import 'package:dentist_app/pages/home/search/search.page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  var router = (BuildContext context) => {
        '/': (context) => const HomePage(),
        '/search': (context) => const SearchPage(),
      };

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/detail_product':
        final product = settings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (context) {
            return DetailPage(product: product);
          },
          settings: settings,
        );
      default:
        return null;
    }
  }
}
