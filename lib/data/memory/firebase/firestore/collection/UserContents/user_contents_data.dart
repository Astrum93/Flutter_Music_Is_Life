import 'package:cloud_firestore/cloud_firestore.dart';

class UserContents {
  final String id;
  final String title;
  final String name;
  final String contents;
  final String contentsImage;
  final Timestamp time;
  final List<String> hashTag;
  final int likeCount;

  UserContents({
    required this.id,
    required this.title,
    required this.contents,
    required this.contentsImage,
    required this.time,
    required this.hashTag,
    required this.likeCount,
    required this.name,
  });

  factory UserContents.fromJson(Map<String, dynamic> json) {
    return UserContents(
      id: json['id'],
      title: json['title'],
      contents: json['contents'],
      contentsImage: json['contentsImage'],
      time: json['time'],
      hashTag: json['hashTag'],
      likeCount: json['likeCount'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'contents': contents,
      'contentsImage': contentsImage,
      'time': time,
      'hashTag': hashTag,
      'likeCount': likeCount,
      'name': name,
    };
  }
}
