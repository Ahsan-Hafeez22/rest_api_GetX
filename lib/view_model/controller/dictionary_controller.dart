import 'dart:developer';

import 'package:get/get.dart';
import 'package:rest_api_project/data/repository/dictionary_repo/home_repo_dict.dart';
import 'package:rest_api_project/data/response/status.dart';
import 'package:rest_api_project/model/dictionary_model.dart';

class DictionaryController extends GetxController {
  HomeRepoDict hm = HomeRepoDict();
  RxString error = "".obs;
  RxBool hasSearch = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  final dictionaryResponseList = <DictionaryModel>[].obs;

  void setRxRequestStatus(Status status) => rxRequestStatus.value = status;
  void setError(String errorMsg) => error.value = errorMsg;
  void setDictionaryResponseList(List<DictionaryModel> dictList) =>
      dictionaryResponseList.value = dictList;

  void getDictionary(String word) {
    setRxRequestStatus(Status.LOADING);
    hm.getWordDict(word).then(
      (value) {
        setRxRequestStatus(Status.COMPLETED);
        setDictionaryResponseList(value);
      },
    ).onError(
      (error, stackTrace) {
        log('Error in Dictionary Controller while fetching result: $error \n $stackTrace');
        setError(error.toString());
        setRxRequestStatus(Status.ERROR);
      },
    );
  }
}
