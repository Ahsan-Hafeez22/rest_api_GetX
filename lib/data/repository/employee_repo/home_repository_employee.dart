import 'package:rest_api_project/data/network/network_api_service.dart';
import 'package:rest_api_project/model/user_model.dart';
import 'package:rest_api_project/res/url/app_urls.dart';

class HomeRepositoryEmployee {
  final _apiService = NetworkApiService();
  Future<UserModel> getUserDetails() async {
    try {
      dynamic response = await _apiService.getApi(AppUrls.employeeAppUrl);
      if (response is Map<String, dynamic>) {
        // log(response.toString());
        return UserModel.fromJson(response);
      } else {
        throw Exception("Unexpected response format");
      }
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }
}
