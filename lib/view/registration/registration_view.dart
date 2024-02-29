import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_comment/common_attribute/common_value.dart';
import 'package:like_comment/common_widget/common_material_button.dart';
import 'package:like_comment/common_widget/common_text.dart';
import 'package:like_comment/common_widget/common_textfield.dart';
import 'package:like_comment/data_base_helper/data_base_helper.dart';
import 'package:like_comment/model/registration_model.dart';
import 'package:like_comment/view/registration/registration_cubit.dart';
import 'package:like_comment/view/registration/registration_state.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  static const String routeName = "/registration_view";

  static Widget builder(BuildContext context) {
    return BlocProvider(
        create: (context) => RegistrationCubit(RegistrationState(
          nameController: TextEditingController(),
          emailController: TextEditingController(),
          passwordController: TextEditingController(),
          formKey: GlobalKey()
        )),
        child: const RegistrationView(),
    );
  }

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {

  RegistrationCubit get registrationCubit => context.read<RegistrationCubit>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocBuilder<RegistrationCubit, RegistrationState>(
          builder: (context, state) {
            return Scaffold(
              body: Form(
                key: state.formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// registration heading
                        Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                              vertical: Spacing.xxxLarge,
                              horizontal: Spacing.small * 2),
                          child: CommonText(
                            text: 'Signup',
                            fontSize: TextSize.largeHHeading,
                            fontWeight: TextWeight.bold,
                          ),
                        ),


                        ///enter name
                        Padding(
                          padding: PaddingValue.medium,
                          child: CommonTextField(
                            controller: state.nameController,
                            validator: (val) => val!.isEmpty ? state.validatorMessage : null,
                            hintText: 'Enter name',
                            prefixIcon: Icons.person_2_outlined,
                          ),
                        ),


                        ///enter email
                        Padding(
                          padding: PaddingValue.medium,
                          child: CommonTextField(
                            controller: state.emailController,
                            validator: (val) => val!.isEmpty ? state.validatorMessage : null,
                            hintText: 'Enter email',
                            //labelText: state.checkEmailIsValid,
                            onChanged: (val){
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
                            validator: (val) => val!.isEmpty ? state.validatorMessage : null,
                            hintText: 'Enter password',
                            prefixIcon: Icons.password,
                            suffixIcon: state.isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            onTap: () => registrationCubit.tapOnEye(isPasswordVisible: !(state.isPasswordVisible)),
                            obscureText: !(state.isPasswordVisible),
                          ),
                        ),

                        /// registration button
                        Padding(
                          padding: PaddingValue.large,
                          child: Center(
                            child: CommonMaterialButton(
                              text: 'Signup',
                              onPressed: () {
                                if(state.formKey.currentState!.validate()){
                                  state.emailController.text.contains('@gmail.com')
                                    ? DataBaseHelper().insertRegistrationData(registrationModel: RegistrationModel(
                                      name: state.nameController.text,
                                      email: state.emailController.text,
                                      password: state.passwordController.text
                                   ))
                                     : print('in valide');
                                  Navigator.pop(context);
                                }
                              }, //=> Navigator.pop(context),
                            ),
                          ),
                        )


                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
