import 'dart:async';
import 'dart:convert';

import 'package:untitled/model/api/base_api.dart';

import '../entities/product.dart';

/// TODO: refactor
class ProductApi extends BaseApi {
  Future<List<Product>> fetchProducts({
    int offset = 0,
    int limit = 10,
  }) async {
    final response = await sendGetRequest("common/product/list", offset, limit);
    return parseProducts(response.body);
  }

  List<Product> parseProducts(String responseBody) {
    final parsed =
        jsonDecode(responseBody)["data"].cast<Map<String, dynamic>>();

    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }
}
