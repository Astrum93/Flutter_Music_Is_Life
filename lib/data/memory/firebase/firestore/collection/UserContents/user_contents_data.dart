import 'package:cloud_firestore/cloud_firestore.dart';

class UserContents {
  final String? id;
  final String? title;
  final String? name;
  final String? contents;
  final String? contentsImage;
  final Timestamp? time;
  final List<String>? hashTag;
  final int? likeCount;

  UserContents({
    this.id,
    this.title,
    this.contents,
    this.contentsImage,
    this.time,
    this.hashTag,
    this.likeCount,
    this.name,
  });

  factory UserContents.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserContents(
      id: data?['id'],
      title: data?['title'],
      contents: data?['contents'],
      contentsImage: data?['contentsImage'],
      time: data?['time'],
      hashTag: data?['hashTag'],
      likeCount: data?['likeCount'],
      name: data?['name'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (contents != null) 'contents': contents,
      if (contentsImage != null) 'contentsImage': contentsImage,
      if (time != null) 'time': time,
      if (hashTag != null) 'hashTag': hashTag,
      if (likeCount != null) 'likeCount': likeCount,
      if (name != null) 'name': name,
    };
  }
}
