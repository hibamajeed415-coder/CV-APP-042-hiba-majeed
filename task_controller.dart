import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/notification_service.dart';

class TaskController extends ChangeNotifier {
  List<Task> _tasks = [];
  ThemeMode themeMode = ThemeMode.light;

  List<Task> get todayTasks =>
      _tasks.where((t) => !t.completed && t.dueDate.isAtSameMomentAs(DateTime.now())).toList();

  List<Task> get completedTasks => _tasks.where((t) => t.completed).toList();

  List<Task> get repeatedTasks =>
      _tasks.where((t) => t.repeat && !t.completed).toList();

  void addTask(Task task) {
    _tasks.add(task);
    NotificationService().scheduleNotification(task);
    notifyListeners();
  }

  void editTask(Task task) {
    int index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      NotificationService().scheduleNotification(task);
      notifyListeners();
    }
  }

  void deleteTask(Task task) {
    _tasks.removeWhere((t) => t.id == task.id);
    NotificationService().cancelNotification(task);
    notifyListeners();
  }

  void toggleComplete(Task task) {
    task.completed = !task.completed;
    notifyListeners();
  }

  void setTheme(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
  }
}