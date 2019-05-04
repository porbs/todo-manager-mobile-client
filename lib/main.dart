import 'package:flutter/material.dart';
import './note.dart';

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
  List<Note> _todoItems = [];

  void _addTodoItem(Note task) {
    if (task.title.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }

  void _pushAddTodoScreen() {
    final titleCtrl = TextEditingController();
    final bodyCtrl = TextEditingController();

    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text('Add a new task'),
            actions: <Widget>[
              new FlatButton(
                child: new Text('ADD'),
                onPressed: () {
                  _addTodoItem(
                      new Note(title: titleCtrl.text, body: bodyCtrl.text));
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

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('Mark "${_todoItems[index]}" as done?'),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              new FlatButton(
                child: new Text('MARK AS DONE'),
                onPressed: () {
                  _removeTodoItem(index);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index].title, index);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText, int index) {
    return new ListTile(
      title: new Text((index + 1).toString() + '. ' + todoText),
      onLongPress: () => _promptRemoveTodoItem(index),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(todo: _todoItems[index]),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Todo List')),
      body: _buildTodoList(),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(todo.body),
      ),
    );
  }
}
