import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data.dart';
import 'package:flutter_todo_app/todo_card_widget.dart';
import 'package:flutter_todo_app/todo_model.dart';
import 'package:flutter_todo_app/new_task_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void addTodo(TodoModel todoModel) {
    listOfTodo.add(todoModel);
    if (category == "All List" ||
        category == "Pending" ||
        category == todoModel.type) {
      _tempListOfTodo.add(todoModel);
    }
    setState(() {});
  }

  String category = "Pending";
  updateStatus(String id, bool status) async {
    int index = listOfTodo.indexWhere((element) => element.id == id);
    listOfTodo[index].status = status;
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 500));
    if (category == "All List") {
      _tempListOfTodo = listOfTodo.toList();
    } else if (category == "Pending") {
      _tempListOfTodo =
          listOfTodo.where((element) => element.status == false).toList();
    } else if (category == "Finished") {
      _tempListOfTodo =
          listOfTodo.where((element) => element.status == true).toList();
    } else {
      _tempListOfTodo =
          listOfTodo.where((element) => element.type == category).toList();
    }
    setState(() {});
  }

  List<TodoModel> listOfTodo = [];
  List<TodoModel> _tempListOfTodo = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (child) => NewTaskPage(
                addTodo: addTodo,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("TODO: $category"),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              print(value);
              category = value;
              if (category == "All List") {
                _tempListOfTodo = listOfTodo.toList();
              } else if (category == "Pending") {
                _tempListOfTodo = listOfTodo
                    .where((element) => element.status == false)
                    .toList();
              } else if (category == "Finished") {
                _tempListOfTodo = listOfTodo
                    .where((element) => element.status == true)
                    .toList();
              } else {
                _tempListOfTodo = listOfTodo
                    .where((element) => element.type == value)
                    .toList();
              }
              setState(() {});
            },
            itemBuilder: (context) => popUpMenuItemTitleList
                .map(
                  (e) => PopupMenuItem(
                    value: e,
                    child: Text(
                      e,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
      body: ListView(
        children: _tempListOfTodo
            .map(
              (e) => TodoCardWidget(
                todoModel: e,
                update: updateStatus,
              ),
            )
            .toList(),
      ),
    );
  }
}
