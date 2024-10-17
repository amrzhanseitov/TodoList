import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cool TODO List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<Map<String, dynamic>> _todoItems = [];
  final TextEditingController _controller = TextEditingController();

  // Add a new task
  void _addTodoItem(String task) {
    setState(() {
      _todoItems.add({
        'task': task,
        'isCompleted': false, // Track if the task is crossed out
      });
    });
    _controller.clear(); // Clear the input field after adding
  }

  // Toggle task completion (cross out)
  void _toggleTask(int index) {
    setState(() {
      _todoItems[index]['isCompleted'] = !_todoItems[index]['isCompleted'];
    });
  }

  // Remove all completed (crossed-out) tasks
  void _deleteCompletedTasks() {
    setState(() {
      _todoItems.removeWhere((item) => item['isCompleted']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter a task',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _addTodoItem(_controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _todoItems[index]['task'],
                    style: TextStyle(
                      decoration: _todoItems[index]['isCompleted']
                          ? TextDecoration.lineThrough // Cross out completed tasks
                          : TextDecoration.none,
                    ),
                  ),
                  onTap: () => _toggleTask(index), // Cross out when tapped
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _todoItems.removeAt(index); // Remove individual task
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}