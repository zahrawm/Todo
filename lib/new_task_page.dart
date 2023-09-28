import 'package:flutter/material.dart';
import 'package:flutter_todo_app/todo_model.dart';

class NewTaskPage extends StatefulWidget {
  final Function(TodoModel) addTodo;
  const NewTaskPage({
    Key? key,
    required this.addTodo,
  }) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  TextEditingController taskController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  String dropDownValue = "Work";
  @override
  Widget build(BuildContext context) {
    print("rebuild");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_rounded)),
        title: const Text("New Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 20,
          left: 20,
          top: 20,
          bottom: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What is to be done?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
            TextField(
              controller: taskController,
              decoration: const InputDecoration(
                hintText: "Enter your task",
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Due Date",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: dueDateController,
                    decoration: const InputDecoration(
                      hintText: "Date not set",
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    dueDateController.text = date.toString().substring(0, 10);
                    print(date);
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Add to list",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
            DropdownButton(
              isExpanded: true,
              value: dropDownValue,
              items: const [
                DropdownMenuItem(
                  value: "Work",
                  child: Text("Work"),
                ),
                DropdownMenuItem(
                  value: "Shopping",
                  child: Text("Shopping"),
                ),
                DropdownMenuItem(
                  value: "Personal",
                  child: Text("Personal"),
                ),
                DropdownMenuItem(
                  value: "Wishlist",
                  child: Text("Wishlist"),
                ),
              ],
              onChanged: (value) {
                dropDownValue = value!;
                setState(() {});
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.addTodo(
            TodoModel(
              id: DateTime.now().toString(),
              dueDate: dueDateController.text,
              status: false,
              taskName: taskController.text,
              type: dropDownValue,
            ),
          );
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.check,
        ),
      ),
    );
  }
}
