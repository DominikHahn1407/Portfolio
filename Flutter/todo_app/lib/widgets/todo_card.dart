import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  const TodoCard(
    this.index,
    this.item,
    this.navigateEdit,
    this.deleteById, {
    super.key,
  });

  final int index;
  final Map item;
  final Function(Map) navigateEdit;
  final Function(String, String) deleteById;

  @override
  Widget build(BuildContext context) {
    final id = item["_id"] as String;
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text('${index + 1}'),
        ),
        title: Text(item['title']),
        subtitle: Text(item['description']),
        trailing: PopupMenuButton(
            onSelected: (value) {
              if (value == 'edit') {
                // open edit page
                navigateEdit(item);
              } else if (value == 'delete') {
                // remove item
                deleteById(id, item['title']);
              }
            },
            itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text("Edit"),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text("Delete"),
                  ),
                ]),
      ),
    );
  }
}
