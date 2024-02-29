import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_comment/view/home/home_state.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit(super.initialState);

  void likeUnlike({like}){
    emit(state.copyWith(like: like));
  }

  void totalLike({like}){
    emit(state.copyWith(totalLike: like));
  }

}