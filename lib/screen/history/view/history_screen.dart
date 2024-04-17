import 'package:advance_exam_app/screen/history/controller/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  HistoryController historyController = Get.put(HistoryController());

  @override
  void initState() {
    super.initState();
    historyController.historyGetData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "History",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.black87,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: Obx(
            () =>ListView.builder(
              itemCount: historyController.historyList.length,
              itemBuilder: (context, index) {
                return Text("${historyController!.historyList[index].answer}");

              },
            ),
          )),
    );
  }
}
