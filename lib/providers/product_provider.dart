import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/Product.dart';

class ProductProvider extends ChangeNotifier {
  Product? _product;

  List cartList = [];
  bool? productAlreadyExistsState;

  void productAlreadyExistsOrNot(Product product) {
    if (cartList.isNotEmpty) {
      if (!cartList.contains(product)) {
        print('not same product');
        productAlreadyExistsState = false;
      } else {
        print('same product');

        productAlreadyExistsState = true;
      }
    }
  }

  void cartListAdd(Product product) {
    if (cartList.isNotEmpty) {
      if (cartList.contains(product)) {
        print('same product');
      } else {
        product.cartQte = 1;
        cartList.add(product);
        print(cartList);
        print('nooooot same product');
      }
    } else {
      product.cartQte = 1;
      cartList.add(product);
      print(cartList);
    }
    notifyListeners();
  }

  Product? get product => _product;

  set product(Product? instanceProduct) {
    _product = instanceProduct;
    notifyListeners();
  }
}
