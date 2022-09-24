import 'dart:convert';

import 'package:http/http.dart' as http;
import '../Models/Product.dart';

class ApiProductService {
  Future getProducts() async {
    Uri _url = Uri.parse('https://dummyjson.com/products');
    http.Response _response = await http.get(_url);

    if (_response.statusCode == 200) {
      final _data = jsonDecode(_response.body);



        return _data['products']
          .map((e) => Product(
                id: e['id'],
                price: e['price'],
                stock: e['stock'],
                discountPercentage: e['discountPercentage'],
                rating: e['rating'],
                title: e['title'],
                description: e['description'],
                category: e['category'],
                picture: e['thumbnail'],
                brand : e['brand'],
              ))
          .toList();
    } else {
      throw Error();
    }
  }
}
