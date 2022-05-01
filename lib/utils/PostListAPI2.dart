import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mizomade/models/PostListModel.dart';
import 'package:mizomade/utils/API.dart';

class RemoteApi {
  static Future<List<PostListModel>> getCharacterList(
    int offset,
    int limit, {
    String page,
  }) async =>
      http
          .get(
            _ApiUrlBuilder.characterList(offset, limit, page: page),
          )
          .mapFromResponse<List<PostListModel>, List<dynamic>>(
            (jsonArray) => _parseItemListFromJsonArray(
              jsonArray,
              (jsonObject) => PostListModel.fromJson(jsonObject),
            ),
          );

  static List<T> _parseItemListFromJsonArray<T>(
    List<dynamic> jsonArray,
    T Function(dynamic object) mapper,
  ) =>
      jsonArray.map(mapper).toList();
}

class GenericHttpException implements Exception {}

class NoConnectionException implements Exception {}

class _ApiUrlBuilder {
  static const _baseUrl = API_URL;
  static const _charactersResource = 'posts/';

  static Uri characterList( int offset,int limit, { String page,}) =>
      Uri.parse(
        '$_baseUrl$_charactersResource?'
        // 'offset=$offset'
        // '&limit=$limit'    // 'offset=$offset'
        // '&limit=$limit'
        '${_buildSearchTermQuery(page)}',
      );

  static String _buildSearchTermQuery(String page) =>
      page != null && page.isNotEmpty
          // ? '&page=${page.replaceAll(' ', '+').toLowerCase()}'
          ? '&page=$page'
          : '';
}

extension on Future<http.Response> {
  Future<R> mapFromResponse<R, T>(R Function(T) jsonParser) async {
    try {
      final response = await this;
      print("HERE");
      if (response.statusCode == 200) {
        print(response.body);
        print("RETURNING");
        return jsonDecode(response.body);
      } else {
        throw GenericHttpException();
      }
    } on SocketException {
      throw NoConnectionException();
    }
  }
}
