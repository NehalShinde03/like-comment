import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_comment/data_base_helper/data_base_helper.dart';
import 'package:like_comment/model/like_model.dart';
import 'package:like_comment/view/all_post/all_post_state.dart';

class AllPostCubit extends Cubit<AllPostState>{
  AllPostCubit(super.initialState);

  void getCurrentUserName({registerUserId}) async{
    String registerUserName = await DataBaseHelper.instance.registerUserName(userId: registerUserId);
    emit(state.copyWith(registerUserName: registerUserName));
  }

  void isPostLikes({required LikeModal likeModel, bool? isLike}) async{
  //  if(isLike == true){
    print('cubit U & P id ===> ${likeModel.postId} - ${likeModel.userId}');
      DataBaseHelper.instance.insertLike(likeModal: likeModel);
    // }else{
    //   DataBaseHelper.instance.unLikePost(likeModal: LikeModal(
    //     userId: likeModel.userId,
    //     postId: likeModel.postId
    //   ));
    // // }
   // emit(state.copyWith(isLike: isLike));
  }


  void likeListLength({likeListLength}) async{
    emit(state.copyWith(likeListLength: likeListLength));
  }


  void showNameOfPostLikeUsers({required String postId}) async{
    List<dynamic> likePostList = await DataBaseHelper.instance.showNameOfPostLikeUser(postId: postId);
    emit(state.copyWith(
        likePostList: likePostList,
    ));
    print('like list data ====> ${state.likePostList}');
  }

  // void showNameOfPostCommentUsers({required String postId}) async{
  //   List<dynamic> commentList = await DataBaseHelper.instance.showNameOfPostCommentUser(postId: postId);
  //   emit(state.copyWith(commentList: commentList));
  // }

  // showNameOfPostCommentUsers({required String postId}) async{
  //   List<dynamic> commentLists = await DataBaseHelper.instance.showNameOfPostCommentUser(postId: postId);
  //   emit(state.copyWith(commentList: commentLists));
  //   print('cubit comment list ===> ${state.commentList}');
  //  }


  void isEnterOnce({required bool isEnterOnce}){
    emit(state.copyWith(isEnterOnce: isEnterOnce));
  }

}