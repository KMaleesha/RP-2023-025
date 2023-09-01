import 'package:cloud_firestore/cloud_firestore.dart';

class AudioModel {
  final String id; // To hold the document ID
  final String? word;
  final String? url;
  final DateTime? date;

  AudioModel({
    required this.id,
    this.word,
    this.url,
    this.date,
  });

  factory AudioModel.fromMap(Map<String, dynamic> map, String id) {
    return AudioModel(
      id: id,
      word: map['word'] as String?,
      url: map['url'] as String?,
      date: (map['date'] as Timestamp?)?.toDate(),
    );
  }
}
