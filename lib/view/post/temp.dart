// /*FutureBuilder(
//                                 future: DataBaseHelper().readLike(postId: snapshot.data?.docs[index]["postId"]),
//                                 builder: (context, data) {
//                                   return GestureDetector(
//                                     onTap: () {
//                                       // context.read<HomeCubit>().nameList(snapshot.data?.docs[index]["postId"]);
//                                       // final data  = dataBaseHelper.showLike(postId: snapshot.data?.docs[index]["postId"]);
//                                       print('dtass ==> ${state.nameList}');
//                                       showModalBottomSheet(
//                                           context: context,
//                                           builder: (context) {
//                                             return Column(
//                                               crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                               children: [
//                                                 const Padding(
//                                                   padding:EdgeInsetsDirectional.only(
//                                                       top: Spacing.medium,
//                                                       start: Spacing.medium),
//                                                   child: CommonText(
//                                                       text: '47 comments',
//                                                       fontWeight:FontWeight.bold,
//                                                       fontSize:Spacing.normal),
//                                                 ),
//                                                 const Divider(
//                                                   color: Colors.grey,
//                                                   thickness: 1.5,
//                                                 ),
//                                                 Container(
//                                                   decoration: BoxDecoration(
//                                                       color: Colors.green,
//                                                       borderRadius:
//                                                       BorderRadius.circular(15),),
//                                                   child: Row(
//                                                     children: [
//                                                       CommonText(text: '${data[index]}')
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             );
//                                           });
//                                     },
//                                     child: GestureDetector(
//                                       onTap: () => DataBaseHelper().readLike(postId: snapshot.data?.docs[index]["postId"]),
//                                       child: CommonText(
//                                           text: '${state.totalLike} likes',
//                                           textColor: Colors.black,
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: TextSize.appBarSubTitle),
//                                     ),
//                                   );
//                                 }
//                               )*/


/*    Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: Spacing.normal,
                                bottom: Spacing.medium,
                              ),
                              child: FutureBuilder(
                                future: Future.value(state.nameList),//DataBaseHelper().readLike(postId: snapshot.data?.docs[index]["postId"]),
                                builder: (context, snapData) {
                                  final dataList = snapData.data ?? [];
                                  return GestureDetector(
                                    onTap: (){
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context){
                                            return ListView.builder(
                                                itemCount: dataList.length,
                                                itemBuilder: (context, index){
                                                  return ListTile(
                                                    title: CommonText(text: dataList[index]["name"],),
                                                  );
                                                }
                                            );
                                          }
                                      );
                                    },
                                  );*/