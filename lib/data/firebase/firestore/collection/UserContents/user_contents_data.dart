import 'package:cloud_firestore/cloud_firestore.dart';

class UserContentsData {
  final String id;
  final String contentsSubject;
  final String contents;
  final String contentsImage;
  final Timestamp time;

  UserContentsData(
    this.id,
    this.contentsSubject,
    this.contents,
    this.contentsImage,
    this.time,
  );
}
