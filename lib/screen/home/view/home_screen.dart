import 'package:advance_exam_app/screen/history/model/history_model.dart';
import 'package:advance_exam_app/screen/home/controller/home_controller.dart';
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
                  reverse: true,
                  itemCount: controller.chatHistory.length,
                  itemBuilder: (context, index) {
                    final message = controller.chatHistory.length - index - 1;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          margin: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ([...Colors.primaries]..shuffle())
                                .first
                                .shade100,
                          ),
                          child: Text(
                            controller.chatHistory[message],
                            style: const TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: txtedit,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: ValueListenableBuilder(
                          valueListenable: controller.isLoding,
                          builder: (context, value, child) {
                            if (value) {
                              return const CircularProgressIndicator();
                            }
                            return IconButton(
                              onPressed: () async {
                                String edit = txtedit.text;
                                controller.chatHistory.add(edit);
                                HistoryModel model =
                                    HistoryModel(answer: txtedit.text);
                                DbHelper.helper.insertAiData(model);
                                await controller.getHomeData(edit);
                                txtedit.clear();
                              },
                              icon: const Icon(Icons.send),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
