import 'package:advance_exam_app/screen/history/model/history_model.dart';
import 'package:advance_exam_app/screen/home/controller/home_controller.dart';
import 'package:advance_exam_app/util/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController txtedit = TextEditingController();
  HomeController controller = Get.put(HomeController());

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
                ),)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: txtedit,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        String edit = txtedit.text;
                        await controller.getHomeData(edit);
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => controller.homeModel!.value == null
                      ? const Text(
                          "Please wait....",
                          style: TextStyle(fontSize: 25),
                        )
                      : Container(
                          padding: const EdgeInsets.all(6),
                          height: MediaQuery.sizeOf(context).height * 0.8,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ([...Colors.primaries]..shuffle()).first.shade100,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.edit_outlined),
                                  const SizedBox(width: 10,),
                                  const Icon(Icons.copy),
                                  IconButton(
                                      onPressed: () {
                                        HistoryModel historyModel = HistoryModel(
                                          answer: controller
                                              .homeModel!
                                              .value!
                                              .candidateList![0]
                                              .content!
                                              .partsList![0]
                                              .text,
                                        );
                                        DbHelper.helper.insertAiData(historyModel);
                                      },
                                      icon: const Icon(Icons.bookmark_border)),
                                ],
                              ),
                              SizedBox(
                                width: 500,
                                height: 600,
                                child: Text(
                                  "${controller.homeModel!.value!.candidateList![0].content!.partsList![0].text}",
                                  style: const TextStyle(fontSize: 17),
                                  overflow: TextOverflow.ellipsis,maxLines: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
