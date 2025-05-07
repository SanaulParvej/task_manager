import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/counter_controller.dart';
import 'home_screen.dart';

void main() {
  runApp(CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      initialBinding: ControllerBinder(),
    );
  }
}
class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>CounterController());
  }
}