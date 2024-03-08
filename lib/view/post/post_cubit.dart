// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:like_comment/data_base_helper/data_base_helper.dart';
// import 'package:like_comment/view/post/post_state.dart';
//
// class PostCubit extends Cubit<PostState> {
//   PostCubit(super.initialState);
//
//   /// picke image
//   void imagePicker({context}) async {
//     XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       XFile file = XFile(pickedImage.path);
//       emit(state.copyWith(imageFile: file));
//     }
//     else {
//       print('xfile path --->>> something wrong');
//     }
//   }
//
//   /// post image
//   void uploadImage({file, context})  async{
//     String imageURL = await DataBaseHelper().uploadImage(file: file, context: context);
//     emit(state.copyWith(imageURL: imageURL));
//     print('----> $imageURL');
//   }
//
//   /// set true false based on  image upload or not
//   void waitingForImageUpload({waitingForImageUpload}){
//     emit(state.copyWith(waitingForImageUpload: waitingForImageUpload));
//   }
//
// }
//
// /*
//   updateImages(){
//     File images = DataBaseHelper().uploadImage();
//     emit(state.copyWith(images: images));
//   }
// */
//
//
//
