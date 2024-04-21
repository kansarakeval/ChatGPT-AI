import 'package:advance_exam_app/screen/history/model/history_model.dart';
import 'package:advance_exam_app/screen/home/controller/home_controller.dart';
import 'package:advance_exam_app/screen/home/model/home_model.dart';
import 'package:advance_exam_app/util/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());
  TextEditingController txtedit = TextEditingController();
  var chatHistory = <HomeModel>[].obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "ChatGPT AI",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.black87,
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed('history');
              },
              icon: const Icon(
                Icons.history,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: chatHistory.length,
                  itemBuilder: (context, index) {
                    final message = chatHistory[index];
                    return Column(
                      crossAxisAlignment:
                      message.candidateList![0].content!.partsList![0].text != null &&
                          message.candidateList![0].content!.partsList![0].text!.startsWith('You')
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          margin: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ([...Colors.primaries]..shuffle()).first.shade100,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.edit_outlined),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(Icons.copy),
                                  IconButton(
                                    onPressed: () {
                                      HistoryModel historyModel =
                                      HistoryModel(
                                        answer: message.candidateList![0].content!.partsList![0].text,
                                      );
                                      DbHelper.helper
                                          .insertAiData(historyModel);
                                    },
                                    icon: const Icon(Icons.bookmark_border),
                                  ),
                                ],
                              ),
                              Text(
                                message.candidateList![0].content!.partsList![0].text ?? '',
                                style: const TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: txtedit,
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      String edit = txtedit.text;
                      await controller.getHomeData(edit);
                      chatHistory.add(controller.homeModel!.value!);
                      txtedit.clear();
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}