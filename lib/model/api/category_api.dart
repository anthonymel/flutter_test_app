import 'dart:async';
import 'dart:convert';

import 'package:untitled/model/api/base_api.dart';
import 'package:untitled/model/entities/category.dart';

class CategoryApi extends BaseApi {
  Future<List<Category>> loadCategories({
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
    return parseCategories(response.body);
  }

  List<Category> parseCategories(String responseBody) {
    final parsed = jsonDecode(responseBody)["data"]["categories"]
        .cast<Map<String, dynamic>>();

    return parsed.map<Category>((json) => Category.fromJson(json)).toList();
  }
}
