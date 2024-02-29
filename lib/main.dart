import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:like_comment/firebase_options.dart';
import 'package:like_comment/view/home/home_view.dart';
import 'package:like_comment/view/login/login_view.dart';
import 'package:like_comment/view/post/post_view.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: HomeView.routeName,
      routes: route,
    );
  }

  Map<String, WidgetBuilder> get route => <String, WidgetBuilder>{
        RegistrationView.routeName: RegistrationView.builder,
        LoginView.routeName: LoginView.builder,
        HomeView.routeName: HomeView.builder,
        PostView.routeName: PostView.builder
      };
}
