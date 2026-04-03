class Task {
  int id;
  String title;
  String description;
  DateTime dueDate;
  bool completed;
  bool repeat;
  List<Subtask> subtasks;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    required this.dueDate,
    this.completed = false,
    this.repeat = false,
    List<Subtask>? subtasks,
  }) : subtasks = subtasks ?? [];
}

class Subtask {
  String title;
  bool completed;

  Subtask({required this.title, this.completed = false});
}