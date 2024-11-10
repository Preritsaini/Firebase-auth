import 'package:get/get.dart';

class TaskController extends GetxController {
  RxList<RxString> tasks = <RxString>[].obs;
  RxList<RxString> time = <RxString>[].obs;

  void addTask(String task) {
    tasks.add(task.obs);
  }

  void addTime(String taskTime) {
    time.add(taskTime.obs);
  }

  void removeTask(int index) {
    tasks.removeAt(index);
    time.removeAt(index);
  }
}
