// views/task_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/task_viewmodel.dart';
import 'add_task_screen.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () {
            // Handle back action
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle, color: Colors.red, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTaskScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<TaskViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          
          if (viewModel.tasks.isEmpty) {
            return Center(child: Text('No tasks yet'));
          }
          
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: viewModel.tasks.length,
            itemBuilder: (context, index) {
              final task = viewModel.tasks[index];
              return Container(
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: viewModel.getTaskColor(index),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(
                    'Complete Android Project',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Finish the UI, integrate API, and write documentation',
                    style: TextStyle(fontSize: 12),
                  ),
                  contentPadding: EdgeInsets.all(12),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 40),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}