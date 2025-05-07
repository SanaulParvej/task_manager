import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/counter_controller.dart';
import 'main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: GetBuilder<CounterController>(
          builder: (controller) {
            return Text(controller.count.toString());
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.find<CounterController>().incrementCount();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
