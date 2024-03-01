import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class HomeState extends Equatable {
  final bool like;
  final int totalLike;
  final String? argument;
  final List nameList;
  final bool isBottomSheet;

  const HomeState({
    this.like = false,
    this.totalLike = 0,
    this.argument = "",
    this.nameList = const [],
    this.isBottomSheet = false
  });

  @override
  List<Object?> get props => [
        like, totalLike, argument, nameList, isBottomSheet];

  HomeState copyWith({
    bool? like,
    Color? likeColor,
    int? totalLike,
    String? argument,
    List? nameList,
    bool? isBottomSheet
  }) {
    return HomeState(
      like: like ?? this.like,
      totalLike: totalLike ?? this.totalLike,
      argument: argument ?? this.argument,
      nameList: nameList ?? this.nameList,
      isBottomSheet: isBottomSheet ?? this.isBottomSheet
    );
  }
}
