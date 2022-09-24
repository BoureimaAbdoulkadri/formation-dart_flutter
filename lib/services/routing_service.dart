import 'package:go_router/go_router.dart';
import 'package:products_project/screens/cart_page.dart';
import 'package:products_project/screens/home_screen.dart';
import 'package:products_project/screens/product_screen.dart';

class Routing {
  static GoRouter getRoutes() {
    return GoRouter(routes: [
      GoRoute(path: '/', name: "home", builder: (context, state) => HomePage()),
      GoRoute(
        path: '/product',
        name: 'product',
        builder: (context, state) => ProductPage(),
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => CartPage(),
      )
    ]);
  }
}
