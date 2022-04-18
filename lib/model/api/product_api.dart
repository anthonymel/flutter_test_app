import 'dart:async';
import 'dart:convert';

import 'package:untitled/model/api/base_api.dart';

import '../entities/product.dart';

class ProductApi extends BaseApi {
  Future<List<Product>> fetchProducts({
    int offset = 0,
    int limit = 10,
    int? categoryId
  }) async {
    Map params = {
      "offset": offset,
      "limit": limit
    };

    if (categoryId != null) {
      params["categoryId"] = categoryId;
    }

    final response = await sendGetRequest("common/product/list", params);
    return parseProducts(response.body);
  }

  List<Product> parseProducts(String responseBody) {
    final parsed =
        jsonDecode(responseBody)["data"].cast<Map<String, dynamic>>();

    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }
}
