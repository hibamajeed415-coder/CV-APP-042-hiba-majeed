import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/task_controller.dart';
import 'views/home_view.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskController(),
      child: Consumer<TaskController>(
        builder: (context, controller, _) => MaterialApp(
          title: 'Task Manager',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: controller.themeMode,
          home: const HomeView(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
