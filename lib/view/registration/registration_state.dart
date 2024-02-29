import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class RegistrationState extends Equatable {
  final bool isPasswordVisible;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final String validatorMessage;
  final String checkEmailIsValid;

  const RegistrationState(
      {this.isPasswordVisible = false,
      required this.nameController,
      required this.emailController,
      required this.passwordController,
      required this.formKey,
      this.validatorMessage = "field required",
      this.checkEmailIsValid = ""
      });

  @override
  List<Object?> get props => [
        isPasswordVisible,
        nameController,
        emailController,
        passwordController,
        formKey,
        validatorMessage,
        checkEmailIsValid
  ];

  RegistrationState copyWith({
    bool? isPasswordVisible,
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    GlobalKey<FormState>? formKey,
    String? validatorMessage,
    String? checkEmailIsValid
  }) {
    return RegistrationState(
        isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
        nameController: nameController ?? this.nameController,
        emailController: emailController ?? this.emailController,
        passwordController: passwordController ?? this.passwordController,
        formKey: formKey ?? this.formKey,
        validatorMessage: validatorMessage ?? this.validatorMessage,
        checkEmailIsValid: checkEmailIsValid ?? this.checkEmailIsValid
    );
  }
}
