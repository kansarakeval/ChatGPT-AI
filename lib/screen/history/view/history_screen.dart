// import 'package:advance_exam_app/screen/history/controller/history_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class HistoryScreen extends StatefulWidget {
//   const HistoryScreen({super.key});
//
//   @override
//   State<HistoryScreen> createState() => _HistoryScreenState();
// }
//
// class _HistoryScreenState extends State<HistoryScreen> {
//   HistoryController historyController = Get.put(HistoryController());
//
//   @override
//   void initState() {
//     super.initState();
//     historyController.historyGetData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             "History",
//             style: TextStyle(color: Colors.white),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.black87,
//           iconTheme: const IconThemeData(color: Colors.white),
//         ),
//         body: Obx(
//               () =>
//               ListView.builder(
//                 itemCount: historyController.historyList.length,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onLongPress: () {
//
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.all(10),
//                       padding: const EdgeInsets.all(10),
//                       height: 200,
//                       width:double.infinity,
//                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: ([...Colors.primaries]..shuffle()).first.shade200),
//                       child: Text(
//                         "${historyController.historyList[index].answer}",overflow: TextOverflow.ellipsis,maxLines: 15,style: TextStyle(fontSize: 15),),
//                     ),
//                   );
//                 },
//               ),
//         ),
//       ),
//     );
//   }
// }

import 'package:advance_exam_app/screen/history/controller/history_controller.dart';
import 'package:advance_exam_app/util/db_helper.dart';
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
          title: const Text(
            "History",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.black87,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Obx(
              () => ListView.builder(
            itemCount: historyController.historyList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Delete'),
                        content: Text('Are you sure you want to delete this history?'),
                        actions: <Widget>[
                          ElevatedButton(onPressed: (){
                            DbHelper.helper.deleteAiData(id: "${historyController.historyList[index].id}");
                            historyController.historyGetData();
                            Get.back();
                          }, child: Text("delete")),
                          ElevatedButton(onPressed: (){
                            Get.back();
                          }, child: Text("close")),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ([...Colors.primaries]..shuffle()).first.shade100),
                  child: Text(
                    "${historyController.historyList[index].answer}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 15,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}