import 'dart:convert';
import 'package:flutter/material.dart';
import 'models/Note.dart';
import 'API.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo list',
      home: NotesListScreen(),
    );
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
                )
              ],
            ),
          );
          // return ListTile(
          //   title:Text(notes[index].title)
          // );
        },
      ),
    );
  }

}

// class RandomWords extends StatefulWidget {
//   @override
//   RandomWordsState createState() => new RandomWordsState();
// }

// class RandomWordsState extends State<RandomWords> {
//   final _biggerFont = const TextStyle(fontSize: 18.0);
//   final notes Future<List<Note>>;

//   Future<List<Note>> fetchData() async{
//     final response = await http.get('https://warm-ocean-42352.herokuapp.com/notes');

//     if (response.statusCode == 200) {
//       var data = json.decode(response.body);
//       return (data as List).map((json) => Note.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load notes');
//     }
//   }

//   // <Note>[] _getData() async {
//   //   var httpClient = HttpClient();
//   //   var uri = Uri.https('warm-ocean-42352.herokuapp.com', '/notes');
//   //   var request = await httpClient.getUrl(uri);
//   //   var response = await request.close();
//   //   var responseBody = await response.transform(utf8.decoder).join();
//   //   debugPrint('Received: ');
//   //   debugPrint(responseBody);
//   //   var data = json.decode(responseBody);
//   //   return (data as List).map((json) => Note.fromJson(json)).toList();    
//   // }

//   Widget _buildRow(Note note) {
//     return Card(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           const ListTile(
//             leading: Icon(Icons.note),
//             title: Text('idi nahui')
//             // title: const Text(note.title),
//             // subtitle: const Text(note.id)
//           )
//         ],
//       ),
//     );
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Startup Name Generator'),
//       ),
//       body: _buildNotesList(),
//     );
//   }

// }
