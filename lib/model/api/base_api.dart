import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:untitled/model/entities/product.dart';

class BaseApi {
  final httpClient = http.Client();
  static const key =
      "phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF";
  static const url = "http://ostest.whitetigersoft.ru/api";

  Future sendGetRequest(String method, int? offset, int? limit) {
    String buildQuery = '$url/$method?appKey=$key';

    if (offset != null) {
      buildQuery += "&offset=$offset";
    }

    if (limit != null) {
      buildQuery += "&limit=$limit";
    }

    return httpClient.get(Uri.parse(buildQuery));
  }
}
