// ignore_for_file: unnecessary_this

class minuppgift {
  String? id;
  final String title;
  bool done;
  minuppgift({required this.title, this.id, this.done = false});

  void noteDone(minuppgift note) {
    done = !done;
  }

  static Map<String, dynamic> toMap(minuppgift note) {
    return {
      'id': note.id,
      'title': note.title,
      'done': note.done,
    };
  }

  minuppgift.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        done = json['done'],
        id = json['id'];

  static Map<String, dynamic> toJson(minuppgift note) =>
      {'title': note.title, 'done': note.done, 'id': note.id};
}
