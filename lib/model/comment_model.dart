class CommentModel{
  final String? postId;
  final String? registrationId;

  const CommentModel({this.postId = "", this.registrationId = ""});

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
      postId: json['postId'],
      registrationId: json['registrationId']
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    "postId":postId,
    "registrationId":registrationId
  };
}