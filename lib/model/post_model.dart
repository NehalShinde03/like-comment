import 'package:like_comment/model/comment_model.dart';
import 'package:like_comment/model/like_model.dart';

class PostModel {
  final String? postId;
  final String? registrationId;
  final String? imageUrl;
  final String? description;
  final String? location;
  final List<String> like;
  final String comment;

  PostModel({
    this.postId,
    this.registrationId,
    this.imageUrl,
    this.description,
    this.location,
    this.like = const [] ,
    this.comment = ""
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
      postId: json['postId'],
      registrationId: json['registrationId'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      location: json['location'],
      like: json['like'],
      comment: json['comment']
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'postId': postId,
        'registrationId': registrationId,
        'imageUrl': imageUrl,
        'description': description,
        'location': location,
        'like':like,
        'comment':comment
      };
}
