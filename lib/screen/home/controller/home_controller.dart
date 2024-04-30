import 'package:advance_exam_app/screen/home/model/home_model.dart';
import 'package:advance_exam_app/util/api_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';


class HomeController extends GetxController {
  Rxn<HomeModel>? homeModel = Rxn();
  RxList<String> chatHistory = <String>[].obs;
  ValueNotifier<bool> isLoding = ValueNotifier(false);

  Future<void> getHomeData(String edit) async {
    isLoding.value = true;
    APIHelper apiHelper = APIHelper();
    HomeModel? w1 = await apiHelper.homeAPICall(edit);
    homeModel?.value = w1;
    if (homeModel!.value != null) {
      chatHistory.add(homeModel!.value!.candidateList![0].content!.partsList![0].text!);
    }
    isLoding.value = false;
  }
}