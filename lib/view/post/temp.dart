// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:like_comment/common_attribute/common_value.dart';
// import 'package:like_comment/common_widget/common_material_button.dart';
// import 'package:like_comment/common_widget/common_text.dart';
// import 'package:like_comment/common_widget/common_textfield.dart';
// import 'package:like_comment/data_base_helper/data_base_helper.dart';
// import 'package:like_comment/model/post_model.dart';
// import 'package:like_comment/view/post/post_cubit.dart';
// import 'package:like_comment/view/post/post_state.dart';
//
// class PostView extends StatefulWidget {
//   const PostView({super.key});
//
//   static const String routeName = "/post_view";
//
//   static Widget builder(BuildContext context) {
//     return BlocProvider(
//       create: (context) => PostCubit(PostState(
//         imageFile: XFile(""),
//         descriptionController: TextEditingController(),
//         locationController: TextEditingController(),
//       )),
//       child: const PostView(),
//     );
//   }
//
//   @override
//   State<PostView> createState() => _PostViewState();
// }
//
// class _PostViewState extends State<PostView> {
//
//   final dbInstance = DataBaseHelper();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PostCubit, PostState>(
//       builder: (context, state) {
//         return Scaffold(
//           body: Center(
//               child: SingleChildScrollView(
//                   child: state.waitingForImageUpload == false
//                       ? Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: PaddingValue.medium,
//                         child: GestureDetector(
//                           onTap: () {
//                             context.read<PostCubit>().imagePicker();
//                           },
//                           child: Container(
//                             width: MediaQuery.of(context).size.width / 1.5,
//                             height: MediaQuery.of(context).size.height / 3,
//                             // padding: PaddingValue.xxLarge,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(color: Colors.grey),
//                                 color: Colors.white),
//                             child: SizedBox(
//                                 child: state.imageFile.path.isEmpty
//                                     ? const Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.image,
//                                       size: 150,
//                                       color: Colors.grey,
//                                     ),
//                                     CommonText(
//                                       text: 'Tap to Select Image',
//                                       fontWeight: FontWeight.bold,
//                                       textColor: Colors.grey,
//                                       fontSize: 20,
//                                     )
//                                   ],
//                                 )
//                                     : Card(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: Image.file(
//                                       File(state.imageFile.path),
//                                       fit: BoxFit.fill),
//                                 )),
//                           ),
//                         ),
//                       ),
//
//                       const Gap(20),
//                       Padding(
//                         padding:
//                         const EdgeInsetsDirectional.symmetric(horizontal: 15),
//                         child: CommonTextField(
//                           controller: state.descriptionController,
//                           hintText: 'Enter Description',
//                           prefixIcon: Icons.description,
//                           iconColor: Colors.blue,
//                         ),
//                       ),
//
//                       const Gap(6),
//                       Padding(
//                         padding:
//                         const EdgeInsetsDirectional.symmetric(horizontal: 15),
//                         child: CommonTextField(
//                           controller: state.locationController,
//                           hintText: 'Enter location',
//                           prefixIcon: Icons.location_on,
//                           iconColor: Colors.red,
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Padding(
//                             padding: PaddingValue.large,
//                             child: Center(
//                               child: CommonMaterialButton(
//                                 text: 'Post',
//                                 onPressed: () {
//                                   print(state.imageFile.runtimeType);
//
//                                   ///upload image
//                                   context.read<PostCubit>().uploadImage(file: state.imageFile, context: context);
//                                   context.read<PostCubit>().waitingForImageUpload(waitingForImageUpload: true);
//
//                                   // dbInstance.uploadImage(
//                                   //     file: state.imageFile, context: context);
//
//                                   ///insert post data
//                                   dbInstance.insertPostData(postModel: PostModel(
//                                       url: state.imageURL,
//                                       description: state.descriptionController.text,
//                                       location: state.locationController.text
//                                   ));
//
//                                 },
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: PaddingValue.large,
//                             child: Center(
//                               child: CommonMaterialButton(
//                                 text: 'Cancel',
//                                 onPressed: () {},
//                               ),
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                       :  Future.delayed(Duration(seconds: 5), (){
//             return Center(child: CircularProgressIndicator());
//           }),
//         ),
//         ),
//         );
//       },
//     );
//   }
// }
