import 'package:flutter/material.dart';
import 'package:todo_app/view/utils/todolist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List todos = [
    ['asd', false],
    ['das', false],
  ];
  final _controller = TextEditingController();

  void saveNewTask() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        todos.add([_controller.text, false]);
        _controller.clear();
        FocusScope.of(context).unfocus();
      }
    });
  }

  void checkBoxChanged(int index) {
    setState(() {
      todos[index][1] = !todos[index][1];
    });
  }

  void deleteTask(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[300],
      appBar: AppBar(
        title: Text('Todo'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, index) {
          return Todolist(
            tasknames: todos[index][0],
            taskCompleted: todos[index][1],
            onChanged: (value) => checkBoxChanged(index),
            deletefunction: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _controller,

                decoration: InputDecoration(
                  fillColor: Colors.blueGrey[300],
                  filled: true,
                  hintText: 'Add New Tasks',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.blueGrey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              saveNewTask();
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
