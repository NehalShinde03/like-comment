import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:like_comment/common_attribute/common_value.dart';
import 'package:like_comment/common_widget/common_text.dart';
import 'package:like_comment/data_base_helper/data_base_helper.dart';
import 'package:like_comment/view/home/home_cubit.dart';
import 'package:like_comment/view/home/home_state.dart';
import 'package:like_comment/view/post/post_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const String routeName = "/home_view";

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(const HomeState()),
      child: const HomeView(),
    );
  }

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeCubit get homeCubit => context.read<HomeCubit>();
  DataBaseHelper get dataBaseHelper => DataBaseHelper();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          title: const CommonText(
            text: 'All Post',
            fontSize: TextSize.largeHHeading,
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, PostView.routeName),
          backgroundColor: Colors.teal,
          child: const Icon(Icons.rocket_launch,
              color: Colors.white, size: Spacing.xxLarge),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('Post').snapshots(),
                builder: (context, snapshot) {
                  return ListView.separated(
                    // reverse: true,
                    itemCount: snapshot.data?.docs.length ?? 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: PaddingValue.small,
                        child: Card(
                          color: Colors.white,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                ///image icon
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(start: 11, top: 8),
                                          child: SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child: Image.asset('assets/images/dpPic.png'),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [

                                            Padding(
                                              padding: EdgeInsetsDirectional.only(start: 5, top: 8),
                                              child: CommonText(
                                                text:
                                                'Nehal Shinde',
                                                textColor: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: TextSize.appBarSubTitle * 1,
                                              ),
                                            ),

                                            CommonText(
                                                text:
                                                snapshot.data?.docs[index]['location'],
                                                textColor: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: TextSize.appBarSubTitle * 1)

                                          ],
                                        ),
                                      ],
                                    ),

                                    /// for deleteion
                                    PopupMenuButton(
                                        itemBuilder: (context) => [
                                          const PopupMenuItem(
                                              value: 1,
                                              child: CommonText(text: 'Delete',)
                                          ),
                                        ],
                                      onSelected: (value){
                                          if(value==1){
                                            dataBaseHelper.deletePost(id: snapshot.data?.docs[index].id);
                                          }
                                      },
                                    ),

                                  ],
                                ),

                                ///images
                                Center(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1,
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    margin:
                                        const EdgeInsetsDirectional.symmetric(
                                            vertical: Spacing.medium,
                                            horizontal: RadiusValue.medium),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          snapshot.data?.docs[index]
                                              .get('imageUrl'),
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                ),

                                ///like and comment button
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                          horizontal: Spacing.medium),
                                  child: Row(
                                    children: [
                                      ///like button
                                      IconButton(
                                          onPressed: () {
                                            homeCubit.likeUnlike(like: !(state.like));
                                            state.like
                                            ? homeCubit.totalLike(like: (state.totalLike!-1))
                                            : homeCubit.totalLike(like: (state.totalLike!+1));
                                          },
                                          icon: Icon(
                                            state.like ? Icons.favorite : Icons.favorite_border,
                                            color: state.like
                                                ? Colors.red
                                                : Colors.black,
                                            size: Spacing.xxLarge,
                                          ),),

                                      ///comment button
                                      IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .only(
                                                                    top: Spacing
                                                                        .medium,
                                                                    start: Spacing
                                                                        .medium),
                                                        child: CommonText(
                                                            text: '47 comments',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                Spacing.normal),
                                                      ),
                                                      const Divider(
                                                        color: Colors.grey,
                                                        thickness: 1.5,
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15,),),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: const Icon(
                                              Icons.comment_rounded,
                                              size: Spacing.xxLarge)),
                                    ],
                                  ),
                                ),

                                /// show number of like
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: Spacing.normal,
                                      bottom: Spacing.medium,),
                                  child: CommonText(
                                      text: '${state.totalLike} likes',
                                      textColor: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: TextSize.appBarSubTitle),
                                ),

                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: Spacing.normal,
                                    bottom: Spacing.medium,),
                                  child: CommonText(
                                      text: snapshot.data?.docs[index]
                                          ['description'],
                                      textColor: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: TextSize.appBarSubTitle),
                                ),



                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Gap(3);
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}
