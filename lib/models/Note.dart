class Note {
  final String id;
  final String title;
  final String body;

  Note({
    this.id,
    this.title,
    this.body
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json["_id"],
      title: json["title"],
      body: json["body"]);
  }

  Map toJson() {
    return {'id': id, 'title': title, 'body': body};
  }

  @override
  String toString() {
    return "[$id] <$title> $body";
  }
}