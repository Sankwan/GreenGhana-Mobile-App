import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId;
  String? userPhoneNumber;
  String? avatar;
  String? userName;

  UserModel({this.userId, this.userPhoneNumber, this.userName, this.avatar});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user_id': userId,
      'user_phoneNumber': userPhoneNumber,
      'user_name': userName,
      'avatar': avatar
    };
  }

  static UserModel fromJson(DocumentSnapshot? snap){
    Map snapshot = snap!.data() as Map<String, dynamic>;
    return UserModel(
      userId: snapshot['user_id'],
      userPhoneNumber: snapshot['user_phoneNumber'],
      userName: snapshot['user_name'],
      avatar: snapshot['avatar']
    );
  }

}
