import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_project/data/response/status.dart';
import 'package:rest_api_project/model/news_response.dart';
import 'package:rest_api_project/res/asset/image.dart';
import 'package:rest_api_project/res/component/general_exception_widget.dart';
import 'package:rest_api_project/res/component/internet_exception_widget.dart';
import 'package:rest_api_project/res/route/route_names.dart';
import 'package:rest_api_project/utils/category_list.dart';
import 'package:rest_api_project/view/news_api/category_view.dart';
import 'package:rest_api_project/view_model/controller/news_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeNewsPage extends StatefulWidget {
  const HomeNewsPage({super.key});

  @override
  State<HomeNewsPage> createState() => _HomeNewsPageState();
}

class _HomeNewsPageState extends State<HomeNewsPage> {
  final NewsController nc = Get.put(NewsController());
  final List<CategoryModel> categoryList = getCategories();

  @override
  void initState() {
    super.initState();
    nc.getTopHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    log("top headline api status => ${nc.rxTopHeadlinesStatus.value}");

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Screen',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            // Category Selector
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Get.to(() => CategoryView(
                        category: categoryList[index].categoryName!)),
                    child: Container(
                      margin: const EdgeInsets.only(right: 15),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          categoryList[index].categoryName!,
                          style: const TextStyle(
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

            // News Content
            Obx(() {
              switch (nc.rxTopHeadlinesStatus.value) {
                case Status.LOADING:
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: Skeletonizer(
                        enabled: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 20,
                              width: 150,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 14,
                              width: double.infinity,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

                case Status.COMPLETED:
                  if (nc.topHeadlines.value?.articles.isEmpty ?? true) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("No news available"),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: nc.topHeadlines.value!.articles.length,
                    itemBuilder: (context, index) {
                      final articles = nc.topHeadlines.value!.articles;
                      final imageUrl =
                          articles[index].urlToImage.isNotEmpty == true
                              ? articles[index].urlToImage
                              : "";

                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(RoutesName.newsDetailPage, arguments: {
                            'title': articles[index].title,
                            'description': articles[index].description,
                            'imageUrl': articles[index].urlToImage,
                            'publishAt': articles[index].publishedAt,
                            'source': articles[index].source.name,
                            'content': articles[index].content,
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage(
                                  placeholder: AssetImage(ImageAssets
                                      .placeholderNewsImage), // Use a local placeholder image
                                  image: NetworkImage(imageUrl),
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
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
                              const SizedBox(height: 8),
                              Text(
                                articles[index].title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const Divider(thickness: 2),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                case Status.ERROR:
                  log("Error value: ${nc.topHeadlinesError.value}");
                  return Center(
                    child: nc.topHeadlinesError.value ==
                            "Internet Error: No Internet Connection"
                        ? InternetExceptionWidget(
                            onpress: () => nc.getTopHeadlines(),
                          )
                        : GeneralException(
                            onpress: () => nc.getTopHeadlines(),
                          ),
                  );
              }
            }),
          ],
        ),
      ),
    );
  }
}
