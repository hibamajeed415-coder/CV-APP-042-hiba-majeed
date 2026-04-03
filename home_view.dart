import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/task_controller.dart';
import 'task_list_view.dart';
import 'add_task_view.dart';
import '../models/task.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0; // 0 = Today, 1 = Completed, 2 = Repeated
  bool isDark = false; // Theme toggle

  @override
  Widget build(BuildContext context) {
    final taskController = Provider.of<TaskController>(context);

    // Get tasks based on current tab
    List<Task> getCurrentTasks() {
      if (_currentIndex == 0) {
        return taskController.todayTasks;
      } else if (_currentIndex == 1) {
        return taskController.completedTasks;
      } else {
        return taskController.repeatedTasks;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0
              ? 'Today Tasks'
              : _currentIndex == 1
              ? 'Completed Tasks'
              : 'Repeated Tasks',
        ),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              setState(() => isDark = !isDark);
              if (isDark) {
                taskController.setTheme(ThemeMode.dark);
              } else {
                taskController.setTheme(ThemeMode.light);
              }
            },
          ),
        ],
      ),
      body: TaskListView(tasks: getCurrentTasks()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.today), label: 'Today'),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle), label: 'Completed'),
          BottomNavigationBarItem(icon: Icon(Icons.repeat), label: 'Repeated'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskView()),
          );
          setState(() {}); // Refresh tasks after returning
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}