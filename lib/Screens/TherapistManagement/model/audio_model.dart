import 'package:cloud_firestore/cloud_firestore.dart';

class AudioModel {
  final String id;
  final String? word;
  final String? url;
  final DateTime? date;
  final bool? result;
  String? feedback; 

  AudioModel({
    required this.id,
    this.word,
    this.url,
    this.date,
    this.feedback, 
    this.result, 
  });

  factory AudioModel.fromMap(Map<String, dynamic> map, String id) {
    return AudioModel(
      id: id,
      word: map['word'] as String?,
      url: map['url'] as String?,
      result: map['result'] as bool?,
      date: (map['date'] as Timestamp?)?.toDate(),
      feedback: map['feedback'] as String?, 
    );
  }
}

