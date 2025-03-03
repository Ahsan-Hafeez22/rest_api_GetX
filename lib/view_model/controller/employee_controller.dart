import 'dart:developer';

import 'package:get/get.dart';
import 'package:rest_api_project/data/repository/employee_repo/home_repository_employee.dart';
import 'package:rest_api_project/data/response/status.dart';
import 'package:rest_api_project/model/user_model.dart';

class EmployeeController extends GetxController {
  final homeRepositoryEmployee = HomeRepositoryEmployee();
  RxString rxError = "".obs;
  final rxResponseStatus = Status.LOADING.obs;
  final userResponse = Rx<UserModel?>(null);

  void setRxError(String error) => rxError.value = error;
  void setUserResponse(UserModel users) => userResponse.value = users;
  void setRxResponseStatus(Status status) => rxResponseStatus.value = status;

  void getEmployees() {
    homeRepositoryEmployee.getUserDetails().then(
      (value) {
        setRxResponseStatus(Status.COMPLETED);
        setUserResponse(value);
      },
    ).onError(
      (error, stackTrace) {
        log('error: $error\n$stackTrace');
        setRxResponseStatus(Status.ERROR);
        setRxError(error.toString());
      },
    );
  }
}
