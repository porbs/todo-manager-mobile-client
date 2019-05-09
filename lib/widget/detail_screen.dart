import 'package:flutter/material.dart';
import 'package:todo_app/model/note.dart';
import 'package:todo_app/service/db_provider.dart';

class DetailScreen extends StatelessWidget {
  final Note todo;

  DetailScreen({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyCtrl = TextEditingController(text: todo.body);
    return Scaffold(
      appBar: AppBar(
          title: Text(todo.title + ' (#' + todo.id.toString() + ')'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('ADD'),
              onPressed: () async {
                Note note = new Note(
                    id: todo.id, title: todo.title, body: bodyCtrl.text);
                await DBProvider.db.updateNote(note);
                Navigator.of(context).pop();
              },
              textColor: Color.fromRGBO(255, 255, 255, 1.0),
            ),
          ]),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: new TextField(
          autofocus: true,
          controller: bodyCtrl,
          decoration: new InputDecoration(
              hintText: 'Enter to do data',
              contentPadding: const EdgeInsets.all(16.0)),
        ),
      ),
    );
  }
}
