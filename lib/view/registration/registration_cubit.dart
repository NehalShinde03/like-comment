import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_comment/view/registration/registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState>{
  RegistrationCubit(super.initialState);

  ///tap on eye for password
  void tapOnEye({isPasswordVisible}){
    emit(state.copyWith(isPasswordVisible: isPasswordVisible));
  }

  void emailValidation({checkEmailIsValid}){
    String emailValidated = "";
    checkEmailIsValid.toString().contains('@gmail.com')
    ? emailValidated = "correct email"
    : emailValidated = "inCorrect email";
    emit(state.copyWith(checkEmailIsValid: emailValidated));
  }

}