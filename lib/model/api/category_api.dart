import 'dart:async';
import 'dart:convert';

import 'package:untitled/model/api/base_api.dart';
import 'package:untitled/model/entities/category.dart';

import 'response.dart';

//TODO: update
class CategoryApi extends BaseApi {
  Future<Response<List<Category>>> loadCategories({
    int offset = 0,
    int limit = 10,
    int? parentId,
  }) async {
    var params = <String, dynamic>{
      "offset": offset,
      "limit": limit,
      if (parentId != null) "parentId": parentId,
    };
    final response = await sendGetRequest(
      method: "/api/common/category/list",
      params: params,
    );

    try {
      var categories = response.data["categories"]
          .map<Category>((json) => Category.fromJson(json))
          .toList();
      return Response(
        result: categories,
      );
    } catch (e) {
      print(e.toString());
      return Response(
        error: "Categories parsing error",
      );
    }
  }
}
