import 'dart:developer';
import 'package:get/get.dart';
import 'package:rest_api_project/data/repository/news_repo/home_repository_news.dart';
import 'package:rest_api_project/data/response/status.dart';
import 'package:rest_api_project/model/news_response.dart';

class NewsController extends GetxController {
  HomeRepositoryNews homeRepositoryNews = HomeRepositoryNews();

  final rxTopHeadlinesStatus = Status.LOADING.obs;
  final rxCategoryStatus = Status.LOADING.obs;

  final topHeadlines = Rx<NewsResponse?>(null);
  final categoryNews = Rx<NewsResponse?>(null);

  RxString topHeadlinesError = "".obs;
  RxString categoryError = "".obs;

  void setTopHeadlinesError(String message) =>
      topHeadlinesError.value = message;
  void setRxTopHeadlinesStatus(Status status) =>
      rxTopHeadlinesStatus.value = status;
  void setTopHeadlines(NewsResponse newsResponse) =>
      topHeadlines.value = newsResponse;

  void setcategoryError(String message) => categoryError.value = message;
  void setRxCategoryStatus(Status status) => rxCategoryStatus.value = status;
  void setCategoryNews(NewsResponse newsResponse) =>
      categoryNews.value = newsResponse;

  void getTopHeadlines() {
    rxTopHeadlinesStatus.value = Status.LOADING;
    homeRepositoryNews.getNews().then(
      (response) {
        setRxTopHeadlinesStatus(Status.COMPLETED);
        setTopHeadlines(response);
      },
    ).onError((error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      setRxTopHeadlinesStatus(Status.ERROR);
      setTopHeadlinesError(error.toString());
    });
  }

  void getNewsCategory(String category) {
    setRxCategoryStatus(Status.LOADING);
    homeRepositoryNews.getNewsCategory(category).then(
      (response) {
        rxCategoryStatus.value = Status.COMPLETED;
        setCategoryNews(response);
      },
    ).onError((error, stackTrace) {
      setRxCategoryStatus(Status.ERROR);
      setcategoryError(error.toString());
    });
  }
}
