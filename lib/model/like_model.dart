class LikeModal{

  final String likeId;
  final String userId;
  final String postId;

  LikeModal({
    this.likeId = "",
    this.userId = "",
    this.postId = "",
  });

  factory LikeModal.fromJson(Map<String, dynamic> json) => LikeModal(
    likeId: json['likeId'],
    userId: json['userId'],
    postId: json['postId']
  );


  Map<String, dynamic> toJson() => <String, dynamic>{
    'likeId':likeId,
    'userId':userId,
    'postId':postId
  };

}