import 'dart:convert';
import 'package:flutter/material.dart';
import 'models/Note.dart';
import 'API.dart';
import 'components/SingleNotePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo list',
        home: NotesListScreen());
  }
}

class NotesListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State {
  var notes = List<Note>();

  _getNotes() {
    API.getNotes().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        notes = list.map((model) => Note.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.note),
                    title: Text(notes[index].title),
                    subtitle: Text(notes[index].id),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                SingleNotePage(note: notes[index])),
                      );
                    })
              ],
            ),
          );
        },
      ),
    );
  }
}
