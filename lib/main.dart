import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app/bloc_state_observer.dart';
import 'package:todos_app/routes/app_router.dart';
import 'package:todos_app/routes/app_pages.dart';
import 'package:todos_app/tasks/data/local/data_sources/tasks_data_provider.dart';
import 'package:todos_app/tasks/data/repository/task_repository.dart';
import 'package:todos_app/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:todos_app/utils/color_palette.dart';

Future<void> main({SharedPreferences? preferences}) async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = BlocStateOberver();
  preferences ??= await SharedPreferences.getInstance();
  runApp(MyApp(preferences: preferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences preferences;

  const MyApp({super.key, required this.preferences});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TaskRepository(taskDataProvider: TaskDataProvider(preferences)),
      child: BlocProvider(
        create: (context) => TasksBloc(context.read<TaskRepository>()),
        child: MaterialApp(
          title: 'Todos App',
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.initial,
          onGenerateRoute: onGenerateRoute,
          theme: ThemeData(
            fontFamily: 'Sora',
            visualDensity: VisualDensity.adaptivePlatformDensity,
            canvasColor: Colors.transparent,
            colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}
