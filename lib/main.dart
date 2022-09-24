import 'package:flutter/material.dart';
import 'package:products_project/providers/product_provider.dart';
import 'package:products_project/services/routing_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider(),)
      ],
      child : const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp

  ({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: Routing.getRoutes().routeInformationParser,
      routeInformationProvider: Routing.getRoutes().routeInformationProvider,
      routerDelegate: Routing.getRoutes().routerDelegate,
    );
  }
}