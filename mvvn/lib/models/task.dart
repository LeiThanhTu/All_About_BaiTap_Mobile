// models/task.dart
class Task {
  final int? id;
  final String title;
  final String description;
  final String category;
  final DateTime createdAt;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.createdAt,
  });

  // Convert Task to Map for storing in Room database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create Task from Map when retrieving from Room database
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}