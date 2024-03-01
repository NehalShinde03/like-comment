import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_comment/common_attribute/common_color.dart';
import 'package:like_comment/common_attribute/common_value.dart';
import 'package:like_comment/common_widget/common_material_button.dart';
import 'package:like_comment/common_widget/common_text.dart';
import 'package:like_comment/common_widget/common_textfield.dart';
import 'package:like_comment/data_base_helper/data_base_helper.dart';
import 'package:like_comment/model/registration_model.dart';
import 'package:like_comment/view/home/home_cubit.dart';
import 'package:like_comment/view/home/home_view.dart';
import 'package:like_comment/view/login/login_cubit.dart';
import 'package:like_comment/view/login/login_state.dart';
import 'package:like_comment/view/registration/registration_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const String routeName = "/login_view";

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(LoginState(
          emailController: TextEditingController(),
          passwordController: TextEditingController(),
          formKey: GlobalKey())),
      child: const LoginView(),
    );
  }

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginCubit get loginCubit => context.read<LoginCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Scaffold(
          body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Registration').snapshots(),
            builder: (context, snapshot) {
              return Form(
                key: state.formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// registration heading
                        const Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                              vertical: Spacing.xxxLarge,
                              horizontal: Spacing.small * 2),
                          child: CommonText(
                            text: 'Login',
                            fontSize: TextSize.largeHHeading,
                            fontWeight: TextWeight.bold,
                          ),
                        ),

                        ///enter email
                        Padding(
                          padding: PaddingValue.medium,
                          child: CommonTextField(
                            controller: state.emailController,
                            validator: (val) =>
                                val!.isEmpty ? state.validatorMessage : null,
                            hintText: 'Enter email',
                            //labelText: state.checkEmailIsValid,
                            onChanged: (val) {
                              //registrationCubit.emailValidation(checkEmailIsValid: val.toString());
                            },
                            prefixIcon: Icons.email_outlined,
                          ),
                        ),

                        ///enter password
                        Padding(
                          padding: PaddingValue.medium,
                          child: CommonTextField(
                            controller: state.passwordController,
                            validator: (val) =>
                                val!.isEmpty ? state.validatorMessage : null,
                            hintText: 'Enter password',
                            prefixIcon: Icons.password,
                            suffixIcon: state.isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            onTap: () => loginCubit.tapOnEye(
                                isPasswordVisible: !(state.isPasswordVisible)),
                            obscureText: !(state.isPasswordVisible),
                          ),
                        ),

                        /// registration button
                        Padding(
                          padding: PaddingValue.large,
                          child: Center(
                            child: CommonMaterialButton(
                              text: 'Sign in',
                              onPressed: () async{
                                if (state.formKey.currentState!.validate()) {
                                  var f = FirebaseFirestore.instance.collection('Registration')
                                      .where("email", isEqualTo: state.emailController.text.toString())
                                      .where("password", isEqualTo: state.passwordController.text.toString())
                                      .snapshots().listen((data) => data.docs.forEach((element) async{
                                          SharedPreferences preferences = await SharedPreferences.getInstance();
                                          preferences.setString('registerId', element.get("registrationId"));
                                          print('registration id when user login >>>>>>>>>>> ${element.get("registrationId")}');
                                          Navigator.pushNamed(context, HomeView.routeName, arguments: element.get("registrationId"));
                                  }));
                                  print('runttype -->>> ${f.runtimeType}');

                                }
                              }, //=> Navigator.pop(context),
                            ),
                          ),
                        ),

                        ///create new acccount
                        Center(
                          child: RichText(
                              text: TextSpan(
                                  text: 'Not a Memeber?',
                                  style: TextStyle(
                                      color: CommonColor.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                  children: [
                                TextSpan(
                                    recognizer: TapGestureRecognizer()..onTap = () {
                                      Navigator.pushNamed(context, RegistrationView.routeName);
                                    },
                                    text: ' Signup now',
                                    style: TextStyle(
                                      color: CommonColor.teal,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15
                                    ))
                              ])),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          ),
        );
      },
    ));
  }
}
