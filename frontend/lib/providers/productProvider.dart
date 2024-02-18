import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hacktkm_frontend/models/product.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    final url = Uri.parse("http://farmer.radr.in/inventory/api/products/");
    final response = await http.get(url);
    final data = response.body;
    List<Product> loadedProducts = [];
    final responseData = jsonDecode(data)["results"];
    for (var i in responseData) {
      loadedProducts.add(Product(

        name: i["name"],
        price: double.parse(i["unit_price"]),
        imageUrl: i["image"],
        description: i["description"],
      ));
    }
    _products = loadedProducts;
    print(_products);


    notifyListeners();
  }

  Future<void> addProduct({required String name,
    required String description,
    required String quantity,
    required double price,
    required File image,
  }) async {
    final url = Uri.parse("https://farmer.radr.in/inventory/api/products/");
    final request = http.MultipartRequest('POST', url);
    final data = {
      "name": name,
      "description": description,
      "available_quantity": quantity,
      "category": "agriculture",
      "unit_price": price.toString(),
      "quantity": quantity,

    };
    request.fields.addAll(data);
    final bytes = await image.readAsBytes();
    request.files.add(http.MultipartFile.fromBytes("image", bytes,
        filename: image.path
            .split("/")
            .last));
    var response = await request.send();

    final value = await response.stream.bytesToString();
    final responseData = jsonDecode(value);
  }
}