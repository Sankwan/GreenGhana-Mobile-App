class PostsModel {
  String? postId;
  String? userId;
  String? userName;
  String? userAvatar;
  String? videoUrl;
  String? caption;
  String? datePublished;
  List? imageUrl;
  List<dynamic>? likes;
  double? latitude;
  double? longitude;

  PostsModel(
      {this.postId,
      this.userId,
      this.userName,
      this.videoUrl,
      this.imageUrl,
      this.likes,
      this.latitude,
      this.longitude,
      this.userAvatar,
      this.caption,
      this.datePublished});

  PostsModel.fromJson(Map<String, dynamic> snap) {
    postId = snap['post_id'];
    userId = snap['user_id'];
    userName = snap['user_name'];
    videoUrl = snap['video_url'];
    imageUrl = snap['image_url'];
    likes = snap['likes'];
    latitude = snap['latitude'];
    longitude = snap['longitude'];
    caption = snap['caption'];
    userAvatar = snap['user_avatar'];
    datePublished = snap['date_published'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post_id'] = postId;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['video_url'] = videoUrl;
    data['image_url'] = imageUrl;
    data['likes'] = likes;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['user_avatar'] = userAvatar;
    data['caption'] = caption;
    data['date_published'] = datePublished;

    return data;
  }
}
