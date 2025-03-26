import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';

class ApiService {
  static const String baseUrl = 'https://amock.io/api/researchUTH/tasks';

  Future<List<Task>> getTasks() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body is Map && body['data'] is List) {
          final tasks = body['data'] as List;
          return tasks.map((dynamic item) {
            if (item is! Map<String, dynamic>) {
              throw FormatException('Task item is not a valid Map');
            }
            return Task.fromJson(item);
          }).toList();
        } else {
          throw Exception('Unexpected data format');
        }
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Task> getTaskDetail(String taskId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$taskId'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Task.fromJson(data);
      } else {
        throw Exception('Failed to load task details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load task details: $e');
    }
  }
}
