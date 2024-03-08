import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class AllPostState extends Equatable {
  final String registerUserId;
  final String registerUserName;
  final bool isLike;
  final int likeListLength;
  final List likePostList;
  final bool isEnterOnce;

  final TextEditingController commentController;
  final List commentList;

  const AllPostState(
      {this.registerUserId = "",
      this.registerUserName = "",
      this.isLike = false,
      this.likeListLength = 0,
      this.likePostList = const [],
      required this.commentController,
      this.commentList = const [],
      this.isEnterOnce = false
      ,});

  @override
  List<Object?> get props => [
        registerUserId,
        registerUserName,
        isLike,
        likeListLength,
        likePostList,
       commentController,
        commentList,
        isEnterOnce
      ];

  AllPostState copyWith({
    String? registerUserId,
    String? registerUserName,
    bool? isLike,
    int? likeListLength,
    List? likePostList,
    TextEditingController? commentController,
    List? commentList,
    bool? isEnterOnce
  }) {
    return AllPostState(
        registerUserId: registerUserId ?? this.registerUserId,
        registerUserName: registerUserName ?? this.registerUserName,
        isLike: isLike ?? this.isLike,
        likeListLength: likeListLength ?? this.likeListLength,
        likePostList: likePostList ?? this.likePostList,
        commentController: commentController ?? this.commentController,
        commentList: commentList ?? this.commentList,
        isEnterOnce: isEnterOnce ?? this.isEnterOnce
    ,);
  }
}
