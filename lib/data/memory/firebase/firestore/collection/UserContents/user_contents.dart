import 'package:cloud_firestore/cloud_firestore.dart';

class UserContents {
  final String id;
  final String contentsSubject;
  final String contents;
  final String contentsImage;
  final Timestamp time;
  final String hashTag;
  final int likeCount;

  UserContents(
    this.id,
    this.contentsSubject,
    this.contents,
    this.contentsImage,
    this.time,
    this.hashTag,
    this.likeCount,
  );
}
