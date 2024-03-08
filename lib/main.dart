import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:like_comment/firebase_options.dart';
import 'package:like_comment/view/all_post/all_post_view.dart';
import 'package:like_comment/view/login/login_view.dart';
import 'package:like_comment/view/new_post/new_post_view.dart';
import 'package:like_comment/view/registration/registration_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: LoginView.routeName,
      routes: route,
    );
  }

  Map<String, WidgetBuilder> get route => <String, WidgetBuilder>{
    RegistrationView.routeName:RegistrationView.builder,
    LoginView.routeName:LoginView.builder,
    NewPostView.routeName:NewPostView.builder,
    AllPostView.routeName:AllPostView.builder,
    // ProfileView.routeName:ProfileView.builder,
    // BottomNavigationBarView.routeName:BottomNavigationBarView.builder
  };

}
