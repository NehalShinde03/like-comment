import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:like_comment/common_attribute/common_value.dart';
import 'package:like_comment/common_widget/common_elevated_button.dart';
import 'package:like_comment/common_widget/common_text.dart';
import 'package:like_comment/common_widget/common_textfield.dart';
import 'package:like_comment/data_base_helper/data_base_helper.dart';
import 'package:like_comment/view/login/login_cubit.dart';
import 'package:like_comment/view/login/login_state.dart';
import 'package:like_comment/view/registration/registration_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const String routeName = '/login_view';

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        LoginState(
            emailController: TextEditingController(),
            passWordController: TextEditingController(),
            formKey: GlobalKey<FormState>()
        ),
      ),
      child: const LoginView(),
    );
  }

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  LoginCubit get loginCubit => context.read<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: state.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Padding(
                        padding: PaddingValue.xLarge,
                        child: CommonText(
                          text: 'Sign in',
                          fontSize: Spacing.xxLarge,
                          fontWeight: TextWeight.bold,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: Spacing.large - 2,
                            vertical: Spacing.normal,
                        ),
                        child: CommonTextField(
                          controller: state.emailController,
                          prefixIcon: Icons.email,
                          labelText: 'Enter Email',
                          validator: (val) =>
                              val!.isEmpty ? 'field required' : null,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: Spacing.large - 2,
                            vertical: Spacing.normal,
                        ),
                        child: CommonTextField(
                          controller: state.passWordController,
                          prefixIcon: Icons.lock,
                          suffixIcon: state.isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          labelText: 'Enter Password',
                          validator: (val) =>
                              val!.isEmpty ? 'field required' : null,
                          onTap: () => loginCubit.isPasswordVisible(
                              isPasswordVisible: !(state.isPasswordVisible),
                          ),
                          obscureText: !(state.isPasswordVisible),
                        ),
                      ),

                      const Gap(RadiusValue.xxLarge),
                      Center(
                        child: CommonElevatedButton(
                            buttonColor: Colors.teal,
                            text: 'Sign-in',
                            textColor: Colors.white,
                            onPressed: () {
                              if(state.formKey.currentState!.validate()) {
                                DataBaseHelper.instance.compareSignInRecordWithAllUser(
                                    userEmail: state.emailController.text,
                                    userPassword: state.passWordController.text,
                                    context: context
                                );
                              }
                            }),
                      ),

                      /// for new account
                      const Gap(Spacing.xxxLarge * 2),
                      Center(
                        child: RichText(
                            text: TextSpan(
                              text: "Don't have an account?",
                              style: const TextStyle(
                                fontWeight: TextWeight.regular,
                                fontSize: TextSize.title,
                                color: Colors.grey
                              ),
                                children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()..onTap=() =>
                                    Navigator.pushNamed(context, RegistrationView.routeName),
                                  text: "\tCreate Account",
                                  style: const TextStyle(
                                      fontWeight: TextWeight.medium,
                                      fontSize: TextSize.title - 1,
                                      color: Colors.teal
                                  )
                                ),
                              ]
                            )
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ));
  }
}
