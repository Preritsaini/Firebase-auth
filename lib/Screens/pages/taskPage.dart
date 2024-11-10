import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:authenticate/controllers/taskController.dart';

class TaskPage extends StatelessWidget {
  TaskPage({super.key});

  final TaskController taskController = Get.put(TaskController());

  void openTaskDialog() {
    String taskInput = "";
    String timeOfTask = "";

    Get.dialog(
      AlertDialog(
        title: Text("Add New Task"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "Task",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                taskInput = value;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Time of Task",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                timeOfTask = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (taskInput.isNotEmpty && timeOfTask.isNotEmpty) {
                taskController.addTask(taskInput);
                taskController.addTime(timeOfTask);
                Get.back();
              }
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task List"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text('Add Task'),
              trailing: Icon(Icons.add),
              onTap: openTaskDialog,
            ),
            ListTile(
              title: Text('Task'),
              trailing: Text('Time', style: TextStyle(fontSize: 18)),
            ),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: taskController.tasks.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(taskController.tasks[index].value),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        taskController.removeTask(index);
                        Get.snackbar("Task Deleted", "Task '${taskController.tasks[index].value}' was removed.");
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      child: ListTile(
                        title: Text(taskController.tasks[index].value),
                        trailing: Text(taskController.time[index].value),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
