import 'package:flutter/material.dart';
import 'package:products_project/providers/product_provider.dart';
import 'package:products_project/services/api_product_service.dart';
import 'package:products_project/widgets/app_bar_store.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color cardColor = const Color(0xffF6F0F3);

  final ApiProductService _apiProductService = ApiProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
        appBar: const AppBarNavigation(),
        body: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Container(
            alignment: Alignment.center,
            child: FutureBuilder(
              future: _apiProductService.getProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var products = snapshot.data as List;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: products.length,
                      itemBuilder: (context, index) => Container(
                            alignment: Alignment.center,
                            height: 100,
                            margin: const EdgeInsets.symmetric(vertical: 1),
                            color: cardColor,
                            child: ListTile(
                              title: Text(products[index].title , style: const TextStyle(color: Colors.black , fontWeight: FontWeight.w900),),
                              leading: Container(
                                  child: Image.network(
                                products[index].picture,
                                width: 100,
                                height: 200,
                                fit: BoxFit.fill,
                              )),
                              subtitle: Text(products[index].brand , style: const TextStyle(color: Colors.black , fontWeight: FontWeight.w600)),
                              trailing: Text("${products[index].price}€" , style: const TextStyle(color: Colors.black , fontWeight: FontWeight.w600)),
                              onTap: (){
                                context.read<ProductProvider>().product = products[index];
                                context.pushNamed('product');
                              },
                            ),
                          ));
                } else {
                  /*print("Data : ${snapshot.data} ");*/
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ));
  }
}
