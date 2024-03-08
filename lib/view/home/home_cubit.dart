// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:like_comment/data_base_helper/data_base_helper.dart';
// import 'package:like_comment/view/home/home_state.dart';
//
// class HomeCubit extends Cubit<HomeState>{
//   HomeCubit(super.initialState);
//
//   void likeUnlike({like}){
//     emit(state.copyWith(like: like));
//   }
//
//   void totalLike() async{
//     List like = await DataBaseHelper.instance.readLike();
//     print('total like >>>>>>>>>>> ${like.length}');
//     emit(state.copyWith(totalLike: like.length));
//   }
//
//
//   void nameList(doc) async{
//     final data  = await DataBaseHelper().showLike(postId: doc);
//     emit(state.copyWith(nameList: data));
//   }
//
//   void isBottomSheetOpen({val}){
//     emit(state.copyWith(isBottomSheet: val));
//   }
//
// }