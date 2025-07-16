import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readytogo/Features/Signup/bloc/signup_bloc.dart';
import 'package:readytogo/Features/login/bloc/login_event.dart';
import 'package:readytogo/Features/splash_screen.dart';
import 'Features/ForgetPassword/bloc/forget_password_bloc.dart';
import 'Features/login/bloc/login_bloc.dart';
import 'Features/login/login_success_screen.dart';
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

/*import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

Future<void> initializeLocalNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings(
          '@drawable/ic_stat_notification'); // make sure this icon exists

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

void showLocalNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'high_importance_channel', // must match channel ID if using NotificationChannel
    'High Importance Notifications',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: true,
  );

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title ?? 'Notification',
    message.notification?.body ?? '',
    notificationDetails,
  );
}*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  /*await Firebase.initializeApp();

  await initializeLocalNotifications();
  await GetStorage.init();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,10@Testing
  );

  // Print FCM token
  FirebaseMessaging.instance.getToken().then((token) {
    var storage = GetStorage();
    storage.write("fcm_token", token);
    print('FCM Token: $token');
  });

  // Handle foreground message
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Foreground message: ${message.notification?.title}');
    if (message.notification != null) {
      showLocalNotification(message);
    }
  });

  // Handle notification tap
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Notification clicked!');
    // Navigate or handle tap here
  });*/
  var storage = GetStorage();
  var value = storage.read("id");
  var role = storage.read("role");

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SignUpBloc>(
          lazy: false,
          create: (context) => SignUpBloc(),
        ),
        role == "Individual"
            ? BlocProvider<LoginBloc>(
                lazy: false,
                create: (context) => LoginBloc()
                  ..add(GetIndividualProfile(userId: value))
                  ..add(GetAllAssociatedGroups())
                  ..add(GetAllProfessionalProfiles()),
              )
            : role == "Professional"
                ? BlocProvider<LoginBloc>(
                    lazy: false,
                    create: (context) => LoginBloc()
                      ..add(GetAllProfessionalProfiles())
                      ..add(GetProfessionalProfile(userId: value))
                      ..add(GetAllAssociatedGroups()),
                  )
                : role == "Organization"
                    ? BlocProvider<LoginBloc>(
                        lazy: false,
                        create: (context) => LoginBloc()
                          ..add(GetOrganizationProfile(userId: value)))
                    : BlocProvider<LoginBloc>(
                        lazy: false,
                        create: (context) => LoginBloc()
                          ..add(GetAllAssociatedGroups())
                          ..add(GetAllProfessionalProfiles()),
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
      home: token != null ? LoginSuccessScreen() : SplashScreen(),
    );
  }
}
/*Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
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
}*/
