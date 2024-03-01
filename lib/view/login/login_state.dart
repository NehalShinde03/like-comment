import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class LoginState extends Equatable {

  final bool isPasswordVisible;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final String validatorMessage;
  final String checkEmailIsValid;
  final String getRegistrationId;

  const LoginState(
      {this.isPasswordVisible = false,
        required this.emailController,
        required this.passwordController,
        required this.formKey,
        this.validatorMessage = "field required",
        this.checkEmailIsValid = "",
        this.getRegistrationId = ""
      });

  @override
  List<Object?> get props => [
    isPasswordVisible,
    emailController,
    passwordController,
    formKey,
    validatorMessage,
    checkEmailIsValid,
    getRegistrationId
  ];

  LoginState copyWith({
    bool? isPasswordVisible,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    GlobalKey<FormState>? formKey,
    String? validatorMessage,
    String? checkEmailIsValid,
    String? getRegistrationId
  }) {
    return LoginState(
        isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
        emailController: emailController ?? this.emailController,
        passwordController: passwordController ?? this.passwordController,
        formKey: formKey ?? this.formKey,
        validatorMessage: validatorMessage ?? this.validatorMessage,
        checkEmailIsValid: checkEmailIsValid ?? this.checkEmailIsValid,
        getRegistrationId: getRegistrationId ?? this.getRegistrationId
    );
  }
}
