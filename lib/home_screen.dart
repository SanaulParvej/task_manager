import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/counter_controller.dart';
import 'package:task_manager/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  CounterController counterController = Get.find<CounterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            GetBuilder(
                init: counterController,
                builder: (_) {
                  return Text(
                    '${counterController.count}',
                    style: TextStyle(fontSize: 28),
                  );
                }),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProfileScreen();
                }));
              },
              child: Text('Go to profile'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterController.incrementCount();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
