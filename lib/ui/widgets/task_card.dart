import 'package:flutter/material.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

import '../../data/models/task_model.dart';
import '../../data/utils/urls.dart';

enum TaskStatus {
  sNew,
  progress,
  completed,
  cancelled,
}

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskStatus,
    required this.taskModel, required this.refreshList,
  });

  final TaskStatus taskStatus;
  final TaskModel taskModel;
  final VoidCallback refreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(widget.taskModel.description),
            // TODO: DATE
            Text('Date: ${widget.taskModel.createDate}'),
            Row(
              children: [
                Chip(
                  label: Text(
                    widget.taskModel.status,
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  backgroundColor: _getStatusChipColor(),
                  side: BorderSide.none,
                ),
                Spacer(),
                Visibility(
                  visible: _inProgress == false,
                  replacement: CenteredCircularProgressIndicator(),
                  child: Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                      IconButton(
                          onPressed: _showUpdateStatusDialog,
                          icon: Icon(Icons.edit)),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Color _getStatusChipColor() {
    late Color color;
    switch (widget.taskStatus) {
      case TaskStatus.sNew:
        color = Colors.blue;
      case TaskStatus.progress:
        color = Colors.purple;
      case TaskStatus.completed:
        color = Colors.green;
      case TaskStatus.cancelled:
        color = Colors.red;
    }
    return color;
  }

  void _showUpdateStatusDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Update status"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    _popDialog();
                    if (isSelected('New')) return;
                    _changeTaskStatus('New');
                  },
                  title: Text('New'),
                  trailing: isSelected('New') ? Icon(Icons.done) : null,
                ),
                ListTile(
                  onTap: () {
                    _popDialog();
                    if (isSelected('Progress')) return;
                    _changeTaskStatus('Progress');
                  },
                  title: Text('Progress'),
                  trailing: isSelected('Progress') ? Icon(Icons.done) : null,
                ),
                ListTile(
                  onTap: () {
                    _popDialog();
                    if (isSelected('Completed')) return;
                    _changeTaskStatus('Completed');
                  },
                  title: Text('Completed'),
                  trailing: isSelected('Completed') ? Icon(Icons.done) : null,
                ),
                ListTile(
                  onTap: () {
                    _popDialog();
                    if (isSelected('Cancelled')) return;
                    _changeTaskStatus('Cancelled');
                  },
                  title: Text('Cancelled'),
                  trailing: isSelected('Cancelled') ? Icon(Icons.done) : null,
                ),
              ],
            ),
          );
        });
  }

  void _popDialog() {
    Navigator.pop(context);
  }

  bool isSelected(String status) => widget.taskModel.status == status;

  Future<void> _changeTaskStatus(String status) async {
    _inProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(
        url: Urls.updateTaskStatusUrl(widget.taskModel.id, status));
    _inProgress = false;
    if (response.isSuccess) {
      widget.refreshList();
    } else {
      setState(() {});
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
