import 'package:flutter/material.dart';
import 'package:products_project/providers/product_provider.dart';
import 'package:products_project/widgets/app_bar_store.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:go_router/go_router.dart';
class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarNavigation(),
      body: SingleChildScrollView(
        child: Container(

            alignment: Alignment.topRight,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Image.network(
                    context.watch<ProductProvider>().product!.picture!,
                    width: 500,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.watch<ProductProvider>().product!.title!,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900)),
                      Column(
                        children: [
                          Text(
                              "${context.watch<ProductProvider>().product!.price!}€",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700)),
                          Text(
                              " ${context.watch<ProductProvider>().product!.discountPercentage!}%",
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 15),
                  child: Row(
                    children: [
                      Text(context.watch<ProductProvider>().product!.brand!,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                      context.watch<ProductProvider>().product!.description!,
                      style:
                          const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          "Stock : ${context.watch<ProductProvider>().product!.stock!}",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      context.read<ProductProvider>().product!.category!,
                      style: const TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.w900),
                    ),
                    RatingStars(
                      value: context.watch<ProductProvider>().product!.rating!
                          as double,
                      starBuilder: (index, color) => Icon(
                        Icons.star,
                        color: color,
                        size: 30,
                      ),
                      starCount: 5,
                      starSize: 30,
                      valueLabelColor: const Color(0xff9b9b9b),
                      valueLabelTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 12.0),
                      valueLabelRadius: 10,
                      maxValue: 5,
                      starSpacing: 1,
                      maxValueVisibility: false,
                      valueLabelVisibility: false,
                      animationDuration: const Duration(milliseconds: 3000),
                      starOffColor: const Color(0xffe7e8ea),
                      starColor: Colors.yellow,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                      onPressed: () {
                        context.read<ProductProvider>().productAlreadyExistsOrNot(context.read<ProductProvider>().product!);
                        if(context.read<ProductProvider>().productAlreadyExistsState==true){
                          DialogExample.dialogBuilder(context);
                        }else{
                          context.read<ProductProvider>().cartListAdd(
                              context.read<ProductProvider>().product!);
                        }

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text('Add to cart',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700)),
                          Icon(
                            Icons.add_shopping_cart_outlined,
                            size: 30,
                          ),
                        ],
                      )),
                ),

              ],
            )),
      ),
    );
  }
}







//alert dialog showing when trying to add to cart a product that already existe




class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: OutlinedButton(
          onPressed: () => dialogBuilder(context),
          child: const Text('Open Dialog'),
        ),
    );
  }

  static Future<void> dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Product already exists in your cart'),
          content: const Text("Le petit probleme c'est quand on va revenir a la page d'accueil et rechoisir le meme produit il va pas trouver dans la liste sauf si on reste sur la page du produit et on reclique plusieurs fois sur add to cart je crois le probleme c'est dans le provider j'ai cartList.contains(product) à mon avis et verifier que le dernier index"),
          actions: <Widget>[

            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Understand'),
              onPressed: () {
                Navigator.of(context).pop();
                context.pushNamed('cart');

              },
            ),
          ],
        );
      },
    );
  }
}
