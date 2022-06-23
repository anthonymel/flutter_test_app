import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:untitled/model/api/base_api.dart';

import '../entities/product.dart';
import 'response.dart';

class ProductApi extends BaseApi {
  Future<Response<List<Product>>> loadProducts({
    int offset = 0,
    int limit = 10,
    int? categoryId,
  }) async {
    var params = <String, dynamic>{
      "offset": offset,
      "limit": limit,
      if (categoryId != null) "categoryId": categoryId,
    };

    final response = await sendGetRequest(
      method: "/api/common/product/list",
      params: params,
    );
    try {
      var products =
          response.data.map<Product>((json) => Product.fromJson(json)).toList();
      return Response(
        result: products,
      );
    } catch (e) {
      print(e.toString());
      return Response(
        error: "Products parsing error",
      );
    }
  }

  Future<Response<List<Product>>> loadProductsInCart({
    List<dynamic>? productIds,
  }) async {
    var params = <String, dynamic>{};
    productIds?.forEach((element) {
      params.addAll({"productIds[]": element});
    });

    final response = await sendGetRequest(
      method: "/api/common/product/details",
      params: params,
    );
    try {
      var products =
      response.data.map<Product>((json) => Product.fromJson(json)).toList();
      return Response(
        result: products,
      );
    } catch (e) {
      print(e.toString());
      return Response(
        error: "Products parsing error",
      );
    }
  }

  Future<Response<dynamic>> getCartPrice({
    List<Map<dynamic, dynamic>>? productIds,
  }) async {
    var params = <String, dynamic>{
      "shoppingCartItems": jsonEncode(productIds)
    };

    final response = await sendGetRequest(
      method: "/api/common/order/get-price-info",
      params: params,
    );
    try {
      var result =
      response.data["sumPrice"];
      return Response(
        result: result,
      );
    } catch (e) {
      print(e.toString());
      log('data: $e');
      return Response(
        error: "Cart calculating error",
      );
    }
  }
}
