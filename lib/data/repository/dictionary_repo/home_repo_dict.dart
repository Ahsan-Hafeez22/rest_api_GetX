import 'dart:developer';

import 'package:rest_api_project/data/network/network_api_service.dart';
import 'package:rest_api_project/model/dictionary_model.dart';
import 'package:rest_api_project/res/url/app_urls.dart';

class HomeRepoDict {
  final _apiService = NetworkApiService();
  Future<List<DictionaryModel>> getWordDict(String word) async {
    String url = AppUrls.dictionaryUrl(word);
    log("Dictionary URL: $url");
    try {
      final response = await _apiService.getApi(url);
      if (response is List) {
        log(response.toString());
        return response.map((item) => DictionaryModel.fromJson(item)).toList();
      } else {
        throw Exception("Unexpected response format");
      }
    } catch (e) {
      throw Exception("Error fetching word meaning: $e");
    }
  }
}
