import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_project/data/response/status.dart';
import 'package:rest_api_project/res/component/general_exception_widget.dart';
import 'package:rest_api_project/res/component/internet_exception_widget.dart';
import 'package:rest_api_project/view/news_api/new_view.dart';
import 'package:rest_api_project/view_model/controller/news_controller.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryView extends StatefulWidget {
  final String category;
  const CategoryView({super.key, required this.category});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final nc = Get.find<NewsController>();

  @override
  void initState() {
    super.initState();
    log("Category: ${widget.category}");
    nc.getNewsCategory(widget.category.toLowerCase());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("category api status=> ${nc.rxCategoryStatus.value.toString()}");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(CupertinoIcons.back),
        ),
      ),
      body: Obx(() {
        switch (nc.rxCategoryStatus.value) {
          case Status.LOADING:
            return const Center(child: CircularProgressIndicator());
          case Status.COMPLETED:
            return ListView.builder(
              itemCount: nc.categoryNews.value!.articles.length,
              itemBuilder: (context, index) {
                var article = nc.categoryNews.value!.articles[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => NewsDetailPage(
                        title: article.title,
                        description: article.description,
                        imageUrl: article.urlToImage,
                        publishAt: article.publishedAt,
                        source: article.source.name,
                        content: article.content));
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage.memoryNetwork(
                            placeholder:
                                kTransparentImage, // Add a local placeholder image
                            image: article.urlToImage,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.error,
                                  size: 50,
                                  color: Colors.red); // Show an error icon
                            },
                          ),
                        ),
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(10),
                        //   child: Image.network(
                        //     article.urlToImage,
                        //     height: 250,
                        //     width: 400,
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                        // SizedBox(height: 8),
                        Text(
                          article.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Divider(thickness: 2),
                      ],
                    ),
                  ),
                );
              },
            );
          case Status.ERROR:
            log("Error value: ${nc.categoryError.value}");
            if (nc.categoryError.value ==
                "Internet Error: No Internet Connection") {
              return InternetExceptionWidget(onpress: () {});
            } else {
              return GeneralException(onpress: () {});
            }
        }
      }),
    );
  }
}
