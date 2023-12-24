import 'package:cloud_firestore/cloud_firestore.dart';

class UserContents {
  final String id;
  final String contents;
  final String contentsImage;
  final Timestamp time;

  UserContents(
    this.id,
    this.contents,
    this.contentsImage,
    this.time,
  );
}
