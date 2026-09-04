import 'dart:io';
import 'package:riverpod/riverpod.dart';
import 'package:task_manager_console/providers/providers.dart';

void main() {
  final container = ProviderContainer();
  final taskService = container.read(taskServiceProvider);

  bool running = true;

  print('=== Task Manager Console (Dart + Riverpod) ===');

  while (running) {
    printMenu();
    final choice = stdin.readLineSync()?.trim();

    switch (choice) {
      case '1':
        stdout.write('Enter task title: ');
        final title = stdin.readLineSync()?.trim() ?? '';
        if (title.isEmpty) {
          print('Title cannot be empty.\n');
          break;
        }
        final task = taskService.addTask(title);
        print('Added: $task\n');
        break;

      case '2':
        final tasks = taskService.getAllTasks();
        if (tasks.isEmpty) {
          print('No tasks yet.\n');
        } else {
          print('--- All Tasks ---');
          for (final t in tasks) {
            print(t);
          }
          print('');
        }
        break;

      case '3':
        stdout.write('Enter task id to complete: ');
        final id = int.tryParse(stdin.readLineSync()?.trim() ?? '');
        if (id == null) {
          print('Invalid id.\n');
          break;
        }
        final success = taskService.completeTask(id);
        print(success ? 'Task $id marked complete.\n' : 'Task not found.\n');
        break;

      case '4':
        stdout.write('Enter task id to delete: ');
        final id = int.tryParse(stdin.readLineSync()?.trim() ?? '');
        if (id == null) {
          print('Invalid id.\n');
          break;
        }
        final success = taskService.deleteTask(id);
        print(success ? 'Task $id deleted.\n' : 'Task not found.\n');
        break;

      case '5':
        running = false;
        print('Goodbye!');
        break;

      default:
        print('Invalid choice, try again.\n');
    }
  }

  container.dispose();
}

void printMenu() {
  print('''
Choose an option:
  1. Add a task
  2. List all tasks
  3. Complete a task
  4. Delete a task
  5. Exit
''');
  stdout.write('> ');
}