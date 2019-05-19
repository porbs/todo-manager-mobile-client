import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/note.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'notes.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Notes ('
          'id INTEGER PRIMARY KEY,'
          'title TEXT,'
          'body TEXT'
          ')');
    });
  }

  createNote(Note note) async {
    final db = await database;
    var table = await db.rawQuery('SELECT MAX(id)+1 AS id FROM Notes');
    int id = table.first['id'];

    var raw = await db.rawInsert(
        "INSERT INTO Notes (id,title,body)"
        " VALUES (?,?,?)",
        [id, note.title, note.body]);
    return raw;
  }

  updateNote(Note note) async {
    final db = await database;
    var res = await db.update('Notes', note.toMap(),
      where: 'id = ?', whereArgs: [note.id]);
    return res;
  }

  getNote(int id) async {
    final db = await database;
    var res = await db.query('Notes', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Note.fromMap(res.first) : null;
  }

  Future<List<Note>> getAllNotes() async {
    final db = await database;
    var res = await db.query('Notes');
    List<Note> list = res.isNotEmpty ? res.map((note) => Note.fromMap(note)).toList() : [];
    return list;
  }

  deleteNote(int id) async {
    final db = await database;
    return db.delete('Notes', where: 'id = ?', whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("DELETE * FROM Notes");
  }
}
