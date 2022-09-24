import 'package:flutter/material.dart';
import 'package:products_project/providers/product_provider.dart';
import 'package:products_project/widgets/app_bar_store.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);

  num sum = 0;
  bool cartIsEmpty = true;

  num getSumCart(BuildContext context) {
    List cartList = context.read<ProductProvider>().cartList;
    for (dynamic value in cartList) {
      sum += value.price;
    }
    return sum;
  }

  List<Widget> getProductsCart(BuildContext context) {
    List cartList = context.read<ProductProvider>().cartList;
    List<Widget> list = [];

    if (cartList.length == 0) {
      cartIsEmpty = true;
      list.add(Container(
        height: MediaQuery.of(context).size.height - 300,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Empty cart",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                Icon(Icons.remove_shopping_cart_sharp)
              ],
            )
          ],
        ),
      ));
      return list;
    } else {
      cartIsEmpty = false;
      for (dynamic value in cartList) {
        list.add(Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                subtitle: Row(
                  children: [
                    Text("Qte : ${value.cartQte!}",
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w900))
                  ],
                ),
                title: Text(value.title,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w900)),
                trailing: Text("${value.price}€",
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w700)),
                leading: Image.network(
                  value.picture,
                  width: 100,
                  height: 250,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ));
      }
      return list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarNavigation(),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: getProductsCart(context),
              ),
              const Divider(
                height: 20,
                thickness: 2,
                indent: 3,
                endIndent: 3,
                color: Colors.black,
              ),
              Column(children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Total : ${getSumCart(context)}€',
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w900))
                    ],
                  ),
                )
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.pushNamed('home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      fixedSize: const Size(200, 50),
                    ),
                    child: const Text('Products'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
