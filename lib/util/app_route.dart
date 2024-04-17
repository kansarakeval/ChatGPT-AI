import 'package:advance_exam_app/screen/history/view/history_screen.dart';
import 'package:advance_exam_app/screen/home/view/home_screen.dart';
import 'package:advance_exam_app/screen/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';

Map<String,WidgetBuilder> app_routes={
  '/':(context) => const SplashScreen(),
  'home': (context) => const HomeScreen(),
  'history': (context) => const HistoryScreen(),
};