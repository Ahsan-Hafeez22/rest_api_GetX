import 'package:rest_api_project/data/network/network_api_service.dart';
import 'package:rest_api_project/model/product_model.dart';
import 'package:rest_api_project/res/url/app_urls.dart';

class HomeRepositoryEcommerce {
  final _apiService = NetworkApiService();

  Future<List<ProductModel>> fetchProducts() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.fakeStoreApiUrl);

      // Ensure response is a List before mapping
      if (response is List) {
        return response.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception("Unexpected response format");
      }
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }
}
