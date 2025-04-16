// viewmodels/task_viewmodel.dart
import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/database_service.dart';

class TaskViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Task> _tasks = [];
  bool _isLoading = false;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  // Constructor to load tasks when ViewModel is initialized
  TaskViewModel() {
    loadTasks();
  }

  // Method to load tasks from the database
  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();

    try {
      _tasks = await _databaseService.getTasks();
    } catch (e) {
      print('Error loading tasks: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method to add a new task
  Future<void> addTask(String title, String description, String category) async {
    final task = Task(
      title: title,
      description: description,
      category: category,
      createdAt: DateTime.now(),
    );

    try {
      await _databaseService.insertTask(task);
      await loadTasks(); // Reload the tasks after adding
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  // Method to delete a task
  Future<void> deleteTask(int id) async {
    try {
      await _databaseService.deleteTask(id);
      await loadTasks(); // Reload the tasks after deleting
    } catch (e) {
      print('Error deleting task: $e');
    }
  }

  // Helper method to get color based on task index for UI
  Color getTaskColor(int index) {
    List<Color> colors = [
      Color(0xFFAED9E0), // Light blue
      Color(0xFFFAB3A9), // Light red
      Color(0xFFE2F0CB), // Light green
      Color(0xFFFDFDB7), // Light yellow
    ];
    return colors[index % colors.length];
  }
}