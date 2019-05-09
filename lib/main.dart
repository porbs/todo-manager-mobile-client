import 'package:flutter/material.dart';
import 'package:todo_app/model/note.dart';
import 'package:todo_app/service/db_provider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(title: 'Todo List', home: new TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  void _pushAddTodoScreen() async {
    final titleCtrl = TextEditingController();
    final bodyCtrl = TextEditingController();

    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text('Add a new task'),
            actions: <Widget>[
              new FlatButton(
                child: new Text('ADD'),
                onPressed: () async {
                  Note note =
                      new Note(title: titleCtrl.text, body: bodyCtrl.text);
                  await DBProvider.db.createNote(note);
                  setState(() {});
                  Navigator.of(context).pop();
                },
                textColor: Color.fromRGBO(255, 255, 255, 1.0),
              ),
            ],
          ),
          body: new Column(
            children: <Widget>[
              new TextField(
                autofocus: true,
                controller: titleCtrl,
                decoration: new InputDecoration(
                    hintText: 'Enter to do title',
                    contentPadding: const EdgeInsets.all(16.0)),
              ),
              new Expanded(
                child: new TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: bodyCtrl,
                  decoration: new InputDecoration(
                      hintText: 'Enter something to do...',
                      contentPadding: const EdgeInsets.all(16.0)),
                ),
              )
            ],
          ));
    }));
  }

  Widget _buildTodoList(BuildContext context, AsyncSnapshot snapshot) {
    if (!snapshot.hasData || snapshot.data == null) {
      print(snapshot);
      return Center(child: CircularProgressIndicator());
    } else {
      return new ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          Note item = snapshot.data[index];
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: UniqueKey(),
            background: Container(
                color: Colors.greenAccent,
                child: Align(
                    alignment: Alignment.lerp(
                        Alignment.centerRight, Alignment.center, 0.1),
                    child: Icon(
                      Icons.archive,
                      size: 50,
                      color: Colors.white
                    ))),
            onDismissed: (direction) {
              DBProvider.db.deleteNote(item.id);
            },
            child: ListTile(
              title: Text(item.title),
              contentPadding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(todo: item),
                  ),
                );
              },
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Todo List')),
      body: new FutureBuilder<List<Note>>(
          future: DBProvider.db.getAllNotes(), builder: _buildTodoList),
      floatingActionButton: new FloatingActionButton(
          onPressed: _pushAddTodoScreen,
          tooltip: 'Add task',
          child: new Icon(Icons.add)),
    );
  }
}

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
