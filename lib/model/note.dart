import 'dart:convert';

Note noteFromJson(String str) => Note.fromMap(json.decode(str));

String noteToJson(Note data) => json.encode(data.toMap());

class Note {
  int id;
  String title;
  String body;

  Note({
    this.id,
    this.title,
    this.body,
  });

  factory Note.fromMap(Map<String, dynamic> json) => new Note(
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "body": body,
      };

}
