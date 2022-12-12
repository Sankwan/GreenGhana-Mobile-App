import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String? username;
  String? uid;
  String? id;
  List? likes;
  int? commentsCount;
  int? shareCount;
  String? songName;
  String? caption;
  String? videoUrl;
  String? thumbnail;
  String? profilePic;

  Video(
      {required this.username,
      required this.uid,
      required this.thumbnail,
      required this.caption,
      required this.commentsCount,
      required this.id,
      required this.likes,
      required this.profilePic,
      required this.shareCount,
      required this.songName,
      required this.videoUrl});

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "profilePic": profilePic,
        "id": id,
        "likes": likes,
        "commentsCount": commentsCount,
        "shareCount": shareCount,
        "songName": songName,
        "caption": caption,
        "videoUrl": videoUrl,
        "thumbnail": thumbnail
      };

  Video.fromSnap(Map<String, dynamic> data) {
    username = data["username"];
    uid = data["uid"];
    id = data["id"];
    likes = data["likes"];
    commentsCount = data['commentsCount'];
    caption = data["caption"];
    shareCount = data["shareCount"];
    songName = data["songName"];
    thumbnail = data["thumbnail"];
    profilePic = data["profilePic"];
    videoUrl = data["videoUrl"];
  }
}

