import 'package:flutter/material.dart';
import 'package:todo_app/services/todo_service.dart';
import 'package:todo_app/utils/snackbar_helper.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({
    super.key,
    this.todo,
  });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          isEdit ? "Edit Todo" : "Add Todo",
        )),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: "Title"),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: "Description"),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: isEdit ? updateData : submitData,
            child: Text(
              isEdit ? "Update" : "Submit",
            ),
          ),
        ],
      ),
    );
  }

  Future<void> submitData() async {
    //Get the data from form
    final isSuccess = await TodoService.addTodo(body);
    if (isSuccess) {
      if (!context.mounted) return;
      showSuccessMessage(context, "Todo successfull added");
      titleController.text = "";
      descriptionController.text = "";
    } else {
      if (!context.mounted) return;
      showErrorMessage(context, "Todo creation failed!");
    }
    //Visual Feedback for user
  }

  Future<void> updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      if (!context.mounted) return;
      showErrorMessage(context, "You can not update without data");
      return;
    }

    final id = todo['_id'];
    body['is_completed'] = todo['is_completed'];
    final isSuccess = await TodoService.updateTodo(id, body);
    if (isSuccess) {
      if (!context.mounted) return;
      showSuccessMessage(context, "Successfully updated todo $id");
    } else {
      if (!context.mounted) return;
      showErrorMessage(context, "Todo $id could not be updated");
    }
  }

  Map get body {
    final title = titleController.text;
    final description = descriptionController.text;
    return {
      "title": title,
      "description": description,
      "is_completed": false,
    };
  }
}
