import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readytogo/Features/Signup/bloc/signup_bloc.dart';
import 'package:readytogo/Features/Signup/bloc/signup_event.dart';
import 'package:readytogo/Features/splash_screen.dart';

import 'Features/Signup/release_of_information.dart';
import 'Features/Signup/signup_screen.dart';
import 'Features/welcome_screen.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    BlocProvider<SignUpBloc>(
      lazy: false,
      create: (context) {
        final signUpBloc = SignUpBloc();
        signUpBloc.add(SignupEvent());
    //    categoriesBloc.add(GetCategories());
      //  categoriesBloc.add(GetCategoriesBeauty());
        return signUpBloc;
      },
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter App',
        debugShowCheckedModeBanner: false,
        home: SplashScreen() 
        );
  }
}
