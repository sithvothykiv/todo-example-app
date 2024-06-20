import 'package:flutter/material.dart';
import 'package:todos_app/routes/app_pages.dart';
import 'package:todos_app/splash_screen.dart';
import 'package:todos_app/tasks/data/local/model/task_model.dart';
import 'package:todos_app/tasks/presentation/pages/create_task_screen.dart';
import 'package:todos_app/tasks/presentation/pages/tasks_screen.dart';
import 'package:todos_app/tasks/presentation/pages/update_task_screen.dart';

import '../page_not_found.dart';

Route onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AppPages.initial:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
    case AppPages.home:
      return MaterialPageRoute(
        builder: (context) => const TasksScreen(),
      );
    case AppPages.createNewTask:
      return MaterialPageRoute(
        builder: (context) => const CreateTaskScreen(),
      );
    case AppPages.updateTask:
      final args = routeSettings.arguments as TaskModel;
      return MaterialPageRoute(
        builder: (context) => UpdateTaskScreen(taskModel: args),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const PageNotFound(),
      );
  }
}
