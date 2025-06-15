import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';
import 'package:readytogo/Features/ForgetPassword/forget_password_screen.dart';
import 'package:readytogo/Features/Signup/signup_screen.dart';
import 'package:readytogo/Features/login/verification_screen.dart';
import '../../widgets/boxDecorationWidget.dart';
import '../../widgets/textfeild_widget.dart';
import '../home_screen.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                      ),
                      const SizedBox(height: 20),
                      CustomTextFieldWidget(
                        borderColor: Constants().themeColor,
                        controller: passwordController,
                        hintText: 'peterpk454',
                        labelText: 'Password',
                        textWidgetText: 'Password',
                        hintTextColor: Constants().themeColor,
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 342,
                        height: 60,
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => //HomeScreen
                                          VerificationScreen()));
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
                                      color: Colors.white,
                                      fontFamily: 'Satoshi',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
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
                              child: Divider(
                                color: Colors.black38,
                              )),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text('or',
                                style: TextStyle(
                                    fontFamily: 'Satoshi',
                                    fontSize: 20,
                                    color: Color(0xff28363D),
                                    fontWeight: FontWeight.w600)),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                              width: 120,
                              child: Divider(
                                color: Colors.black38,
                              )),
                        ],
                      ),
                      SizedBox(height: 20),
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
                      SizedBox(height: 20),
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
                      SizedBox(height: 20),
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
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?",
                              style: TextStyle(
                                  fontFamily: 'Satoshi',
                                  fontSize: 20,
                                  color: Color(0xff323747),
                                  fontWeight: FontWeight.w500)),
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
                                    fontWeight: FontWeight.w500)),
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
    );
  }
}
