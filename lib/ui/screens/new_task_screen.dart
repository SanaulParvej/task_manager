import 'package:flutter/material.dart';

import '../widgets/summary_card.dart';
import '../widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSummerySection(),
            ListView.separated(
              itemCount: 6,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return TaskCard();
              },
              separatorBuilder: (context, index) => SizedBox(height: 8),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildSummerySection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SummaryCard(
              tittle: 'New',
              count: 12,
            ),
            SummaryCard(
              tittle: 'Progress',
              count: 20,
            ),
            SummaryCard(
              tittle: 'Completed',
              count: 7,
            ),
            SummaryCard(
              tittle: 'Cancelled',
              count: 9,
            ),
          ],
        ),
      ),
    );
  }
}
