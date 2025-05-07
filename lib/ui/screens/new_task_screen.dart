import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task_status_count_list_model.dart';
import 'package:task_manager/data/models/task_status_count_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/ui/controller/new_task_controller.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import '../../data/utils/urls.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getStatusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];

  @override
  void initState() {
    super.initState();
    _getAllTaskStatusCount();
    _getAllNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
                visible: _getStatusCountInProgress == false,
                replacement: Padding(
                  padding: const EdgeInsets.all(16),
                  child: CenteredCircularProgressIndicator(),
                ),
                child: buildSummerySection()),
            GetBuilder<NewTaskController>(builder: (controller) {
              return Visibility(
                visible: controller.getNewTaskInProgress == false,
                replacement: SizedBox(
                    height: 300, child: CenteredCircularProgressIndicator()),
                child: ListView.separated(
                  itemCount: controller.newTaskList.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskStatus: TaskStatus.sNew,
                      taskModel: controller.newTaskList[index],
                      refreshList: _getAllNewTaskList,
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                ),
              );
            })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTask,
        child: Icon(Icons.add),
      ),
    );
  }

  void _onTapAddNewTask() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewTaskScreen(),
      ),
    );
  }

  Widget buildSummerySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _taskStatusCountList.length,
            itemBuilder: (context, index) {
              return SummaryCard(
                  tittle: _taskStatusCountList[index].status,
                  count: _taskStatusCountList[index].count);
            }),
      ),
    );
  }

  Future<void> _getAllTaskStatusCount() async {
    _getStatusCountInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkClient.getRequest(url: Urls.taskStatusCountUrl);
    if (response.isSuccess) {
      TaskStatusCountListModel taskStatusCountListModel =
          TaskStatusCountListModel.fromJson(response.data ?? {});
      _taskStatusCountList = taskStatusCountListModel.statusCountList;
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getStatusCountInProgress = false;
    setState(() {});
  }

  Future<void> _getAllNewTaskList() async {
    final bool isSuccess = await Get.find<NewTaskController>().getNewTaskList();
    if (!isSuccess) {
      showSnackBarMessage(
          context, Get.find<NewTaskController>().errorMessage!, true);
    }
  }
}
