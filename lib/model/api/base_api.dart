import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:untitled/model/entities/product.dart';

class BaseApi {
  final httpClient = http.Client();
  static const key =
      "phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF";
  static const url = "http://ostest.whitetigersoft.ru/api";

  Future sendGetRequest(String method, Map params) {
    String buildQuery = '$url/' + buildUrlQuery(method + '?appKey=$key', params);

    return httpClient.get(Uri.parse(buildQuery));
  }

  String buildUrlQuery (String method, Map params) {
    String url = method;
    params.forEach((paramName, paramValue) { url += "&$paramName=$paramValue";});

    return url;
  }
}
