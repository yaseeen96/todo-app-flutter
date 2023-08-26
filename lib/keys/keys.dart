import 'package:flutter/material.dart';
import 'package:flutter_internals/keys/add_todo.dart';

import 'package:flutter_internals/keys/checkable_todo_item.dart';
// import 'package:flutter_internals/keys/todo_item.dart';

class Todo {
  const Todo(this.text, this.priority);

  final String text;
  final Priority priority;
}

class Keys extends StatefulWidget {
  const Keys({super.key});

  @override
  State<Keys> createState() {
    return _KeysState();
  }
}

class _KeysState extends State<Keys> {
  void _presentModalBottomSheet() {
    showModalBottomSheet(
        useSafeArea: true,
        context: context,
        builder: (ctx) {
          return AddTodo(
            onAddTodo: addTodo,
          );
        });
  }

  var _order = 'asc';
  final _todos = [
    const Todo(
      'Learn Flutter',
      Priority.urgent,
    ),
    const Todo(
      'Practice Flutter',
      Priority.normal,
    ),
    const Todo(
      'Explore other courses',
      Priority.low,
    ),
  ];

  void addTodo(Todo todo) {
    setState(() {
      _todos.add(todo);
    });
  }

  List<Todo> get _orderedTodos {
    final sortedTodos = List.of(_todos);
    sortedTodos.sort((a, b) {
      final bComesAfterA = a.text.compareTo(b.text);
      return _order == 'asc' ? bComesAfterA : -bComesAfterA;
    });
    return sortedTodos;
  }

  void _changeOrder() {
    setState(() {
      _order = _order == 'asc' ? 'desc' : 'asc';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Internals'),
      ),
      body: ListView(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: _changeOrder,
              icon: Icon(
                _order == 'asc' ? Icons.arrow_downward : Icons.arrow_upward,
              ),
              label:
                  Text('Sort ${_order == 'asc' ? 'Descending' : 'Ascending'}'),
            ),
          ),
          Column(
            children: [
              for (final todo in _orderedTodos)
                CheckableTodoItem(
                  key: ObjectKey(todo), // ValueKey()
                  todo.text,
                  todo.priority,
                ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _presentModalBottomSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}
