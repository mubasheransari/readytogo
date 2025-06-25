import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';
import 'package:readytogo/Features/ForgetPassword/forget_password_screen.dart';
import 'package:readytogo/Features/Signup/signup_screen.dart';
import 'package:readytogo/Features/login/verification_screen.dart';
import '../../widgets/boxDecorationWidget.dart';
import '../../widgets/textfeild_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/login_event.dart';
import 'package:readytogo/Features/login/bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isValidEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$").hasMatch(email);
  }

  String? validateEmail(String value) {
    if (value.isEmpty) return 'Email is required';
    if (!isValidEmail(value)) return 'Enter a valid email';
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: DecoratedBox(
        decoration: boxDecoration(),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.vertical,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 50.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/logo.png', height: 120, width: 115),
                        const SizedBox(height: 20),
                        const Text('Welcome Back',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Satoshi',
                            )),
                        const SizedBox(height: 5),
                        const Text('We are Recovery "ready to go"',
                            style: TextStyle(
                                fontFamily: 'Satoshi',
                                fontSize: 24,
                                color: Color(0xff666F80),
                                fontWeight: FontWeight.w700)),
                        const SizedBox(height: 40),
                        CustomTextFieldWidget(
                          borderColor: Constants().themeColor,
                          controller: emailController,
                          hintText: 'peter.patrick454@gmail.com',
                          labelText: 'Email',
                          textWidgetText: 'Email',
                          hintTextColor: Constants().themeColor,
                          validator: (value) =>
                              validateEmail(value?.trim() ?? ''),
                        ),
                        const SizedBox(height: 5),
                        CustomTextFieldWidget(
                          borderColor: Constants().themeColor,
                          controller: passwordController,
                          hintText: 'peterpk454',
                          labelText: 'Password',
                          textWidgetText: 'Password',
                          hintTextColor: Constants().themeColor,
                          validator: (value) =>
                              validatePassword(value?.trim() ?? ''),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgetPasswordScreen()));
                            },
                            child: Text('Forgot Password?',
                                style: TextStyle(
                                    color: Constants().themeColor,
                                    fontFamily: 'Satoshi',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: 376,
                          height: 60,
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          VerificattionScreen(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          ),
                                    ),
                                  );

                                  context.read<LoginBloc>().add(
                                      LoginWithEmailPassword(
                                          email: "mubashera38@yopmail.com",
                                          password: "Testing1234@"));
                                }

                                // else {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(
                                //       content:
                                //           Text('Please fix the errors above.'),
                                //     ),
                                //   );
                                // }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Constants().themeColor,
                                minimumSize: const Size(200, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Continue',
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: Colors.white,
                                        fontFamily: 'Satoshi',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(width: 5),
                                  Image.asset(
                                    'assets/loginbuttonicon.png',
                                    width: 23,
                                    height: 23,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(
                                width: 120,
                                child: Divider(color: Colors.black38)),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text('or',
                                  style: TextStyle(
                                      fontFamily: 'Satoshi',
                                      fontSize: 20,
                                      color: Color(0xff28363D),
                                      fontWeight: FontWeight.w600)),
                            ),
                            SizedBox(width: 8),
                            SizedBox(
                                width: 120,
                                child: Divider(color: Colors.black38)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 376,
                          height: 60,
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/facebook.png',
                              width: 32,
                              height: 32,
                            ),
                            label: Text(
                              'Login with Facebook',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Satoshi',
                                  fontSize: 20,
                                  color: Color(0xff323747)),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(color: Color(0xFF1877F2)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 376,
                          height: 60,
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/Google.png',
                              width: 32,
                              height: 32,
                            ),
                            label: Text(
                              'Login with Google',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Satoshi',
                                  fontSize: 20,
                                  color: Color(0xff323747)),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(color: Color(0xFFDB4437)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 376,
                          height: 60,
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/Apple.png',
                              width: 24,
                              height: 24,
                            ),
                            label: Text(
                              'Login with Apple',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Satoshi',
                                  fontSize: 20,
                                  color: Color(0xff323747)),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(color: Colors.black),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",
                                style: TextStyle(
                                    fontFamily: 'Satoshi',
                                    fontSize: 20,
                                    color: Color(0xff323747),
                                    fontWeight: FontWeight.w700)),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupScreen()));
                              },
                              child: Text(" Signup",
                                  style: TextStyle(
                                      fontFamily: 'Satoshi',
                                      fontSize: 20,
                                      color: Constants().themeColor,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



// class LoginScreen extends StatelessWidget {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       extendBodyBehindAppBar: true,
//       body: DecoratedBox(
//         decoration: boxDecoration(),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 minHeight: MediaQuery.of(context).size.height -
//                     MediaQuery.of(context).padding.vertical,
//               ),
//               child: IntrinsicHeight(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 20.0, vertical: 50.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset('assets/logo.png', height: 120, width: 115),
//                       const SizedBox(height: 20),
//                       const Text('Welcome Back',
//                           style: TextStyle(
//                             fontSize: 32,
//                             fontWeight: FontWeight.w700,
//                             fontFamily: 'Satoshi',
//                           )),
//                       const SizedBox(height: 5),
//                       const Text('We are Recovery "ready to go"',
//                           style: TextStyle(
//                               fontFamily: 'Satoshi',
//                               fontSize: 24,
//                               color: Color(0xff666F80),
//                               fontWeight: FontWeight.w700)),
//                       const SizedBox(height: 40),
//                       CustomTextFieldWidget(
//                         borderColor: Constants().themeColor,
//                         controller: emailController,
//                         hintText: 'peter.patrick454@gmail.com',
//                         labelText: 'Email',
//                         textWidgetText: 'Email',
//                         hintTextColor: Constants().themeColor,
//                       ),
//                       const SizedBox(height: 20),
//                       CustomTextFieldWidget(
//                         borderColor: Constants().themeColor,
//                         controller: passwordController,
//                         hintText: 'peterpk454',
//                         labelText: 'Password',
//                         textWidgetText: 'Password',
//                         hintTextColor: Constants().themeColor,
//                       ),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         ForgetPasswordScreen()));
//                           },
//                           child: Text('Forgot Password?',
//                               style: TextStyle(
//                                   color: Constants().themeColor,
//                                   fontFamily: 'Satoshi',
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w700)),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       SizedBox(
//                         width: 376,
//                         height: 60, // width: 342,
//                         // height: 60,
//                         child: Center(
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => //HomeScreen
//                                           VerificattionScreen() //VerificattionScreen()
//                                       ));
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Constants().themeColor,
//                               minimumSize: const Size(200, 50),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 20, vertical: 10),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Text(
//                                   'Continue',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontFamily: 'Satoshi',
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                                 const SizedBox(width: 5),
//                                 Image.asset(
//                                   'assets/loginbuttonicon.png',
//                                   width: 23,
//                                   height: 23,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           SizedBox(
//                               width: 120,
//                               child: Divider(
//                                 color: Colors.black38,
//                               )),
//                           Padding(
//                             padding: EdgeInsets.only(left: 8.0),
//                             child: Text('or',
//                                 style: TextStyle(
//                                     fontFamily: 'Satoshi',
//                                     fontSize: 20,
//                                     color: Color(0xff28363D),
//                                     fontWeight: FontWeight.w600)),
//                           ),
//                           SizedBox(
//                             width: 8,
//                           ),
//                           SizedBox(
//                               width: 120,
//                               child: Divider(
//                                 color: Colors.black38,
//                               )),
//                         ],
//                       ),
//                       SizedBox(height: 20),
//                       SizedBox(
//                         width: 376,
//                         height: 60,
//                         child: OutlinedButton.icon(
//                           onPressed: () {},
//                           icon: Image.asset(
//                             'assets/facebook.png',
//                             width: 32,
//                             height: 32,
//                           ),
//                           label: Text(
//                             'Login with Facebook',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontFamily: 'Satoshi',
//                                 fontSize: 20,
//                                 color: Color(0xff323747)),
//                           ),
//                           style: OutlinedButton.styleFrom(
//                             backgroundColor: Colors.white,
//                             side: BorderSide(color: Color(0xFF1877F2)),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             padding: EdgeInsets.symmetric(vertical: 15),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       SizedBox(
//                         width: 376,
//                         height: 60,
//                         child: OutlinedButton.icon(
//                           onPressed: () {},
//                           icon: Image.asset(
//                             'assets/Google.png',
//                             width: 32,
//                             height: 32,
//                           ),
//                           label: Text(
//                             'Login with Google',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontFamily: 'Satoshi',
//                                 fontSize: 20,
//                                 color: Color(0xff323747)),
//                           ),
//                           style: OutlinedButton.styleFrom(
//                             backgroundColor: Colors.white,
//                             side: BorderSide(color: Color(0xFFDB4437)),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             padding: EdgeInsets.symmetric(vertical: 15),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       SizedBox(
//                         width: 376,
//                         height: 60,
//                         child: OutlinedButton.icon(
//                           onPressed: () {},
//                           icon: Image.asset(
//                             'assets/Apple.png',
//                             width: 24,
//                             height: 24,
//                           ),
//                           label: Text(
//                             'Login with Apple',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontFamily: 'Satoshi',
//                                 fontSize: 20,
//                                 color: Color(0xff323747)),
//                           ),
//                           style: OutlinedButton.styleFrom(
//                             backgroundColor: Colors.white,
//                             side: BorderSide(color: Colors.black),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             padding: EdgeInsets.symmetric(vertical: 15),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 30),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text("Don't have an account?",
//                               style: TextStyle(
//                                   fontFamily: 'Satoshi',
//                                   fontSize: 20,
//                                   color: Color(0xff323747),
//                                   fontWeight: FontWeight.w700)),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => SignupScreen()));
//                             },
//                             child: Text(" Signup",
//                                 style: TextStyle(
//                                     fontFamily: 'Satoshi',
//                                     fontSize: 20,
//                                     color: Constants().themeColor,
//                                     fontWeight: FontWeight.w700)),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
