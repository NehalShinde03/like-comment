import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class HomeState extends Equatable {
  final bool like;
  final int? totalLike;

  const HomeState({
    this.like = false,
    this.totalLike = 0,
  });

  @override
  List<Object?> get props => [
        like, totalLike];

  HomeState copyWith({
    bool? like,
    Color? likeColor,
    int? totalLike
  }) {
    return HomeState(
      like: like ?? this.like,
      totalLike: totalLike ?? this.totalLike
    );
  }
}
