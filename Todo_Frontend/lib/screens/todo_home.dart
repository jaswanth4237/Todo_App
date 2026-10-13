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

  Future<void> openTodoDialog({Todo? todo}) async {
    final titleController = TextEditingController(text: todo?.title ?? '');
    final descController = TextEditingController(text: todo?.decription ?? '');

    try {
      await showDialog<void>(
        context: context,
        builder:
            (dialogContext) => AlertDialog(
              title: Text(todo == null ? 'Add Todo' : 'Update Todo'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    autofocus: true,
                  ),
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final title = titleController.text.trim();
                    if (title.isEmpty) {
                      ScaffoldMessenger.of(dialogContext).showSnackBar(
                        const SnackBar(content: Text('A title is required.')),
                      );
                      return;
                    }

                    try {
                      if (todo == null) {
                        await TodoService.addTodo(
                          title,
                          descController.text.trim(),
                        );
                      } else {
                        await TodoService.updateTodo(
                          todo.id,
                          title,
                          descController.text.trim(),
                        );
                      }
                      if (dialogContext.mounted) {
                        Navigator.pop(dialogContext);
                      }
                      if (mounted) {
                        setState(loadTodos);
                      }
                    } catch (_) {
                      if (dialogContext.mounted) {
                        ScaffoldMessenger.of(dialogContext).showSnackBar(
                          const SnackBar(content: Text('Unable to save todo.')),
                        );
                      }
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
      );
    } finally {
      titleController.dispose();
      descController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'My Todo List',
          style: TextStyle(
            color: Color.fromARGB(255, 128, 16, 202),
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openTodoDialog(),
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Todo>>(
        future: todos,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Unable to load todos.'),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () => setState(loadTodos),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;
          if (data.isEmpty) {
            return const Center(child: Text('No Todos Found'));
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
                          try {
                            await TodoService.deleteTodo(todo.id);
                            if (context.mounted) {
                              setState(loadTodos);
                            }
                          } catch (_) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Unable to delete todo.'),
                                ),
                              );
                            }
                          }
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
