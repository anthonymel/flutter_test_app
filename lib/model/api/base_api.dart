import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

class BaseApi {
  static const applicationKey =
      'phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF';
  static const url = "ostest.whitetigersoft.ru";

  final httpClient = http.Client();

  Future<http.Response> sendGetRequest({
    required String method,
    Map<String, dynamic> params = const {},
  }) async {
    return await http.get(
        buildUrlQuery(
          method: method,
          params: params,
        ),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
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
