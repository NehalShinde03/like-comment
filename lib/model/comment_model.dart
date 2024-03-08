class CommentModel{

  final String commentId;
  final String userId;
  final String postId;
  final String comment;

  CommentModel({
    this.commentId = "",
    this.userId = "",
    this.postId = "",
    this.comment=""
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
      commentId: json['commentId'],
      userId: json['userId'],
      postId: json['postId'],
    comment: json['comment']
  );


  Map<String, dynamic> toJson() => <String, dynamic>{
    'commentId':commentId,
    'userId':userId,
    'postId':postId,
    'comment':comment
  };

}