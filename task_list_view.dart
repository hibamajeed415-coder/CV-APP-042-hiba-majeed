import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';
import 'add_task_view.dart';

class TaskListView extends StatelessWidget {
  final List<Task> tasks;
  const TaskListView({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskController = Provider.of<TaskController>(context);

    if (tasks.isEmpty) {
      return const Center(child: Text('No tasks'));
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        double progress = task.subtasks.isEmpty
            ? (task.completed ? 1.0 : 0.0)
            : task.subtasks.where((s) => s.completed).length / task.subtasks.length;

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListTile(
            leading: Checkbox(
              value: task.completed,
              onChanged: (_) => taskController.toggleComplete(task),
            ),
            title: Text(task.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.description),
                if (task.subtasks.isNotEmpty)
                  LinearProgressIndicator(value: progress),
                Text('Due: ${task.dueDate.toLocal()}'.split(' ')[0]),
              ],
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (val) {
                if (val == 'Edit') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddTaskView(task: task)),
                  );
                } else if (val == 'Delete') {
                  taskController.deleteTask(task);
                }
              },
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'Edit', child: Text('Edit')),
                PopupMenuItem(value: 'Delete', child: Text('Delete')),
              ],
            ),
          ),
        );
      },
    );
  }
}