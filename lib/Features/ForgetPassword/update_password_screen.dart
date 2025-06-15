import 'package:flutter/material.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';

import '../../Constants/constants.dart';
import '../../widgets/boxDecorationWidget.dart';
import '../../widgets/textfeild_widget.dart';
import 'forget_password_otp_screen.dart';

class UpdatePasswordScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appbartitle: 'Update Password',
      showNotificationIcon: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        child: SingleChildScrollView(
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //   const SizedBox(height: 40),
              Image.asset('assets/logo.png', height: 120, width: 115),
              const SizedBox(height: 20),
              const Text('Update Your Password',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi',
                  )),
              const SizedBox(height: 5),
              const Text("A fresh password for fresh start",
                  style: TextStyle(
                      fontFamily: 'Satoshi',
                      fontSize: 24,
                      color: Color(0xff666F80),
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 40),
              CustomTextFieldWidget(
                borderColor: Constants().themeColor,
                controller: passwordController,
                hintText: 'New Password',
                labelText: 'New Password',
                textWidgetText: 'New Password',
                hintTextColor: Constants().themeColor,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFieldWidget(
                borderColor: Constants().themeColor,
                controller: passwordController,
                hintText: 'Confirm Password',
                labelText: 'Confirm Password',
                textWidgetText: 'Confirm Password',
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
    );
  }
}
