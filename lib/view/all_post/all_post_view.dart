import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:like_comment/common_attribute/common_value.dart';
import 'package:like_comment/common_widget/common_text.dart';
import 'package:like_comment/data_base_helper/data_base_helper.dart';
import 'package:like_comment/model/comment_model.dart';
import 'package:like_comment/model/like_model.dart';
import 'package:like_comment/view/all_post/all_post_cubit.dart';
import 'package:like_comment/view/all_post/all_post_state.dart';
import 'package:like_comment/view/new_post/new_post_view.dart';

class AllPostView extends StatefulWidget {
  const AllPostView({super.key});

  static const String routeName = '/all_post_view';

  static Widget builder(BuildContext context) {
    final registerUserId =
        ModalRoute.of(context)?.settings.arguments as String?;
    return BlocProvider(
      create: (context) =>
          AllPostCubit(AllPostState(
              registerUserId: registerUserId ?? "",
              commentController: TextEditingController()
          )),
      child: const AllPostView(),
    );
  }

  @override
  State<AllPostView> createState() => _AllPostViewState();
}

class _AllPostViewState extends State<AllPostView> {

  AllPostCubit get allPostCubit => context.read<AllPostCubit>();
  List<dynamic> likeList = [];

  @override
  void dispose() {
    //streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllPostCubit, AllPostState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title:
                  const CommonText(text: 'All Post', fontSize: Spacing.xLarge),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {

                Navigator.pushNamed(context, NewPostView.routeName,
                    arguments: state.registerUserId);
              },
              child: const Icon(Icons.rocket_launch),
            ),
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("New Post")
                    .snapshots(),
                builder: (context, snapshot) {
                  return ListView.separated(
                    itemCount: snapshot.data?.docs.length ?? 0,
                    itemBuilder: (context, index) {

                      /// return the length of like list
                      //likeList = snapshot.data?.docs[index]['like'];

                      // if(state.isEnterOnce == false){
                      //   allPostCubit.isEnterOnce(isEnterOnce: true);
                      //   allPostCubit.showNameOfPostCommentUsers(postId: snapshot.data?.docs[index]['postId']);
                      // }

                      allPostCubit.getCurrentUserName(registerUserId: state.registerUserId);

                      return Padding(
                        padding: PaddingValue.small,
                        child: Card(
                          elevation: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// name and delete
                              Padding(
                                padding: const EdgeInsetsDirectional.symmetric(
                                    horizontal: Spacing.xMedium,
                                    vertical: Spacing.small),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor: Colors.black,
                                          radius: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .symmetric(
                                                      horizontal:
                                                          Spacing.small),
                                              child: CommonText(
                                                text: state.registerUserName,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .symmetric(
                                                      horizontal:
                                                          Spacing.small),
                                              child: CommonText(
                                                  text: state.registerUserId),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    PopupMenuButton(
                                      icon: const Icon(
                                        Icons.more_horiz_outlined,
                                      ),
                                      itemBuilder: (context) => [
                                        const PopupMenuItem(
                                            child: CommonText(text: 'Delete'))
                                      ],
                                      onSelected: (value) {
                                        if (value == 1) {
                                          DataBaseHelper.instance.deletePost(
                                              userId: state.registerUserId);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              /// show picked photo
                              Center(
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 1,
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  margin: const EdgeInsetsDirectional.symmetric(
                                      vertical: Spacing.medium,
                                      horizontal: RadiusValue.medium),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      snapshot.data?.docs[index]
                                          .get('imageUrl'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),

                              /// like, comment, desc
                              Padding(
                                padding: const EdgeInsetsDirectional.symmetric(
                                    horizontal: Spacing.small),
                                child: Row(
                                  children: [

                                    /// like
                                    IconButton(
                                      onPressed: () {

                                        DataBaseHelper.instance.insertLike(likeModal: LikeModal(
                                          postId: snapshot.data?.docs[index]['postId'],
                                          userId: snapshot.data?.docs[index]['userId'],
                                        ));

                                        // allPostCubit.isPostLikes(
                                        //     isLike: !(state.isLike),
                                        //     likeModel: LikeModal(
                                        //       postId: snapshot.data?.docs[index]
                                        //           ['postId'],
                                        //       userId: state.registerUserId,
                                        //     ),
                                        // );



                                        // allPostCubit.isPostLikes(
                                        //   //
                                        //   postId: snapshot.data?.docs[index]['postId'],
                                        //   userId: snapshot.data?.docs[index]['userId'],
                                        // );
                                        // DataBaseHelper.instance.insertLike(likeModal: LikeModal(
                                        //   userId: snapshot.data?.docs[index]['userId'],
                                        //   postId: snapshot.data?.docs[index]['postId'],
                                        // ));
                                      },
                                      icon: Icon(
                                        state.isLike
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.red,
                                        size: Spacing.xxLarge,
                                      ),
                                    ),

                                    /// comment
                                    IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {

                                            return Column(
                                              // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                              children: [
                                                const CommonText(
                                                  text: 'Comments',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      TextSize.appBarTitle,
                                                ),


                                                Padding(
                                                  padding: PaddingValue.small,
                                                  child: TextField(
                                                    controller: state.commentController,
                                                    decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(20)
                                                      ),
                                                      label: const CommonText(text: 'Type Comment...'),
                                                      suffixIcon: GestureDetector(
                                                        onTap: (){
                                                          DataBaseHelper.instance.insertComment(
                                                              commentModel: CommentModel(
                                                                comment: state.commentController.text,
                                                                postId: snapshot.data?.docs[index]['postId'],
                                                                userId: snapshot.data?.docs[index]['userId'],
                                                          ),);
                                                          state.commentController.text = "";
                                                        },
                                                        child: const Icon(Icons.telegram),
                                                      )
                                                    ),
                                                  ),
                                                ),


                                               FutureBuilder<Stream<List<String>>>(
                                                  future: DataBaseHelper.instance.showNameOfPostCommentUser(postId: snapshot.data?.docs[index]['postId']),
                                                  builder: (context, futureSnapshot) {
                                                    if(futureSnapshot.connectionState == ConnectionState.waiting){
                                                      return const Center(child: CircularProgressIndicator(),);
                                                    }
                                                    else if(snapshot.hasError){
                                                      return Center(child: CommonText(text: 'error ===> ${snapshot.error}',textColor: Colors.red),);
                                                    }
                                                    else if(!snapshot.hasData){
                                                      return const Center(child: CommonText(text: 'no data',textColor: Colors.red),);
                                                    }
                                                    else {
                                                      print('future all data ====> ${futureSnapshot.data?.single}');
                                                      return StreamBuilder(
                                                          stream: (futureSnapshot.data),
                                                          builder: (context,streamSnapShot) {
                                                            print('stream data ===> ${futureSnapshot.hasData}');
                                                            if(futureSnapshot.connectionState == ConnectionState.waiting){
                                                              return const Center(child: CircularProgressIndicator(),);
                                                            }
                                                            else if(snapshot.hasError){
                                                              return Center(child: CommonText(text: 'error ===> ${snapshot.error}',textColor: Colors.red),);
                                                            }
                                                            else if(!snapshot.hasData){
                                                              return const Center(child: CommonText(text: 'no data',textColor: Colors.red),);
                                                            }
                                                            else{
                                                              return Flexible(
                                                                child: ListView.separated(
                                                                  itemCount: streamSnapShot.data?.length ?? 0,
                                                                  itemBuilder: (context,index) {
                                                                    return Row(
                                                                      children: [
                                                                        const Padding(
                                                                          padding:
                                                                          EdgeInsetsDirectional.symmetric(horizontal: 5,vertical: 2),
                                                                          child: CircleAvatar(
                                                                            backgroundColor: Colors
                                                                                .black,
                                                                            radius: 15,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                          const EdgeInsetsDirectional.symmetric(
                                                                              horizontal: Spacing.small),
                                                                          child: CommonText(
                                                                            text: streamSnapShot.data?[index] ?? "",
                                                                            textColor: Colors.black,
                                                                            fontWeight:FontWeight.bold,
                                                                            fontSize: TextSize.appBarSubTitle,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                  separatorBuilder:
                                                                      (context,index) {
                                                                    return const Gap(
                                                                        Spacing.xSmall);
                                                                  },
                                                                ),
                                                              );

                                                            }
                                                          }
                                                      );
                                                    }
                                                  }
                                                )

                                                // Flexible(
                                                //   child: ListView.separated(
                                                //     itemCount: state.commentList.length,
                                                //     itemBuilder: (context,index) {
                                                //       print('runtype of commentList ====> ${state.commentList.runtimeType}');
                                                //       return Row(
                                                //         children: [
                                                //           const Padding(
                                                //             padding:
                                                //             EdgeInsetsDirectional.symmetric(horizontal: 5,vertical: 2),
                                                //             child: CircleAvatar(
                                                //               backgroundColor: Colors.black,
                                                //               radius: 15,
                                                //             ),
                                                //           ),
                                                //           Padding(
                                                //             padding:
                                                //             const EdgeInsetsDirectional.symmetric(
                                                //                 horizontal: Spacing.small),
                                                //             child: CommonText(
                                                //               text: state.commentList[index],
                                                //               textColor: Colors.black,
                                                //               fontWeight:FontWeight.bold,
                                                //               fontSize: TextSize.appBarSubTitle,
                                                //             ),
                                                //           ),
                                                //         ],
                                                //       );
                                                //     },
                                                //     separatorBuilder:
                                                //         (context,index) {
                                                //       return const Gap(
                                                //           Spacing.xSmall);
                                                //     },
                                                //   ),
                                                // )

                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.comment_outlined,
                                        color: Colors.black,
                                        size: Spacing.xLarge,
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              ///total number od likes
                              GestureDetector(
                                onTap: () {
                                  allPostCubit.showNameOfPostLikeUsers(postId: snapshot.data?.docs[index]['postId']);
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Gap(Spacing.small),
                                          CommonText(
                                            text: '${likeList.length} Likes',
                                            fontWeight: FontWeight.bold,
                                            fontSize: TextSize.appBarTitle,
                                          ),
                                          Flexible(
                                            child: ListView.separated(
                                              itemCount:
                                                  state.likePostList.length,
                                              itemBuilder: (context, index) {
                                                print(
                                                    'list data ====> ${state.likePostList[index]}');
                                                return Row(
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsetsDirectional.symmetric(horizontal: 5,vertical: 2),
                                                      child: CircleAvatar(
                                                        backgroundColor:Colors.black,
                                                        radius: 15,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional.symmetric(horizontal:Spacing.small),
                                                      child: CommonText(
                                                        text:
                                                            state.likePostList[index] ?? ".",
                                                        textColor: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: TextSize
                                                            .appBarSubTitle,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                return const Gap(
                                                    Spacing.xSmall);
                                              },
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: Spacing.large,
                                      bottom: Spacing.xSmall),
                                  child: CommonText(
                                    text: '${likeList.length} Likes',
                                    textColor: Colors.grey,
                                  ),
                                ),
                              ),

                              /// description
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: Spacing.large,
                                    bottom: Spacing.medium),
                                child: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Gap(Spacing.small),
                                            CommonText(
                                              text: '${likeList.length} Likes',
                                              fontWeight: FontWeight.bold,
                                              fontSize: TextSize.appBarTitle,
                                            ),
                                            Flexible(
                                              child: ListView.separated(
                                                itemCount:
                                                    state.likePostList.length,
                                                itemBuilder: (context, index) {
                                                  print(
                                                      'list data ====> ${state.likePostList[index]}');
                                                  return Row(
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsetsDirectional.symmetric(
                                                                    horizontal:5,
                                                                    vertical:2,
                                                            ),
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.black,
                                                          radius: 15,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.symmetric(
                                                                horizontal:Spacing.small),
                                                        child: CommonText(
                                                          text:
                                                              state.likePostList[index] ??".",
                                                          textColor:
                                                              Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: TextSize
                                                              .appBarSubTitle,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                  return const Gap(
                                                      Spacing.xSmall);
                                                },
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const CommonText(
                                    text: 'Mustange Gt 5700',
                                    textColor: Colors.grey,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Gap(Spacing.medium);
                    },
                  );
                }));
      },
    );
  }
}
