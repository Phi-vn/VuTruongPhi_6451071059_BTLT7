import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../utils/api_helper.dart';
import '../widgets/task_item.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  List<TaskModel> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    try {
      final tasks = await ApiHelper.getTasks();
      setState(() {
        _tasks = tasks;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading tasks: $e')),
        );
      }
    }
  }

  Future<void> _deleteTask(int id) async {
    // Optimistic UI update: Remove from list first
    final deletedTask = _tasks.firstWhere((t) => t.id == id);
    final deletedIndex = _tasks.indexOf(deletedTask);

    setState(() {
      _tasks.removeAt(deletedIndex);
    });

    try {
      await ApiHelper.deleteTask(id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Deleted task: $id'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      // Rollback if API fails
      if (mounted) {
        setState(() {
          _tasks.insert(deletedIndex, deletedTask);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting task: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager (MSSV: 6451071059)'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _tasks.isEmpty
              ? const Center(child: Text('No tasks available.'))
              : RefreshIndicator(
                  onRefresh: _fetchTasks,
                  child: ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      return TaskItem(
                        task: task,
                        onDelete: () => _deleteTask(task.id),
                      );
                    },
                  ),
                ),
    );
  }
}
