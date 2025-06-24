import 'package:ecom_app/core/routes/routes_name.dart';
import 'package:ecom_app/features/auth/presentation/screen/login_screen.dart';
import 'package:ecom_app/features/dashboard/presentation/screen/dashboard_screen.dart';
import 'package:ecom_app/features/products/domain/model/product_model.dart';
import 'package:ecom_app/features/products/presentation/screen/product_details_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
     Object? argument = settings.arguments;
      
    switch (settings.name) {
      case RoutesName.loginScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const LoginScreen(),
        );
      case RoutesName.dashboardScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const DashboardScreen(),
        );
        case RoutesName.productDetail:
       if(argument is ProductModel){
         return MaterialPageRoute(
          settings: settings,
          builder: (_) => ProductDetailsScreen(product:argument),
        );
       }else{
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const Scaffold(
              body: Center(child: Text('Error: Invalid product data')),
            ),
          );
       }

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => const LoginScreen(),
        );
    }
  }
}
