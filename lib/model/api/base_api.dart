import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'response.dart';

class BaseApi {
  static const applicationKey =
      'phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF';
  static const url = "ostest.whitetigersoft.ru";

  Future<Response> sendGetRequest({
    required String method,
    Map<String, dynamic> params = const {},
  }) async {
    var httpResponse = await http.get(
        buildUrlQuery(
          method: method,
          params: params,
        ),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    if (httpResponse.statusCode != 200) {
      return Response(
        error: "Http error ${httpResponse.statusCode}",
      );
    }

    var body = httpResponse.body;
    dynamic jsonResponse = {};
    dynamic jsonMeta = {};
    dynamic jsonData = {};

    try {
      jsonResponse = jsonDecode(body);
    } catch (e) {
      return Response(error: "Server response parsing error");
    }

    if (jsonResponse.containsKey("meta") &&
        jsonResponse["meta"]["success"] != false) {
      jsonMeta = jsonResponse["meta"];
    } else {
      return Response(
          error: "Server response error ${jsonResponse["meta"]?["error"]}");
    }

    if (jsonResponse.containsKey("data")) {
      jsonData = jsonResponse["data"];
    } else {
      return Response(error: "Server empty data");
    }

    return Response(
      data: jsonData,
      meta: jsonMeta,
    );
  }

  Uri buildUrlQuery({
    required String method,
    Map<String, dynamic> params = const {},
  }) {
    params['appKey'] = applicationKey;

    return Uri.http(
      url,
      method,
      params.map((key, value) => MapEntry(key, value.toString())),
    );
  }
}
