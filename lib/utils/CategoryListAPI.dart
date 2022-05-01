import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mizomade/models/PostListModel.dart';
import 'package:mizomade/utils/API.dart';

class CategoryRemoteApi {
  static Future<List<Results>> getCharacterList(int offset, int limit,
          {String searchTerm}) async =>
      http
          .get(
            _ApiUrlBuilder.characterList(offset, limit, searchTerm: searchTerm),
          )
          .mapFromResponse<List<Results>, List<dynamic>>(
            (jsonArray) => _parseItemListFromJsonArray(
              jsonArray,
              (jsonObject) => Results.fromJson(jsonObject),
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
  static const _charactersResource = 'categoryposts/';

  static Uri characterList(
    int offset,
    int limit, {
    String searchTerm,
  }) {
    var values = offset;
    values = values.abs();
    print(values.toString() + " " + limit.toString());
    var res = Uri.parse('$_baseUrl$_charactersResource$searchTerm?'
        // 'offset=$offset'
        // '&limit=$limit'
        'page=$values'

        // '${_buildSearchTermQuery(searchTerm)}',
        );
    print(res);
    return res;
  }
//
// static String _buildSearchTermQuery(String searchTerm) =>
//     searchTerm != null && searchTerm.isNotEmpty
//         ? '&page=${searchTerm.replaceAll(' ', '+').toLowerCase()}'
//         : '';
}

extension on Future<http.Response> {
  Future<R> mapFromResponse<R, T>(R Function(T) jsonParser) async {
    try {
      final response = await this;
      if (response.statusCode == 200) {
        print("GOOD RESPONSE" + jsonDecode(response.body).toString());
        return jsonParser(jsonDecode(response.body)['results']);
      } else {
        print("BAD RESPONSE");
        throw GenericHttpException();
      }
    } on SocketException {
      throw NoConnectionException();
    }
  }
}
