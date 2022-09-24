import 'package:flutter/material.dart';
import 'package:products_project/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class AppBarNavigation extends StatelessWidget implements PreferredSizeWidget {
  const AppBarNavigation({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return AppBar(
      actions: [
        Row(
          children: [
            Text("${context.watch<ProductProvider>().cartList.length}"),
            IconButton(icon: const Icon(Icons.shopping_cart_sharp), onPressed: (){
              context.pushNamed('cart');
            }, ),
          ],
        )
      ],
      title:  const Text('My store  ' ),
      backgroundColor: Colors.deepPurple,
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(50);
}


