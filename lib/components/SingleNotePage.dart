import 'package:flutter/material.dart';
import '../models/Note.dart';

class SingleNotePage extends StatefulWidget {
  Note note;

  SingleNotePage({Key key, this.note}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SingleNotePageState();
}

class SingleNotePageState extends State<SingleNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.note.title)),
        body: Card(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                textAlign: TextAlign.left,
                controller: TextEditingController.fromValue(
                    TextEditingValue(text: widget.note.body)),
              )
            ],
          ),
        ));
  }
}
