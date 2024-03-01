class LikeModel {
  final String? likeId;
  final String? postId;
  final String? registrationId;

  const LikeModel({
    this.likeId,
    this.postId = "",
    this.registrationId = "",
  });

  factory LikeModel.fromJson(Map<String, dynamic> json) => LikeModel(
      likeId: json['likeId'],
      postId: json['postId'],
      registrationId: json['registrationId'],
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "likeId": likeId,
        "postId": postId,
        "registrationId": registrationId,
      };
}
