import 'package:flutter/material.dart';
import 'package:flutter_todo_app/todo_model.dart';

class TodoCardWidget extends StatelessWidget {
  final TodoModel todoModel;
  final Function(String,bool) update;

  const TodoCardWidget({
    Key? key,
    required this.todoModel,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          onChanged: (value) {
            print(value);

            update(todoModel.id,value!);
          },
          value: todoModel.status,
        ),
        title: Text(todoModel.taskName),
        subtitle: Text(
          todoModel.dueDate,
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          todoModel.type,
          style: TextStyle(
              color: todoTypeColor(todoModel.type),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

Color todoTypeColor(String value) {
  switch (value) {
    case "Shopping":
      return Colors.amber;
    case "Work":
      return Colors.blue;
    case "Personal":
      return Colors.red;
    case "Wishlist":
      return Colors.orange;
    default:
      return Colors.black;
  }
}
