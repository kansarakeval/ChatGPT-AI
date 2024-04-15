import 'package:advance_exam_app/screen/home/controller/home_controller.dart';
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
  HomeController controller= Get.put(HomeController());


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
      ),
          body:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: txtedit,
                    decoration:  InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(onPressed: () async {
                        String edit = txtedit.text;
                        await controller.gethomeData(edit);
                      }, icon: Icon(Icons.search)),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: MediaQuery.sizeOf(context).height*0.8,
                    width: double.infinity,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey.shade200,),
                    child: Text(),
                  )
                ],
              ),
            ),
          ),
    ));
  }
}
