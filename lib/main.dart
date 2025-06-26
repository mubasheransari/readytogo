import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readytogo/Features/Signup/bloc/signup_bloc.dart';
import 'package:readytogo/Features/Signup/bloc/signup_event.dart';
import 'package:readytogo/Features/splash_screen.dart';

import 'Features/Signup/release_of_information.dart';
import 'Features/Signup/signup_screen.dart';
import 'Features/login/bloc/login_bloc.dart';
import 'Features/login/login_success_screen.dart';
import 'Features/welcome_screen.dart';
import 'package:get_storage/get_storage.dart';
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   runApp(
//     BlocProvider<SignUpBloc>(
//       lazy: false,
//       create: (context) {
//         final signUpBloc = SignUpBloc();
//         // signUpBloc.add(SignupEvent());
//         //    categoriesBloc.add(GetCategories());
//         //  categoriesBloc.add(GetCategoriesBeauty());
//         return signUpBloc;
//       },
//       child: MyApp(),
//     ),//Testing1122@
//   );
// }

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SignUpBloc>(
          lazy: false,
          create: (context) => SignUpBloc(),
        ),
        BlocProvider<LoginBloc>(
          lazy: false,
          create: (context) => LoginBloc(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var token = box.read("token");
    return MaterialApp(
        title: 'Flutter App',
        debugShowCheckedModeBanner: false,
        home:token != null ? LoginSuccessScreen(): SplashScreen()
        );
  }
}
