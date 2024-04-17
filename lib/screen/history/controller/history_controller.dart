import 'package:advance_exam_app/screen/history/model/history_model.dart';
import 'package:advance_exam_app/util/db_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HistoryController extends GetxController{
  RxList<HistoryModel> historyList = <HistoryModel>[].obs;

  Future<void>historyGetData()async{
    List<HistoryModel> history = await DbHelper.helper.readAiData();
    historyList.value = history;
  }


}