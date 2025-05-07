import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 CounterController counterController = CounterController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: GetBuilder(
            init: counterController,
            builder: (_){
          return Text(
            '${counterController.count}',
            style: TextStyle(fontSize: 28),
          );
        }),
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

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key, required this.counterController});
//
//   final CounterController counterController;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: Center(
//         child: Text(''),
//       ),
//     );
//   }
// }


// class CounterController{
//   RxInt count = 0.obs;
//
//   void incrementCount(){
//     count++;
//   }
// }


class CounterController extends GetxController{
  int count = 0;

  void incrementCount(){
    count++;
    update();
  }
}