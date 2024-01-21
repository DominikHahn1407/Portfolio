import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_todo.dart';
import 'package:todo_app/services/todo_service.dart';
import 'package:todo_app/utils/snackbar_helper.dart';
import 'package:todo_app/widgets/todo_card.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Todo List'),
        ),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetchTodos,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                "Nothing Todo",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            child: ListView.builder(
                itemCount: items.length,
                padding: const EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  return TodoCard(index, item, navigateToEditPage, deleteTodo);
                }),
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: const Text("Add"),
      ),
    );
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => const AddTodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodos();
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    final response = await TodoService.fetchTodos();
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      if (!context.mounted) return;
      showErrorMessage(context, "Todos could not be fetched!");
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> deleteTodo(String id, String title) async {
    // Delete item
    final isSuccess = await TodoService.deleteById(id);
    // Remove item from list
    if (isSuccess) {
      final filteredItems =
          items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filteredItems;
      });
      if (!context.mounted) return;
      showSuccessMessage(context, "Todo $title successfull deleted");
    } else {
      if (!context.mounted) return;
      showErrorMessage(context, "Could not delete Todo $title");
    }
  }
}
