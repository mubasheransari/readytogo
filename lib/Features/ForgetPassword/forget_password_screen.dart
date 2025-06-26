import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Constants/constants.dart';
import '../../widgets/boxDecorationWidget.dart';
import '../../widgets/textfeild_widget.dart';
import '../../widgets/toast_widget.dart';
import 'bloc/forget_password_bloc.dart';
import 'bloc/forget_password_event.dart';
import 'bloc/forget_password_state.dart';
import 'forget_password_otp_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  bool isValidEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$").hasMatch(email);
  }

  String? validateEmail(String value) {
    if (value.isEmpty) return 'Email is required';
    if (!isValidEmail(value)) return 'Enter a valid email';
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
                        const Text(
                          'Forget Your Password?',
                          style: TextStyle(
                            fontSize: 32,
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
                          controller: emailController,
                          hintText: 'peter.patrick454@gmail.com',
                          labelText: 'Email',
                          textWidgetText: 'Email',
                          hintTextColor: Constants().themeColor,
                          validator: (value) =>
                              validateEmail(value?.trim() ?? ''),
                        ),
                        const SizedBox(height: 10),

                        /// BlocConsumer section
                        BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
                          listener: (context, state) {
                            if (state is ForgetPasswordSuccess) {
                              toastWidget("OTP sent successfully",
                                  Constants().themeColor);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ForgetPasswordOtpVerificationScreen(
                                        email: emailController.text,
                                      ),
                                ),
                              );
                            } else if (state is ForgetPasswordFailure) {
                              toastWidget("Email Not Found", Colors.red);
                            }
                          },
                          builder: (context, state) {
                            return SizedBox(
                              width: 376,
                              height: 60,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<ForgetPasswordBloc>().add(
                                          RequestForgetPasswordOtp(
                                            email: emailController.text.trim(),
                                          ),
                                        );
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
                                    if (state is ForgetPasswordLoading)
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


/*class ForgetPasswordScreen extends StatefulWidget {
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  bool isValidEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$").hasMatch(email);
  }

  String? validateEmail(String value) {
    if (value.isEmpty) return 'Email is required';
    if (!isValidEmail(value)) return 'Enter a valid email';
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
                        const Text(
                          'Forget Your Password?',
                          style: TextStyle(
                            fontSize: 32,
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
                          controller: emailController,
                          hintText: 'peter.patrick454@gmail.com',
                          labelText: 'Email',
                          textWidgetText: 'Email',
                          hintTextColor: Constants().themeColor,
                          validator: (value) =>
                              validateEmail(value?.trim() ?? ''),
                        ),
                        const SizedBox(height: 10),
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
                                      builder: (_) =>
                                          ForgetPasswordOtpVerificationScreen(),
                                    ),
                                  );
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
      ),
    );
  }
}*/








/*class ForgetPasswordScreen extends StatefulWidget {
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  bool isValidEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$").hasMatch(email);
  }

  String? validateEmail(String value) {
    if (value.isEmpty) return 'Email is required';
    if (!isValidEmail(value)) return 'Enter a valid email';
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
                      horizontal: 20.0, vertical: 10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: CircleAvatar(
                                radius: 19,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.arrow_back,
                                    color: Colors.black, size: 19),
                              ),
                            ),
                            SizedBox(width: 17),
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
                          validator: (value) =>
                              validateEmail(value?.trim() ?? ''),
                        ),
                        const SizedBox(height: 10),
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
                                          ForgetPasswordOtpVerificationScreen(),
                                    ),
                                  );
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
      ),
    );
  }
}*/


// class ForgetPasswordScreen extends StatelessWidget {
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
//                       horizontal: 20.0, vertical: 10.0),
//                   child: Column(
//                     //  mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Row(
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: CircleAvatar(
//                               radius: 19,
//                               backgroundColor: Colors.white,
//                               child: Icon(
//                                 Icons.arrow_back,
//                                 color: Colors.black,
//                                 size: 19,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 17,
//                           ),
//                           const Text(
//                             'Forget Password',
//                             style: TextStyle(
//                               fontSize: 24,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.w700,
//                               fontFamily: 'Satoshi',
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 60),
//                       Image.asset('assets/logo.png', height: 120, width: 115),
//                       const SizedBox(height: 20),
//                       const Text('Forget Your Password?',
//                           style: TextStyle(
//                             fontSize: 32,
//                             fontWeight: FontWeight.w700,
//                             fontFamily: 'Satoshi',
//                           )),
//                       const SizedBox(height: 5),
//                       const Text("Let's get you back in.",
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
//                       const SizedBox(height: 10),
//                       SizedBox(
//                         width: 376,
//                         height: 60,
//                         // width: 342,
//                         // height: 60,
//                         child: Center(
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           ForgetPasswordOtpVerificationScreen()));
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
//                                   'assets/arrow-narrow-left.png',
//                                   width: 23,
//                                   height: 23,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
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
