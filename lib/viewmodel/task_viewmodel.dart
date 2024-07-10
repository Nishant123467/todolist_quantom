import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist_quant/models/services/notification_service.dart';
import '../models/task.dart';


import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskViewModel extends GetxController {
  var tasks = <Task>[].obs;
  var filteredTasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void addTask(Task task) {
    tasks.add(task);
    saveTasks();
  }

  void editTask(Task task) {
    var index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index] = task;
      saveTasks();
    }
  }

  void deleteTask(String id) {
    tasks.removeWhere((task) => task.id == id);
    saveTasks();
  }

  void loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      tasks.value = Task.decode(tasksString);
      filteredTasks.value = tasks;
    }
  }

  void saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('tasks', Task.encode(tasks));
  }

  void searchTasks(String query) {
    if (query.isEmpty) {
      filteredTasks.value = tasks;
    } else {
      filteredTasks.value = tasks
          .where((task) =>
              task.title.toLowerCase().contains(query.toLowerCase()) ||
              task.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
