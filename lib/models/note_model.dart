class NoteModel {
  final int? id;
  final String title;
  final String body;

  NoteModel({this.id, required this.title, required this.body});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }

  @override
  String toString() {
    return 'Note {id: $id, title: $title, body: $body,}';
  }
}
