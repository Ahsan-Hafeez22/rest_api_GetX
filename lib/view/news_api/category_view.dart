import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_project/data/response/status.dart';
import 'package:rest_api_project/res/asset/image.dart';
import 'package:rest_api_project/res/component/general_exception_widget.dart';
import 'package:rest_api_project/res/component/internet_exception_widget.dart';
import 'package:rest_api_project/res/route/route_names.dart';
import 'package:rest_api_project/view_model/controller/news_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
            return ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(16),
                child: Skeletonizer(
                  enabled: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.grey[300], // Grey box as a placeholder
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 20,
                        width: 150,
                        color: Colors.grey[300], // Title placeholder
                      ),
                      SizedBox(height: 4),
                      Container(
                        height: 14,
                        width: double.infinity,
                        color: Colors.grey[300], // Description placeholder
                      ),
                    ],
                  ),
                ),
              ),
            );

          case Status.COMPLETED:
            return ListView.builder(
              itemCount: nc.categoryNews.value!.articles.length,
              itemBuilder: (context, index) {
                var article = nc.categoryNews.value!.articles[index];
                return Skeletonizer(
                  enabled: nc.rxCategoryStatus.value == Status.LOADING,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(RoutesName.newsDetailPage, arguments: {
                        'title': article.title,
                        'description': article.description,
                        'imageUrl': article.urlToImage,
                        'publishAt': article.publishedAt,
                        'source': article.source.name,
                        'content': article.content,
                      });
                      // Get.to(() => NewsDetailPage(
                      //     // title: article.title,
                      //     // description: article.description,
                      //     // imageUrl: article.urlToImage,
                      //     // publishAt: article.publishedAt,
                      //     // source: article.source.name,
                      //     // content: article.content
                      //     )
                      //     );
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FadeInImage(
                              placeholder: AssetImage(ImageAssets
                                  .placeholderNewsImage), // Use a local placeholder image
                              image: NetworkImage(article.urlToImage),
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.image_not_supported,
                                      size: 50, color: Colors.grey),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            article.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Divider(thickness: 2),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );

          case Status.ERROR:
            log("Error value: ${nc.categoryError.value}");
            if (nc.categoryError.value ==
                "Internet Error: No Internet Connection") {
              return Center(
                child: InternetExceptionWidget(onpress: () {
                  nc.getNewsCategory(widget.category);
                }),
              );
            } else {
              return Center(child: GeneralException(onpress: () {
                nc.getNewsCategory(widget.category);
              }));
            }
        }
      }),
    );
  }
}
