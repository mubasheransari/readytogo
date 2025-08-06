import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readytogo/Constants/constants.dart';
import 'package:readytogo/Features/ForgetPassword/forget_password_screen.dart';
import 'package:readytogo/Features/Signup/signup_screen.dart';
import 'package:readytogo/Features/login/verification_screen.dart';
import 'package:readytogo/Repositories/fcm_repository.dart';
import 'package:readytogo/widgets/toast_widget.dart';
import '../../widgets/boxDecorationWidget.dart';
import '../../widgets/textfeild_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/login_event.dart';
import 'package:readytogo/Features/login/bloc/login_bloc.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isValidEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}").hasMatch(email);
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
            physics: const BouncingScrollPhysics(),
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
                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Satoshi',
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'We are Recovery "ready to go"',
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
                          obscureText: true,
                          borderColor: Constants().themeColor,
                          controller: passwordController,
                          hintText: 'peterpk454',
                          labelText: 'Password',
                          textWidgetText: 'Password',
                          hintTextColor: Constants().themeColor,
                          validator: (value) =>
                              validatePassword(value?.trim() ?? ''),
                        ),

                        /*CustomTextFieldWidget(
                          //10@Testing
                          obscureText: true,
                          borderColor: Constants().themeColor,
                          controller: passwordController,
                          hintText: 'peterpk454',
                          labelText: 'Password',
                          textWidgetText: 'Password',
                          hintTextColor: Constants().themeColor,
                          validator: (value) =>
                              validatePassword(value?.trim() ?? ''),
                        ),*/
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              //   forgetOption(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ForgetPasswordScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Constants().themeColor,
                                fontFamily: 'Satoshi',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state.status == LoginStatus.success) {
                              final storage = GetStorage();
                              storage.write("password_login",
                                  passwordController.text.trim());
                                    storage.write("email_login",
                                  emailController.text.trim());
                              Future.microtask(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => VerificationViewEmail(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ),
                                  ),
                                );
                              }); //10@Testing
                            } else if (state.status == LoginStatus.failure) {
                              toastWidget(
                                state.errorMessage ??
                                    "Login Failed! Incorrect Email or Password",
                                Colors.red,
                              );
                            }
                          },
                          builder: (context, state) {
                            final isLoading =
                                state.status == LoginStatus.loading;

                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate() &&
                                      !isLoading) {
                                    context.read<LoginBloc>().add(
                                          LoginWithEmailPassword(
                                            email: emailController.text.trim(),
                                            password:
                                                passwordController.text.trim(),
                                          ),
                                        );
                                  } //10@Testing
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Constants().themeColor,
                                  disabledBackgroundColor: Colors.grey.shade400,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                                child: isLoading
                                    ? const SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2.5,
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
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
                                            'assets/loginbuttonicon.png',
                                            width: 23,
                                            height: 23,
                                          ),
                                        ],
                                      ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        _buildDividerWithOrText(),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            FcmRepository()
                                .updateFcmToken("YOUR_TEST_TOKEN_HERE");
                          },
                          child: _buildSocialLoginButton(
                            iconPath: 'assets/facebook.png',
                            label: 'Login with Facebook',
                            borderColor: const Color(0xFF1877F2),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildSocialLoginButton(
                          iconPath: 'assets/Google.png',
                          label: 'Login with Google',
                          borderColor: const Color(0xFFDB4437),
                        ),
                        const SizedBox(height: 20),
                        _buildSocialLoginButton(
                          iconPath: 'assets/Apple.png',
                          label: 'Login with Apple',
                          borderColor: Colors.black,
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontFamily: 'Satoshi',
                                fontSize: 20,
                                color: Color(0xff323747),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SignupScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                " Signup",
                                style: TextStyle(
                                  fontFamily: 'Satoshi',
                                  fontSize: 20,
                                  color: Constants().themeColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
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

  void forgetOption(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(Icons.close, size: 24, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Forgot Password",
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
                //  SizedBox(height: 20),
                // CustomTextWidget(//10@Testing
                //     text: "Cancel Subscription",
                //     color: Colors.black,
                //     textSize: 22,
                //     fontWeight: FontWeight.w500),
                // Text(
                //   "Cancel Subscription",
                //   style: TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.w600,
                //     color: Colors.black87,
                //   ),
                // ),
                // SizedBox(height: 5),
                Text(
                  "Please select where you would like to receive the OTP.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 37,
                      width: 105,
                      child: Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Constants().themeColor,
                            side: BorderSide(color: Constants().themeColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 7),
                          ),
                          child: Text(
                            "SMS",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'satoshi',
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      height: 37,
                      width: 105,
                      child: Expanded(
                        child: OutlinedButton(
                          //10@Testing
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ForgetPasswordScreen(),
                              ),
                            );
                            // Navigator.of(context).pop();
                          }, //10@Testing
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Constants().themeColor,
                            //   backgroundColor: Colors.red,
                            side: BorderSide(color: Constants().themeColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 7),
                          ),
                          child: Text(
                            "EMAIL",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'satoshi',
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDividerWithOrText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(width: 120, child: Divider(color: Colors.black38)),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'or',
            style: TextStyle(
              fontFamily: 'Satoshi',
              fontSize: 20,
              color: Color(0xff28363D),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: 8),
        SizedBox(width: 120, child: Divider(color: Colors.black38)),
      ],
    );
  }

  Widget _buildSocialLoginButton({
    required String iconPath,
    required String label,
    required Color borderColor,
  }) {
    return SizedBox(
      width: 376,
      height: 60,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Image.asset(iconPath, width: 32, height: 32),
        label: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: 'Satoshi',
            fontSize: 20,
            color: Color(0xff323747),
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}
