import 'dart:developer';

import 'package:rest_api_project/data/network/network_api_service.dart';
import 'package:rest_api_project/model/news_response.dart';
import 'package:rest_api_project/res/url/app_urls.dart';

class HomeRepositoryNews {
  final _apiService = NetworkApiService();

  //top headlines
  Future<NewsResponse> getNews() async {
    log('Url => ${AppUrls.newsUrlTopHeadlines}');
    try {
      dynamic response = await _apiService.getApi(AppUrls.newsUrlTopHeadlines);
      if (response is Map<String, dynamic>) {
        // log(response.toString());
        return NewsResponse.fromJson(response);
      } else {
        throw Exception("Unexpected response format");
      }
    } catch (e) {
      throw Exception("Error fetching News: $e");
    }
  }

  //sort by category
  Future<NewsResponse> getNewsCategory(String category) async {
    final url = AppUrls.newsUrlCategory(category);
    log('Url => $url');
    try {
      dynamic response = await _apiService.getApi(url);
      if (response is Map<String, dynamic>) {
        // log(response.toString());
        return NewsResponse.fromJson(response);
      } else {
        throw Exception("Unexpected response format");
      }
    } catch (e) {
      throw Exception("Error fetching News: $e");
    }
  }
}
/*
Future<List<NewsResponse>> getNews() async {
  try {
    dynamic response = await _apiService.getApi(AppUrls.newsUrl);
    
    if (response is Map<String, dynamic> && response.containsKey('articles')) {
      return (response['articles'] as List)
          .map((item) => NewsResponse.fromJson(item))
          .toList();
    } else {
      throw Exception("Unexpected response format");
    }
  } catch (e) {
    throw Exception("Error fetching News: $e");
  }
}
 */
