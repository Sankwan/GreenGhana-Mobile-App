import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId;
  String? userPhoneNumber;
  String? avatar;
  String? userName;
  num? totalPosts;
  num? totalLikes;
  num? totalRequests;

  UserModel(
      {this.userId,
      this.userPhoneNumber,
      this.userName,
      this.avatar,
      this.totalPosts,
      this.totalLikes,
      this.totalRequests});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user_id': userId,
      'user_phoneNumber': userPhoneNumber,
      'user_name': userName,
      'avatar': avatar,
      'total_posts': totalPosts,
      'total_likes': totalLikes,
      'total_request': totalRequests
    };
  }
  
  static UserModel fromJson(DocumentSnapshot? snap) {
    Map snapshot = snap!.data() as Map<String, dynamic>;
    return UserModel(
        userId: snapshot['user_id'],
        userPhoneNumber: snapshot['user_phoneNumber'],
        userName: snapshot['user_name'],
        avatar: snapshot['avatar'],
        totalPosts: snapshot['total_posts'],
        totalLikes: snapshot['total_likes'],
        totalRequests: snapshot['total_request']);
  }
}
