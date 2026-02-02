import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import '../services/todo_service.dart';

class TodoHome extends StatefulWidget {
  const TodoHome({super.key});

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  late Future<List<Todo>> todos;

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  void loadTodos() {
    todos = TodoService.fetchTodos();
  }

  void openTodoDialog({Todo? todo}) {
    final titleController =
        TextEditingController(text: todo?.title ?? "");
    final descController =
        TextEditingController(text: todo?.decription ?? "");

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(todo == null ? "Add Todo" : "Update Todo"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (todo == null) {
                await TodoService.addTodo(
                  titleController.text,
                  descController.text,
                );
              } else {
                await TodoService.updateTodo(
                  todo.id,
                  titleController.text,
                  descController.text,
                );
              }
              Navigator.pop(context);
              setState(loadTodos);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("My Todo List",style:TextStyle(color: Color.fromARGB(255, 128, 16, 202),fontWeight: FontWeight.bold,fontSize: 28))),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openTodoDialog(),
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Todo>>(
        future: todos,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;
          if (data.isEmpty) {
            return const Center(child: Text("No Todos Found"));
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, i) {
              final todo = data[i];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.decription),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => openTodoDialog(todo: todo),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await TodoService.deleteTodo(todo.id);
                          setState(loadTodos);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
