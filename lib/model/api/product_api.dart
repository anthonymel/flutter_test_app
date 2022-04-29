import 'dart:async';

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
}
