import 'package:flutter/material.dart';
import 'package:integration_test_workshop/src/todo/todo_controller.dart';
import 'package:integration_test_workshop/src/todo/todo_model.dart';
import 'package:provider/provider.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  final VoidCallback? onTapIcon;
  final VoidCallback? onTapRemove;

  const TodoTile(
      {super.key, required this.todo, this.onTapIcon, this.onTapRemove});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: InkWell(
        onTap: onTapIcon,
        child: todo.isDone
            ? const Icon(Icons.check, color: Colors.green)
            : const Icon(Icons.close, color: Colors.red),
      ),
      title: Text(todo.title),
      trailing: InkWell(
        onTap: onTapRemove,
        child: const Icon(
          Icons.remove_circle,
          color: Colors.red,
        ),
      ),
    );
  }
}

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  void showAddTodoDialog(BuildContext context) {
    final controller = Provider.of<TodoController>(context, listen: false);
    final TextEditingController textField = TextEditingController();
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      pageBuilder: (context, animation, secondaryAnimation) {
        return Dialog(
          child: SizedBox(
            child: Column(
              children: [
                const Text("ADD TODO"),
                TextFormField(
                  key: const Key('title-text-field'),
                  controller: textField,
                ),
                ElevatedButton(
                    key: Key('submit'),
                    onPressed: () {
                      controller.addTodo(Todo(title: textField.text));
                      Navigator.pop(context);

                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: Text('Done!'),
                        ),
                      );
                    },
                    child: const Text('Submit'))
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoController(),
      child: Consumer<TodoController>(builder: (context, con, child) {
        return Scaffold(
          floatingActionButton: IconButton(
              key: Key('add-todo-btn'),
              icon: const Icon(Icons.add),
              onPressed: () => showAddTodoDialog(context)),
          body: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: con.todos.length,
                  itemBuilder: (context, index) {
                    return TodoTile(
                      todo: con.todos[index],
                      onTapIcon: () =>
                          con.updateTodoStatus(index, !con.todos[index].isDone),
                      onTapRemove: () => con.remove(index),
                    );
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
