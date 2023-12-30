import 'package:cloud_firestore/cloud_firestore.dart';

class UserContentsModel {
  final String id;
  final String contentsSubject;
  final String contents;
  final String contentsImage;
  final Timestamp time;

  UserContentsModel(
    this.id,
    this.contentsSubject,
    this.contents,
    this.contentsImage,
    this.time,
  );
}