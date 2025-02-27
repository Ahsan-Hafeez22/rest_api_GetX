import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_project/data/response/status.dart';
import 'package:rest_api_project/model/product_model.dart';
import 'package:rest_api_project/res/component/general_exception_widget.dart';
import 'package:rest_api_project/res/component/internet_exception_widget.dart';
import 'package:rest_api_project/view_model/controller/product_controller.dart';

class HomeEcommercePage extends StatefulWidget {
  const HomeEcommercePage({super.key});

  @override
  State<HomeEcommercePage> createState() => _HomeEcommercePageState();
}

class _HomeEcommercePageState extends State<HomeEcommercePage> {
  ProductController pc = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    log(pc.rxRequestStatus.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Screen',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
      ),
      body: Obx(() {
        switch (pc.rxRequestStatus.value) {
          case Status.LOADING:
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );

          case Status.COMPLETED:
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 12,
                    ),
                    physics: BouncingScrollPhysics(),
                    itemCount: pc.productItems.length,
                    itemBuilder: (context, index) {
                      return ProductItemDisplay(
                        product: pc.productItems[index],
                      );
                    },
                  ),
                ),
              ],
            );

          case Status.ERROR:
            log("Error value: ${pc.error.value}");
            if (pc.error.value == "Internet Error: No Internet Connection") {
              return InternetExceptionWidget(
                onpress: () {
                  pc.refrestFetchProductList();
                },
              );
            } else {
              return GeneralException(
                onpress: () {
                  pc.refrestFetchProductList(); // ✅ Fixed function call
                },
              );
            }
        }
      }),
    );
  }
}

class ProductItemDisplay extends StatelessWidget {
  final ProductModel product;

  const ProductItemDisplay({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(product.image),
                  )),
            ),
            SizedBox(height: 5),
            Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                  child: Row(
                    children: [
                      Text(
                        product.rating.rate.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Text(product.category.name, style: TextStyle(fontSize: 10)),
              ],
            ),
            SizedBox(height: 10),
            Text('${product.price} \$',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
