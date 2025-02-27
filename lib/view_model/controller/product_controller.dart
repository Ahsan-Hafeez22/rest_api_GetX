import 'dart:developer';

import 'package:get/get.dart';
import 'package:rest_api_project/data/repository/ecommerce_repo/home_repository_ecommerce.dart';
import 'package:rest_api_project/data/response/status.dart';
import 'package:rest_api_project/model/product_model.dart';

class ProductController extends GetxController {
  final HomeRepositoryEcommerce _homeRepository = HomeRepositoryEcommerce();

  final productItems = <ProductModel>[].obs;
  final rxRequestStatus = Status.LOADING.obs;
  RxString error = "".obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setProductList(List<ProductModel> products) =>
      productItems.assignAll(products);
  void setError(String value) => error.value = value;

  @override
  void onInit() {
    fetchProductList();
    super.onInit();
  }

  fetchProductList() async {
    _homeRepository.fetchProducts().then(
      (value) {
        setRxRequestStatus(Status.COMPLETED);
        setProductList(value);
      },
    ).onError(
      (error, stackTrace) {
        log(error.toString());
        log(stackTrace.toString());
        setError(error.toString());

        setRxRequestStatus(Status.ERROR);
      },
    );
  }

  refrestFetchProductList() async {
    setRxRequestStatus(Status.LOADING);
    _homeRepository.fetchProducts().then(
      (value) {
        setRxRequestStatus(Status.COMPLETED);
        setProductList(value);
      },
    ).onError(
      (error, stackTrace) {
        log(error.toString());
        log(stackTrace.toString());
        setError(error.toString());

        setRxRequestStatus(Status.ERROR);
      },
    );
  }
}
