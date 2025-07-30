import 'package:flutter/material.dart';

import '../../Constants/constants.dart';
import '../../widgets/boxDecorationWidget.dart';
import '../../widgets/textfeild_widget.dart';
import '../../widgets/toast_widget.dart';

class ForgetPasswordScreenSMS extends StatefulWidget {
  @override
  State<ForgetPasswordScreenSMS> createState() =>
      _ForgetPasswordScreenSMSState();
}

class _ForgetPasswordScreenSMSState extends State<ForgetPasswordScreenSMS> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();

  bool isValidPhone(String phone) {
    return RegExp(r'^\d{10,15}$')
        .hasMatch(phone); // Accepts 10–15 digit numbers
  }

  String? validatePhone(String value) {
    if (value.isEmpty) return 'Phone number is required';
    if (!isValidPhone(value)) return 'Enter a valid phone number';
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
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.vertical,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: const CircleAvatar(
                                radius: 19,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.arrow_back,
                                    color: Colors.black, size: 19),
                              ),
                            ),
                            const SizedBox(width: 17),
                            const Text(
                              'Forget Password',
                              style: TextStyle(
                                fontSize: 22,
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
                        const Text(
                          'Forget Your Password?',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Satoshi',
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Let's get you back in.",
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 24,
                            color: Color(0xff666F80),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 40),
                        CustomTextFieldWidget(
                          borderColor: Constants().themeColor,
                          controller: phoneController,
                          hintText: 'Phone Number',
                          labelText: 'Phone Number',
                          textWidgetText: 'Phone Number',
                          hintTextColor: Constants().themeColor,
                          validator: (value) =>
                              validatePhone(value?.trim() ?? ''),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                // Call SMS API here
                                toastWidget(
                                    "OTP Sent Successfully", Colors.green);

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (_) => ForgetPasswordOtpVerificationScreen(
                                //       email: emailController.text,
                                //     ),
                                //   ),
                                // );
                              }
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
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Continue',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Satoshi',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Image(
                                  image: AssetImage(
                                      'assets/arrow-narrow-left.png'),
                                  width: 23,
                                  height: 23,
                                ),
                              ],
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
      ),
    );
  }
}
