import 'package:flutter/material.dart';
import 'package:readytogo/Features/ForgetPassword/update_password_screen.dart';

import '../../Constants/constants.dart';
import '../../widgets/boxDecorationWidget.dart';
import '../../widgets/textfeild_widget.dart';
import 'forget_password_otp_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
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
                      horizontal: 20.0, vertical: 10.0),
                  child: Column(
                    //  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: CircleAvatar(
                              radius: 19,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 19,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 17,
                          ),
                          const Text(
                            'Forget Password',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Satoshi',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60),
                      Image.asset('assets/logo.png', height: 120, width: 115),
                      const SizedBox(height: 20),
                      const Text('Forget Your Password?',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Satoshi',
                          )),
                      const SizedBox(height: 5),
                      const Text("Let's get you back in.",
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
                      SizedBox(
                        width: 342,
                        height: 60,
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgetPasswordOtpVerificationScreen()));
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
                                  'assets/arrow-narrow-left.png',
                                  width: 23,
                                  height: 23,
                                ),
                              ],
                            ),
                          ),
                        ),
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
