import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String title;
  final String body;
  final Timestamp createdTime;
  final String? id;

  Note({required this.title, required this.body, required this.createdTime, this.id});

  Map<String, Object?> toJSON() => {
        'title': title,
        'body': body,
        'createdTime': createdTime,
        'id': id,
      };

  static Note fromJSON(Map<String, Object?> json) => Note(
        title: json['title'] as String,
        body: json['body'] as String,
        createdTime: json['createdTime'] as Timestamp,
        id: json['id'] as String,
      );

  Note copy({
    String? id,
    String? title,
    String? body,
    Timestamp? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        createdTime: createdTime ?? this.createdTime,
      );
}
