import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_comment/view/login/login_state.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit(super.initialState);


  void tapOnEye({isPasswordVisible}){
    emit(state.copyWith(isPasswordVisible: isPasswordVisible));
  }

  // void registrationIdChange({getRegistrationId}){
  //   emit(state.copyWith(getRegistrationId: getRegistrationId))
  // }

}