import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:untitled/model/entities/product.dart';

@JsonSerializable()
class Cart extends ChangeNotifier {
  Map cartProductsJson = {};
  List<Product> cartProducts = [];

  void addToCart(Product product) {
    if (cartProductsJson.containsKey(product.productId)) {
      cartProductsJson[product.productId]++;
    } else {
      cartProductsJson[product.productId] = 1;
    }
    log(cartProductsJson.toString());
    notifyListeners();
  }

  void removeFromCart(Product product) {
    if (cartProductsJson.containsKey(product.productId) && cartProductsJson[product.productId] > 0) {
      cartProductsJson[product.productId]--;
    }
    log(cartProductsJson.toString());
    notifyListeners();
  }

  int getCountFromCart(Product product) {
    return cartProductsJson.containsKey(product.productId) ? cartProductsJson[product.productId] : 0;
  }

  List<Map<dynamic, dynamic>> prepareCartForCalculating() {
    var result = <Map<dynamic, dynamic>>[];
    cartProductsJson.forEach((key, value) {
      result.add({"productId": key, "itemCount": value});
    });
    return result;
  }
}
