import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String? username;
  String comment;
  final datePub;
  List? likes;
  String? profilePic;
  String user_id;
  String? id;
  Timestamp? createdAt;

  Comment({
    this.username,
    required this.comment,
    this.datePub,
    this.likes,
    this.profilePic,
    required this.user_id,
    this.id,
    this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'comment': comment,
        'datePub': datePub,
        'likes': likes,
        'profilePic': profilePic,
        'user_id': user_id,
        'id': id,
        'createdAt': createdAt
      };

  static Comment fromSnap(Map<String, dynamic> snapshot) {
    // var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
      id: snapshot['id'],
      username: snapshot['username'],
      comment: snapshot['comment'],
      datePub: snapshot['datePub'],
      likes: snapshot['likes'],
      profilePic: snapshot['profilePic'],
      user_id: snapshot['user_id'],
      createdAt: snapshot['createdAt'],
    );
  }
}
