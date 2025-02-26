import 'package:rest_api_project/data/response/status.dart';

class ApiResponses<T> {
  Status? status;
  T? data;
  String? message;
  ApiResponses(this.status, this.data, this.message);
  ApiResponses.loading() : status = Status.LOADING;
  ApiResponses.completed(this.data) : status = Status.COMPLETED;
  ApiResponses.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status: $status\nMessage: $message\nData: $data";
  }
}

//Example usage:
/*
Future<ApiResponses<List<UserModel>>> fetchUsers() async {
  Dio dio = Dio();
  try {
    Response response = await dio.get('https://jsonplaceholder.typicode.com/users');
    
    if (response.statusCode == 200) {
      List<UserModel> users = (response.data as List)
          .map((item) => UserModel.fromJson(item))
          .toList();
      
      return ApiResponses.completed(users);  // ✅ Success
    } else {
      return ApiResponses.error("Failed to load users"); // ❌ API error
    }
  } catch (e) {
    return ApiResponses.error("Exception: $e"); // ❌ Network error
  }
}
*/
