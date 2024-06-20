import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app/tasks/data/local/model/task_model.dart';
import 'package:todos_app/utils/exception_handler.dart';

const String taskKey = 'tasks';

class TaskDataProvider {
  List<TaskModel> tasks = [];
  SharedPreferences? prefs;

  TaskDataProvider(this.prefs);

  Future<List<TaskModel>> getTasks() async {
    try {
      final List<String>? savedTasks = prefs!.getStringList(taskKey);
      if (savedTasks != null) {
        tasks = savedTasks.map((taskJson) => TaskModel.fromJson(json.decode(taskJson))).toList();
        tasks.sort((a, b) {
          if (a.completed == b.completed) {
            return 0;
          } else if (a.completed) {
            return 1;
          } else {
            return -1;
          }
        });
      }
      return tasks;
    } catch (e) {
      throw Exception(handleException(e));
    }
  }

  Future<List<TaskModel>> sortTasks(int sortOption) async {
    switch (sortOption) {
      case 0:
        tasks.sort((a, b) {
          /// Sort by date
          if (a.startDateTime!.isAfter(b.startDateTime!)) {
            return 1;
          } else if (a.startDateTime!.isBefore(b.startDateTime!)) {
            return -1;
          }
          return 0;
        });
        break;
      case 1:

        /// Sort by completed tasks
        tasks.sort((a, b) {
          if (!a.completed && b.completed) {
            return 1;
          } else if (a.completed && !b.completed) {
            return -1;
          }
          return 0;
        });
        break;
    }
    return tasks;
  }

  Future<void> createTask(TaskModel taskModel) async {
    try {
      tasks.add(taskModel);
      final List<String> taskJsonList = tasks.map((task) => json.encode(task.toJson())).toList();
      await prefs!.setStringList(taskKey, taskJsonList);
    } catch (exception) {
      throw Exception(handleException(exception));
    }
  }

  Future<List<TaskModel>> updateTask(TaskModel taskModel) async {
    try {
      tasks[tasks.indexWhere((element) => element.id == taskModel.id)] = taskModel;
      tasks.sort((a, b) {
        if (a.completed == b.completed) {
          return 0;
        } else if (a.completed) {
          return 1;
        } else {
          return -1;
        }
      });
      final List<String> taskJsonList = tasks.map((task) => json.encode(task.toJson())).toList();
      prefs!.setStringList(taskKey, taskJsonList);
      return tasks;
    } catch (exception) {
      throw Exception(handleException(exception));
    }
  }

  Future<List<TaskModel>> deleteTask(TaskModel taskModel) async {
    try {
      tasks.remove(taskModel);
      final List<String> taskJsonList = tasks.map((task) => json.encode(task.toJson())).toList();
      prefs!.setStringList(taskKey, taskJsonList);
      return tasks;
    } catch (exception) {
      throw Exception(handleException(exception));
    }
  }
}
