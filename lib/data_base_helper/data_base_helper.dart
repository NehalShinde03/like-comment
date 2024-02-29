import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:like_comment/model/post_model.dart';
import 'package:like_comment/model/registration_model.dart';
import 'package:like_comment/view/home/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataBaseHelper {

  final _fireStoreRegistrationInstance =
  FirebaseFirestore.instance.collection('Registration');

  final _fireStorePostInstance =
  FirebaseFirestore.instance.collection('Post');


  // String downloadImageURL="";

  /// ************ registration ********************

  /// insert registration data
  void insertRegistrationData(
      {required RegistrationModel registrationModel}) async {
    DocumentReference<Map<String, dynamic>> docRef = await _fireStoreRegistrationInstance.add(registrationModel.toJson());
    print('dcoument id ====> $docRef');
    docRef.set({'registrationId': docRef.id}, SetOptions(merge: true));

    ///store user id
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('registrationKey', docRef.id);

  }

  /// verifying credential at login time
  void compareCredentialData(
      {required String email, required String password, context}) async {
    _fireStoreRegistrationInstance
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .snapshots().listen(
          (data) =>
          data.docs.forEach((element) {
            if (email == element.get('email') &&
                password == element.get('password')) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeView()));
            } else {
              print('===>>>>>> creadential wrong');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Wrong Credential Please Check')),
              );
            }
          },
          ),
    );
  }



  ///****************** images ******************////
  /// picked image
  // Future<XFile?> imagePicker() async{
  //   file = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   return file;
  // }

  ///upload image
  Future<String> uploadImage({required XFile file, context}) async {
    if(file.path.isNotEmpty){
      try {
        Reference reference = FirebaseStorage.instance.ref().child('Images/').child(file.name);
        var uploadImage = await reference.putFile(File(file.path)).whenComplete(() => null);
        String downloadImageURL = await uploadImage.ref.getDownloadURL().whenComplete(() => null);
        return downloadImageURL;
      } catch (e) {
        throw Exception("Image Exception =====> $e");
      }

    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Image is Not Selected')));
    }
    return "";

  }

  ///****************** post  ******************////
  void insertPostData({required PostModel postModel}) async{
    DocumentReference<Map<String, dynamic>> docRef = await _fireStorePostInstance.add(postModel.toJson());
    docRef.set({'postId':docRef.id}, SetOptions(merge: true));
  }

  void deletePost({id}){
    _fireStorePostInstance.doc(id).delete();
  }


}











// void readData({required String userName, context}) async {
//   await _firebaseFireStoreInstance.snapshots().listen((data) =>
//       data.docs.forEach((element) {
//         if (userName == element.get('email')) {
//           Navigator.pushReplacement(
//               context, MaterialPageRoute(builder: (_) => RegistrationView()));
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong Credential')),);
//         }
//       }));
// }

// final d =  _firebaseFireStoreInstance.where("name", isEqualTo:'nehal').snapshots().listen((data) => data.docs.forEach((element) => print(element['email'])));
//
// _firebaseFireStoreInstance.where("name", isEqualTo: "karn").snapshots().listen((data) => data.docs.forEach((element) {
// print("data ------>>>>> ${element['email']}");
// }));