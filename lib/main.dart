import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readytogo/Features/Signup/bloc/signup_bloc.dart';
import 'package:readytogo/Features/Signup/bloc/signup_event.dart';
import 'package:readytogo/Features/splash_screen.dart';

import 'Features/ForgetPassword/bloc/forget_password_bloc.dart';
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

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Handle background message
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await GetStorage.init();

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.instance.getToken().then((token) {
    print('FCM Token: $token');
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Foreground message: ${message.notification?.title}');
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Notification clicked!');
  });

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
        BlocProvider<ForgetPasswordBloc>(
          lazy: false,
          create: (context) => ForgetPasswordBloc(),
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
        title: 'Ready to go',
        debugShowCheckedModeBanner: false,
        home: token != null ? LoginSuccessScreen() : SplashScreen());
  }
}
