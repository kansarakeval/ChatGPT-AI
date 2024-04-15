import 'package:advance_exam_app/util/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main(){
  runApp(

    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: app_routes,
    )
  );
}