import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readytogo/Features/login/bloc/login_bloc.dart';
import 'package:readytogo/Features/login/bloc/login_event.dart';
import 'package:readytogo/Features/login/bloc/login_state.dart';
import 'package:readytogo/Features/login/login_otp/verification_login_sms_screen.dart';
import 'package:readytogo/widgets/toast_widget.dart';

import '../../../Constants/constants.dart';
import '../../../widgets/boxDecorationWidget.dart';
import '../../../widgets/textfeild_widget.dart';

class LoginThroughSMSViewOTPRequest extends StatefulWidget {
  LoginThroughSMSViewOTPRequest({Key? key}) : super(key: key);

  @override //100@Testing
  State<LoginThroughSMSViewOTPRequest> createState() =>
      _LoginThroughSMSViewOTPRequestState();
}

class _LoginThroughSMSViewOTPRequestState
    extends State<LoginThroughSMSViewOTPRequest> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();

  String? validatePhoneNumber(String value) {
    if (value.isEmpty) return 'Phone Number is required';
    // if (!isValidEmail(value)) return 'Enter a valid email';
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
                                fontSize: 24, //100@Testing
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Satoshi',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 60),
                        Image.asset('assets/logo.png', height: 120, width: 115),

                        const SizedBox(height: 40),
                        CustomTextFieldWidget(
                          borderColor: Constants().themeColor,
                          controller: phoneNumberController,
                          hintText: 'Phone Number',
                          labelText: 'Phone Number',
                          textWidgetText: 'Phone Number',
                          hintTextColor: Constants().themeColor,
                          validator: (value) =>
                              validatePhoneNumber(value?.trim() ?? ''),
                        ),
                        const SizedBox(height: 10),

                        /// BlocConsumer section
                        BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state.loginThroughSMSOtpRequestNewEnum ==
                                LoginThroughSMSOtpRequestNewEnum.success) {
                              final box = GetStorage();
                              box.write(
                                  "phone", phoneNumberController.text.trim());

                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          VerificationLoginSMSScreenOTP()),
                                );
                              });//100@Testing

                              toastWidget(
                                  "OTP Sent Successfully", Colors.green);
                            } else if (state.loginThroughSMSOtpRequestNewEnum ==
                                LoginThroughSMSOtpRequestNewEnum.failure) {
                              toastWidget("Failed", Colors.red);
                            }
                          },

                          builder: (context, state) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: 50,
                   
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final storage = GetStorage();
                                    var password =
                                        storage.read("password_login");
                                    print("Password : $password");
                                    context.read<LoginBloc>().add(
                                          LoginThroughSMSOtpRequestNew(
                                              phone: phoneNumberController.text,
                                              password: password),
                                        );
                                    FocusScope.of(context).unfocus();
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
                                            .loginThroughSMSOtpRequestNewEnum ==
                                        LoginThroughSMSOtpRequestNewEnum
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
