import 'dart:convert';

Note noteFromJson(String str) => Note.fromJson(json.decode(str));

String noteToJson(Note data) => json.encode(data.toJson());

class Note {
  String title;
  String body;

  Note({
    this.title,
    this.body,
  });

  factory Note.fromJson(Map<String, dynamic> json) => new Note(
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
      };
}
