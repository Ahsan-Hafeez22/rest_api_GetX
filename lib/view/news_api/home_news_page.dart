import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_project/data/response/status.dart';
import 'package:rest_api_project/model/news_response.dart';
import 'package:rest_api_project/res/component/general_exception_widget.dart';
import 'package:rest_api_project/res/component/internet_exception_widget.dart';
import 'package:rest_api_project/utils/category_list.dart';
import 'package:rest_api_project/view/news_api/category_view.dart';
import 'package:rest_api_project/view/news_api/new_view.dart';
import 'package:rest_api_project/view_model/controller/news_controller.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeNewsPage extends StatefulWidget {
  const HomeNewsPage({super.key});

  @override
  State<HomeNewsPage> createState() => _HomeNewsPageState();
}

class _HomeNewsPageState extends State<HomeNewsPage> {
  NewsController nc = Get.put(NewsController());
  List<CategoryModel> categoryList = getCategories();

  @override
  void initState() {
    nc.getTopHeadlines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("top headline api status=>${nc.rxTopHeadlinesStatus.toString()}");

    return Scaffold(
        appBar: AppBar(
          title: Text("News Page"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                height: 50,
                width: double.infinity,
                // color: Colors.red,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => CategoryView(
                              category: categoryList[index].categoryName!),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            categoryList[index].categoryName!,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Obx(
                () {
                  switch (nc.rxTopHeadlinesStatus.value) {
                    case Status.LOADING:
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      );

                    case Status.COMPLETED:
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: nc.topHeadlines.value!.articles.length,
                        itemBuilder: (context, index) {
                          final artciles = nc.topHeadlines.value!.articles;
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                () => NewsDetailPage(
                                    title: artciles[index].title,
                                    description: artciles[index].description,
                                    imageUrl: artciles[index].urlToImage,
                                    publishAt: artciles[index].publishedAt,
                                    source: artciles[index].source.name,
                                    content: artciles[index].content),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: artciles[index]
                                                  .urlToImage
                                                  .isNotEmpty ==
                                              true
                                          ? artciles[index].urlToImage
                                          : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-UrwHq9Ki3Olb2gF6cM4lS3f10ci5O9ZASQ&s",
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.network(
                                          "https://via.placeholder.com/200", // Fallback image on error
                                          height: 200,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    artciles[index].title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Divider(thickness: 2),
                                ],
                              ),
                            ),
                          );
                        },
                      );

                    case Status.ERROR:
                      log("Error value: ${nc.topHeadlinesError.value}");
                      if (nc.topHeadlinesError.value ==
                          "Internet Error: No Internet Connection") {
                        return InternetExceptionWidget(
                          onpress: () {
                            // nc.getNews();
                          },
                        );
                      } else {
                        return GeneralException(
                          onpress: () {
                            // nc.getNews();
                          },
                        );
                      }
                  }
                },
              )
            ],
          ),
        ));
  }
}
