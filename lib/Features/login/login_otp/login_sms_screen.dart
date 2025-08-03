import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readytogo/Features/login/bloc/login_bloc.dart';
import 'package:readytogo/Features/login/bloc/login_state.dart';
import 'package:readytogo/Features/login/verificationOtpNumber.dart';

import '../../../Constants/constants.dart';
import '../../../widgets/boxDecorationWidget.dart';
import '../../../widgets/textfeild_widget.dart';
import '../../../widgets/toast_widget.dart';
import '../bloc/login_event.dart';

class LoginSMSOtp extends StatefulWidget {
  @override
  State<LoginSMSOtp> createState() => _LoginSMSOtpState();
}

class _LoginSMSOtpState extends State<LoginSMSOtp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();

  bool isValidPhone(String phone) {
    return RegExp(r'^\d{10,15}$')
        .hasMatch(phone); // Accepts 10–15 digit numbers
  }

  String? validatePhone(String value) {
    if (value.isEmpty) return 'Phone number is required';
    // if (!isValidPhone(value)) return 'Enter a valid phone number';
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
                              'Login Through SMS',
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
                          'Login Through Number',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Satoshi',
                          ),
                        ),
                        // const SizedBox(height: 5),
                        // const Text(
                        //   "Let's get you back in.",
                        //   style: TextStyle(
                        //     fontFamily: 'Satoshi',
                        //     fontSize: 24,
                        //     color: Color(0xff666F80),
                        //     fontWeight: FontWeight.w700,
                        //   ),
                        // ),
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
                        BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            print(
                                "STATUS ${state.loginThroughSMSOtpLoginRequestEnum}");
                            print(
                                "STATUS ${state.loginThroughSMSOtpLoginRequestEnum}");
                            print(
                                "STATUS ${state.loginThroughSMSOtpLoginRequestEnum}");
                            print(
                                "STATUS ${state.loginThroughSMSOtpLoginRequestEnum}");

                            if (state.loginThroughSMSOtpLoginRequestEnum ==
                                LoginThroughSMSOtpLoginRequestEnum.success) {
                              // final box = GetStorage();
                              // var email = box.read("forgotPassword-email");
                              // context.read<ForgetPasswordBloc>().add(
                              //       ForgetPasswordToken(
                              //         email: email,
                              //       ),
                              //     );

                              toastWidget(
                                  "OTP Sent Successfully", Colors.green);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          VerificationOTPNumber(
                                            phoneNumber: phoneController.text,
                                          )));
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (_) => ForgetPasswordOtpNumberScreen(
                              //       phone: phoneController.text,
                              //     ),
                              //   ),
                              // );
                            } else if (state
                                    .loginThroughSMSOtpLoginRequestEnum ==
                                LoginThroughSMSOtpLoginRequestEnum.failure) {
                              toastWidget("Failed to send OTP.", Colors.red);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             VerificationOTPNumber(phoneNumber: phoneController.text,)));
                            }
                          },
                          builder: (context, state) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: 50,
                              // width: 376,
                              // height: 60,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();

                                    final storage = GetStorage();
                                    var password =
                                        storage.read("password_login");

                                    context.read<LoginBloc>().add(
                                        LoginThroughSMSOtpLoginRequest(
                                            password: password,
                                            phone: phoneController.text));
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (state
                                            .loginThroughSMSOtpLoginRequestEnum ==
                                        LoginThroughSMSOtpLoginRequestEnum
                                            .loading)
                                      const SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    else ...[
                                      const Text(
                                        'Continue',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Satoshi',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Image.asset(
                                        'assets/arrow-narrow-left.png',
                                        width: 23,
                                        height: 23,
                                      ),
                                    ]
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        /*  SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                context.read<ForgetPasswordBloc>().add(
                                    RequestForgetPasswordOtpSMS(
                                        phone: phoneController.text));
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
                        ),*/
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
