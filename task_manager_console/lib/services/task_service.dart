import '../models/task.dart';

class TaskService {
  final List<Task> _tasks = [];
  int _nextId = 1;

  List<Task> getAllTasks() => List.unmodifiable(_tasks);

  Task addTask(String title) {
    final task = Task(id: _nextId++, title: title);
    _tasks.add(task);
    return task;
  }

  bool completeTask(int id) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index == -1) return false;
    _tasks[index] = _tasks[index].copyWith(isCompleted: true);
    return true;
  }

  bool deleteTask(int id) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index == -1) return false;
    _tasks.removeAt(index);
    return true;
  }

  List<Task> get pendingTasks =>
      _tasks.where((t) => !t.isCompleted).toList();

  List<Task> get completedTasks =>
      _tasks.where((t) => t.isCompleted).toList();
}