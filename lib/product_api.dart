import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';

import 'product.dart';


class ProductApi {
  Future<List<Product>> fetchProducts(http.Client client, int offset, int limit) async {
    const key = "phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF";
    final response = await client
        .get(Uri.parse('http://ostest.whitetigersoft.ru/api/common/product/list?appKey=$key&offset=$offset&limit=$limit'));

    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parseProducts, response.body);
  }

  List<Product> parseProducts(String responseBody) {
    final parsed = jsonDecode(responseBody)["data"].cast<Map<String, dynamic>>();

    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }
}
