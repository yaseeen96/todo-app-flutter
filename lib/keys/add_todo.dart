import 'package:flutter/material.dart';
import 'package:flutter_internals/keys/checkable_todo_item.dart';

import 'package:flutter_internals/keys/keys.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({
    super.key,
    required this.onAddTodo,
  });
  final void Function(Todo todo) onAddTodo;

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  @override
  void dispose() {
    _todoController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  final TextEditingController _todoController = TextEditingController();
  Priority _selectedPriority = Priority.low;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      height: MediaQuery.of(context).size.height * 0.5,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            "Add Todo",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: _todoController,
            decoration: InputDecoration(
                label: Text("Your todo"), contentPadding: EdgeInsets.all(10)),
          ),
          SizedBox(
            width: double.infinity,
            child: DropdownButton(
                borderRadius: BorderRadius.circular(10),
                padding: const EdgeInsets.all(10),
                value: _selectedPriority,
                items: Priority.values
                    .map((priority) => DropdownMenuItem(
                        value: priority,
                        child: Text(priority.toString().toUpperCase())))
                    .toList(),
                onChanged: (selectedPriority) {
                  if (selectedPriority != null) {
                    setState(() {
                      _selectedPriority = selectedPriority;
                    });
                  }
                }),
          ),
          ElevatedButton(
              onPressed: () {
                widget.onAddTodo(
                    Todo(_todoController.text, _selectedPriority as Priority));
                Navigator.pop(context);
              },
              child: const Text("Add todo"))
        ]),
      ),
    );
  }
}
