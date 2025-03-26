class Task {
  final int id;
  final String title;
  final String description;
  final String status;
  final String priority;
  final String category;
  final DateTime dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Subtask> subtasks;
  final List<Attachment> attachments;
  final List<Reminder> reminders;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.category,
    required this.dueDate,
    required this.createdAt,
    required this.updatedAt,
    required this.subtasks,
    required this.attachments,
    required this.reminders,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      priority: json['priority'],
      category: json['category'],
      dueDate: DateTime.parse(json['dueDate']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      subtasks: (json['subtasks'] as List)
          .map((i) => Subtask.fromJson(i))
          .toList(),
      attachments: (json['attachments'] as List)
          .map((i) => Attachment.fromJson(i))
          .toList(),
      reminders: (json['reminders'] as List)
          .map((i) => Reminder.fromJson(i))
          .toList(),
    );
  }
}

class Subtask {
  final int id;
  final String title;
  final bool isCompleted;

  Subtask({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  factory Subtask.fromJson(Map<String, dynamic> json) {
    return Subtask(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }
}

class Attachment {
  final int id;
  final String fileName;
  final String fileUrl;

  Attachment({
    required this.id,
    required this.fileName,
    required this.fileUrl,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'],
      fileName: json['fileName'],
      fileUrl: json['fileUrl'],
    );
  }
}

class Reminder {
  final int id;
  final DateTime time;
  final String type;

  Reminder({
    required this.id,
    required this.time,
    required this.type,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],
      time: DateTime.parse(json['time']),
      type: json['type'],
    );
  }
}