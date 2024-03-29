class PostsModel {
  String? postId;
  String? userId;
  String? userName;
  String? userAvatar;
  String? videoUrl;
  String? caption;
  String? datePublished;
  List? imageUrl;
  List? likes;
  List<dynamic>? comments;
  double? latitude;
  double? longitude;
  DateTime? datePublishedTime; 

  PostsModel(
      {this.postId,
      this.userId,
      this.userName,
      this.videoUrl,
      this.imageUrl,
      this.likes,
      this.comments,
      this.latitude,
      this.longitude,
      this.userAvatar,
      this.caption,
      this.datePublished,
      this.datePublishedTime,});

  PostsModel.fromJson(Map<String, dynamic> snap) {
    postId = snap['post_id'];
    userId = snap['user_id'];
    userName = snap['user_name'];
    videoUrl = snap['video_url'];
    imageUrl = snap['image_url'];
    likes = snap['likes'];
    comments = snap['comments'];
    latitude = snap['latitude'];
    longitude = snap['longitude'];
    caption = snap['caption'];
    userAvatar = snap['user_avatar'];
    datePublished = snap['date_published'];
    datePublishedTime = snap['date_published_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post_id'] = postId;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['video_url'] = videoUrl;
    data['image_url'] = imageUrl;
    data['likes'] = likes;
    data['comments'] = comments;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['user_avatar'] = userAvatar;
    data['caption'] = caption;
    data['date_published'] = datePublished;
    data['date_published_time'] =datePublishedTime;

    return data;
  }
}
