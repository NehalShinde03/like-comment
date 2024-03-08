import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:like_comment/common_attribute/common_value.dart';
import 'package:like_comment/common_widget/common_text.dart';
import 'package:like_comment/model/comment_model.dart';
import 'package:like_comment/model/like_model.dart';
import 'package:like_comment/model/new_post_model.dart';
import 'package:like_comment/model/registration_model.dart';
import 'package:like_comment/view/all_post/all_post_view.dart';
import 'package:motion_toast/motion_toast.dart';

// StreamController<List<String>> streamController = StreamController<List<String>>();
StreamController<List<String>> streamController = StreamController<List<String>>.broadcast();
// Stream stream = streamController.stream;

class DataBaseHelper {

  DataBaseHelper._();
  static final instance = DataBaseHelper._();

  final fireStoreRegisterUserInstance =
      FirebaseFirestore.instance.collection("RegisterUer");

  final fireStoreNewPostInstance =
      FirebaseFirestore.instance.collection("New Post");

  final fireStoreLikeInstance =
     FirebaseFirestore.instance.collection("Like");

  final fireStoreCommentInstance =
    FirebaseFirestore.instance.collection("Comment");

  List<dynamic> likeList = [];
  List<dynamic> commentList = [];
  // // List<dynamic> commentList = [];


  ///insert new user record in fireStore (collection name = 'RegisterUser')
  void insertNewUser({required RegistrationModel registrationModel}) async {
    await fireStoreRegisterUserInstance
        .add(registrationModel.toJson())
        .then((value) {
      value.set({'userId': value.id}, SetOptions(merge: true));
    });
  }

  /// compare sign-in user record with fireStore all user data
  void compareSignInRecordWithAllUser({
    required String userEmail, required String userPassword, context
  }) async {
    print('userName ==> $userEmail');
    print('password ==> $userPassword');
    fireStoreRegisterUserInstance
        .where('userEmail', isEqualTo: userEmail)
        .where('userPassword', isEqualTo: userPassword)
        .snapshots()
        .listen((snapshot) {
      if(snapshot.size > 0){
        snapshot.docs.forEach((element) {
          Navigator.pushNamed(context, AllPostView.routeName, arguments: element.get('userId'));
        });
      }else{
        MotionToast.error(
          toastDuration: const Duration(seconds: 3),
          title: const CommonText(
              text: 'Login',
              fontSize: Spacing.normal,
              fontWeight: TextWeight.bold),
          description: const CommonText(
            text: 'InValid Credential..!!!',
          ),
          barrierColor: Colors.black.withOpacity(0.3),
          dismissable: true,
          animationType: AnimationType.fromLeft,
          animationCurve: Curves.bounceOut,
          iconType: IconType.cupertino,
        ).show(context);
      }
    });
  }


  /// insert new post description, location
  void insertNewPost({required NewPostModel newPostModel}) async{
    print('desc ====> ${newPostModel.description}');
    print('loc ====> ${newPostModel.location}');
    await fireStoreNewPostInstance.add(newPostModel.toJson()).then((value){
      value.set({'postId' : value.id}, SetOptions(merge: true));
    });
  }


  /// upload image
  Future<XFile?> imagePicker() async{
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  /// upload image
  Future<String> uploadImages({required XFile uploadImagePath, context}) async{
    if(uploadImagePath.path.isNotEmpty){
        try{
          Reference reference = FirebaseStorage.instance.ref().child('Images/').child(uploadImagePath.name);
          var uploadImage = await reference.putFile(File(uploadImagePath.path));
          String downloadImageUrl = await uploadImage.ref.getDownloadURL();
          print('upload image type ===> ${uploadImage.runtimeType}');
          return downloadImageUrl;
        }catch(e){
          print('Exception ====> $e');
        }
    }
    return "";
  }

  ///delete post
  void deletePost({required String userId}){
    fireStoreNewPostInstance.doc(userId).delete();
  }

  /// get register user name
 Future<String> registerUserName({required String userId}) async{
    DocumentSnapshot<Map<String, dynamic>> userName = await fireStoreRegisterUserInstance.doc(userId).get();
    return userName.get('userName');
  }

  /// insert like data
  void insertLike({required LikeModal likeModal}) async{

    fireStoreLikeInstance.where('postId', isEqualTo: likeModal.postId)
      .snapshots().listen((snapshot) {
        if(snapshot.size > 0){
          fireStoreLikeInstance.add(likeModal.toJson()).then((value) async{
            value.set({'likeId' : value.id}, SetOptions(merge: true));
            await fireStoreNewPostInstance.doc(likeModal.postId).update({'like' : FieldValue.arrayUnion([value.id])});
          });
        }
        else{
          print('already like');
        }
    });

  }

  /// unlike post
  // void unLikePost({postId, userId, required LikeModal likeModal}) async{
  //   final docRef = fireStoreNewPostInstance.doc(postId);
  //   final docSnapshot = await docRef.get();
  //   final data = docSnapshot.data();
  //   final List<dynamic> list = List<dynamic>.from(data?['like']);
  //   print('doc data ====> ${list.length}');
  //   list.remove(userId);
  //   await docRef.update({'like':list});
  // }


  showNameOfPostLikeUser({required String postId}) async{
   likeList.clear();
    final newPostRef = fireStoreNewPostInstance.doc(postId);
    final getData = await newPostRef.get();
    List<dynamic> likePostList = getData.data()?['like'];
    for(int i=0; i<likePostList.length; i++){
      final userRef = fireStoreRegisterUserInstance.doc(likePostList[i]);
      final getData = await userRef.get();
      likeList.add(getData.data()?['userName']);
    }
    return likeList;
  }



  /// insert comment data
  // void insertComment({required CommentModel commentModel, required String comment}) async{
  //   await fireStoreLikeInstance.add(commentModel.toJson()).then((value) async{
  //     value.set({'commentId' : value.id}, SetOptions(merge: true));
  //     await fireStoreNewPostInstance.doc(commentModel.postId).update({'comment' : FieldValue.arrayUnion([comment])});
  //   });
  // }
  //
  // showNameOfPostCommentUser({required String postId}) async{
  //   commentList.clear();
  //   final newPostRef = fireStoreNewPostInstance.doc(postId);
  //   final getData = await newPostRef.get();
  //   List<dynamic> commentPostList = getData.data()?['comment'];
  //   for(int i=0; i<commentPostList.length; i++){
  //     final userRef = fireStoreRegisterUserInstance.doc(commentPostList[i]);
  //     final getData = await userRef.get();
  //     commentList.add(getData.data()?['userName']);
  //   }
  //   return commentList;
  // }


  void insertComment({required CommentModel commentModel}) async{
    await fireStoreCommentInstance.add(commentModel.toJson()).then((value) async{
      value.set({'commentId' : value.id}, SetOptions(merge: true));
      // await fireStoreNewPostInstance.doc(commentModel.postId).set({'comment' : FieldValue.arrayUnion([commentModel.commentId])});
      await fireStoreNewPostInstance.doc(commentModel.postId).update({'comment' : FieldValue.arrayUnion([value.id])});
    });
  }

 //
 //  Future<List<dynamic>> readAllComment({required String postId}) async {
 //    List<dynamic> commentList = [];
 //    commentList.clear();
 //    print('postId =====> $postId');
 //    fireStoreCommentInstance
 //        .where('postId', isEqualTo: postId)
 //        .snapshots()
 //        .listen((snapshot) {
 //        if(snapshot.size > 0){
 //          snapshot.docs.forEach((element) {
 //          commentList.add(element.get('comment'));
 //          print('inn ====> $commentList');
 //        });
 //        }else{
 //          commentList.add('No Comment Available...');
 //        }
 //    });
 //    print('comment list data ===> $commentList');
 //    return commentList;
 // }


  // if(snapshot.size > 0){
  // snapshot.docs.forEach((element) {
  // commentList.add(element.get('comment'));
  // print('inn ====> $commentList');
  // // Navigator.pushNamed(context, AllPostView.routeName, arguments: element.get('userId'));
  // });
  // }else{
  // commentList.add('No Comment Available...');
  // }

  Future<Stream<List<String>>> showNameOfPostCommentUser({required String postId}) async {
    final newPostRef = fireStoreNewPostInstance.doc(postId);
    final getData = await newPostRef.get();
    List<dynamic> commentPostList = getData.data()?['comment'];
    for(int i=0; i<commentPostList.length; i++){
        final commentRef = fireStoreCommentInstance.doc(commentPostList[i]);
        final getComment = await commentRef.get();
        print("======> $i ===> ${getComment.data()?['comment']}");
        streamController.sink.add([getComment.data()?['comment']]);
    }
    // streamController.close();
    print('length of stram ===> ${streamController.stream.runtimeType}');
    return streamController.stream;
  }
}

//
// Future<Stream<List<String>>> showNameOfPostCommentUser({required String postId}) async {
//   streamController ;
//   final newPostRef = fireStoreNewPostInstance.doc(postId);
//   final getData = await newPostRef.get();
//   List<dynamic> commentPostList = getData.data()?['comment'];
//   for(int i=0; i<commentPostList.length; i++){
//     final commentRef = fireStoreCommentInstance.doc(commentPostList[i]);
//     final getComment = await commentRef.get();
//     // commentList.add(getComment);
//     print("======> $i ===> ${getComment.data()?['comment']}");
//     streamController.sink.add([getComment.data()?['comment']]);
//   }
//   // streamController.close();
//   print('length of stram ===> ${streamController.stream.runtimeType}');
//   return streamController.stream;
// }



// Future<Stream<List<String>>> showNameOfPostCommentUser({required String postId}) async {
//   // commentList.clear();
//   // streamController.close();
//   final newPostRef = fireStoreNewPostInstance.doc(postId);
//   final getData = await newPostRef.get();
//   List<dynamic> commentPostList = getData.data()?['comment'];
//   for (int i = 0; i < commentPostList.length; i++) {
//     final commentRef = fireStoreCommentInstance.doc(commentPostList[i]);
//     final getCommentData = await commentRef.get();
//     streamController.sink.add(getCommentData.data()?['comment']);
//     print('controller runtype ===> ${streamController.stream.runtimeType}');
//   }
//   // streamController.close();
//   print('contrpller exit ======>');
//   return streamController.stream;
// }


/* showNameOfPostCommentUser({required String postId}) async{
    // List<dynamic> userNameOnComment = [];
    commentList.clear();
    final newPostRef = fireStoreNewPostInstance.doc(postId);
    final getData = await newPostRef.get();
    List<dynamic> commentPostList = getData.data()?['comment'];
    for(int i=0; i<commentPostList.length; i++){
      final commentRef = fireStoreCommentInstance.doc(commentPostList[i]);
      final getCommentData = await commentRef.get();
      commentList.add(getCommentData.data()?['comment']);
      // userNameOnComment.add(getCommentData.data()?['userId']);
    }
    // print('userNameList ====> $userNameOnComment');
    return commentList;
  }*/
