import 'package:flutter/material.dart';
import 'package:readytogo/Features/ForgetPassword/bloc/forget_password_bloc.dart';
import 'package:readytogo/widgets/toast_widget.dart';
import '../../Constants/constants.dart';
import '../../widgets/boxDecorationWidget.dart';
import '../../widgets/textfeild_widget.dart';
import '../login/login_screen.dart';
import 'bloc/forget_password_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/forget_password_state.dart';

class UpdatePasswordScreen extends StatefulWidget {
  final String email;
  const UpdatePasswordScreen({super.key, required this.email});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isButtonEnabled = false;
  String? generalError;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(validatePasswords);
    confirmPasswordController.addListener(validatePasswords);
  }

  void validatePasswords() {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    setState(() {
      generalError = null;
      if (password.isEmpty || confirmPassword.isEmpty) {
        isButtonEnabled = false;
      } else if (password.length < 8) {
        generalError = 'Password must be at least 8 characters';
        isButtonEnabled = false;
      } else if (password != confirmPassword) {
        generalError = 'Passwords do not match';
        isButtonEnabled = false;
      } else {
        isButtonEnabled = true;
      }
    });
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ResetForgetPasswordSuccess) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => LoginScreen()));
        } else if (state is ResetForgetPasswordFailure) {
          toastWidget(
              "Password must have capital letters,small letters & numbers.",
              Colors.red);
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text(state.error)),
          // );
        }
      },
      builder: (context, state) {
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
                            // Back header
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
                                  'Update Password',
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

                            // Logo & title
                            Image.asset('assets/logo.png',
                                height: 120, width: 115),
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
                                  fontWeight: FontWeight.w700,
                                )),
                            const SizedBox(height: 40),

                            // Password Fields
                            CustomTextFieldWidget(
                              borderColor: Constants().themeColor,
                              controller: passwordController,
                              hintText: 'New Password',
                              labelText: 'New Password',
                              textWidgetText: 'New Password',
                              hintTextColor: Constants().themeColor,
                              obscureText: true,
                            ),
                            const SizedBox(height: 10),
                            CustomTextFieldWidget(
                              borderColor: Constants().themeColor,
                              controller: confirmPasswordController,
                              hintText: 'Confirm Password',
                              labelText: 'Confirm Password',
                              textWidgetText: 'Confirm Password',
                              hintTextColor: Constants().themeColor,
                              obscureText: true,
                            ),

                            if (generalError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  generalError!,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 14),
                                ),
                              ),

                            const SizedBox(height: 20),

                            // Submit Button
                            SizedBox(
                              width: 342,
                              height: 60,
                              child: ElevatedButton(
                                onPressed: isButtonEnabled
                                    ? () {
                                        context.read<ForgetPasswordBloc>().add(
                                              ResetForgetPassword(
                                                email: widget.email,
                                                password: passwordController
                                                    .text
                                                    .trim(),
                                                confirmPassword:
                                                    confirmPasswordController
                                                        .text
                                                        .trim(),
                                              ),
                                            );
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Constants().themeColor,
                                  disabledBackgroundColor: Colors.grey.shade400,
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
                                      'Update Password',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Satoshi',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(width: 5),
                                    Image.asset(
                                      'assets/update_check.png',
                                      width: 23,
                                      height: 23,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
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
      },
    );
  }
}



// class UpdatePasswordScreen extends StatefulWidget {
//   final String email;
//   const UpdatePasswordScreen({super.key, required this.email});

//   @override
//   State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
// }

// class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   bool isButtonEnabled = false;
//   String? passwordError;
//   String? confirmPasswordError;
//   String? generalError; // Shows combined error above the button

//   @override
//   void initState() {
//     super.initState();
//     passwordController.addListener(validatePasswords);
//     confirmPasswordController.addListener(validatePasswords);
//   }

//   void validatePasswords() {
//     final password = passwordController.text.trim();
//     final confirmPassword = confirmPasswordController.text.trim();

//     setState(() {
//       generalError = null;
//       if (password.isEmpty || confirmPassword.isEmpty) {
//         isButtonEnabled = false;
//       } else if (password.length < 8) {
//         generalError = 'Password must be at least 8 characters';
//         isButtonEnabled = false;
//       } else if (password != confirmPassword) {
//         generalError = 'Passwords do not match';
//         isButtonEnabled = false;
//       } else {
//         generalError = null;
//         isButtonEnabled = true;
//       }
//     });
//   }

//   @override
//   void dispose() {
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       extendBodyBehindAppBar: true,
//       body: DecoratedBox(
//         decoration: boxDecoration(),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 minHeight: MediaQuery.of(context).size.height -
//                     MediaQuery.of(context).padding.vertical,
//               ),
//               child: IntrinsicHeight(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         // Back header
//                         Row(
//                           children: [
//                             InkWell(
//                               onTap: () => Navigator.pop(context),
//                               child: const CircleAvatar(
//                                 radius: 19,
//                                 backgroundColor: Colors.white,
//                                 child: Icon(Icons.arrow_back, color: Colors.black, size: 19),
//                               ),
//                             ),
//                             const SizedBox(width: 17),
//                             const Text(
//                               'Update Password',
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 color: Colors.black87,
//                                 fontWeight: FontWeight.w700,
//                                 fontFamily: 'Satoshi',
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 60),

//                         // Logo & title
//                         Image.asset('assets/logo.png', height: 120, width: 115),
//                         const SizedBox(height: 20),
//                         const Text('Update Your Password',
//                             style: TextStyle(
//                               fontSize: 32,
//                               fontWeight: FontWeight.w700,
//                               fontFamily: 'Satoshi',
//                             )),
//                         const SizedBox(height: 5),
//                         const Text("A fresh password for fresh start",
//                             style: TextStyle(
//                               fontFamily: 'Satoshi',
//                               fontSize: 24,
//                               color: Color(0xff666F80),
//                               fontWeight: FontWeight.w700,
//                             )),
//                         const SizedBox(height: 40),

//                         // Password Fields
//                         CustomTextFieldWidget(
//                           borderColor: Constants().themeColor,
//                           controller: passwordController,
//                           hintText: 'New Password',
//                           labelText: 'New Password',
//                           textWidgetText: 'New Password',
//                           hintTextColor: Constants().themeColor,
//                           obscureText: true,
//                         ),
//                         const SizedBox(height: 10),
//                         CustomTextFieldWidget(
//                           borderColor: Constants().themeColor,
//                           controller: confirmPasswordController,
//                           hintText: 'Confirm Password',
//                           labelText: 'Confirm Password',
//                           textWidgetText: 'Confirm Password',
//                           hintTextColor: Constants().themeColor,
//                           obscureText: true,
//                         ),

//                         // General error shown above button
//                         if (generalError != null)
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10.0),
//                             child: Text(
//                               generalError!,
//                               style: const TextStyle(color: Colors.red, fontSize: 14),
//                             ),
//                           ),

//                         const SizedBox(height: 20),

//                         // Submit Button
//                         SizedBox(
//                           width: 342,
//                           height: 60,
//                           child: ElevatedButton(
//                             onPressed: isButtonEnabled
//                                 ? () {
//                                     context.read<ForgetPasswordBloc>().add(
//                                           ResetForgetPassword(
//                                             email: widget.email,
//                                             password: passwordController.text.trim(),
//                                             confirmPassword: confirmPasswordController.text.trim(),
//                                           ),
//                                         );
//                                   }
//                                 : null,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Constants().themeColor,
//                               disabledBackgroundColor: Colors.grey.shade400,
//                               minimumSize: const Size(200, 50),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Text(
//                                   'Update Password',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontFamily: 'Satoshi',
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                                 const SizedBox(width: 5),
//                                 Image.asset(
//                                   'assets/update_check.png',
//                                   width: 23,
//                                   height: 23,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),//Testing1234@

//       ),
//     );
//   }
// }



// class UpdatePasswordScreen extends StatefulWidget {
//   final String email;
//   const UpdatePasswordScreen({super.key, required this.email});

//   @override
//   State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
// }

// class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   bool isButtonEnabled = false;
//   String? passwordError;
//   String? confirmPasswordError;

//   @override
//   void initState() {
//     super.initState();
//     passwordController.addListener(validatePasswords);
//     confirmPasswordController.addListener(validatePasswords);
//   }

//   void validatePasswords() {
//     final password = passwordController.text.trim();
//     final confirmPassword = confirmPasswordController.text.trim();

//     setState(() {
//       if (password.isEmpty || confirmPassword.isEmpty) {
//         passwordError = null;
//         confirmPasswordError = null;
//         isButtonEnabled = false;
//       } else if (password.length < 8) {
//         passwordError = 'Password must be at least 8 characters';
//         confirmPasswordError = null;
//         isButtonEnabled = false;
//       } else if (password != confirmPassword) {
//         passwordError = null;
//         confirmPasswordError = 'Passwords do not match';
//         isButtonEnabled = false;
//       } else {
//         passwordError = null;
//         confirmPasswordError = null;
//         isButtonEnabled = true;
//       }
//     });
//   }

//   @override
//   void dispose() {
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       extendBodyBehindAppBar: true,
//       body: DecoratedBox(
//         decoration: boxDecoration(),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 minHeight: MediaQuery.of(context).size.height -
//                     MediaQuery.of(context).padding.vertical,
//               ),
//               child: IntrinsicHeight(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             InkWell(
//                               onTap: () => Navigator.pop(context),
//                               child: const CircleAvatar(
//                                 radius: 19,
//                                 backgroundColor: Colors.white,
//                                 child: Icon(Icons.arrow_back, color: Colors.black, size: 19),
//                               ),
//                             ),
//                             const SizedBox(width: 17),
//                             const Text(
//                               'Update Password',
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 color: Colors.black87,
//                                 fontWeight: FontWeight.w700,
//                                 fontFamily: 'Satoshi',
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 60),
//                         Image.asset('assets/logo.png', height: 120, width: 115),
//                         const SizedBox(height: 20),
//                         const Text('Update Your Password',
//                             style: TextStyle(
//                               fontSize: 32,
//                               fontWeight: FontWeight.w700,
//                               fontFamily: 'Satoshi',
//                             )),
//                         const SizedBox(height: 5),
//                         const Text("A fresh password for fresh start",
//                             style: TextStyle(
//                               fontFamily: 'Satoshi',
//                               fontSize: 24,
//                               color: Color(0xff666F80),
//                               fontWeight: FontWeight.w700,
//                             )),
//                         const SizedBox(height: 40),
//                         CustomTextFieldWidget(
//                           borderColor: Constants().themeColor,
//                           controller: passwordController,
//                           hintText: 'New Password',
//                           labelText: 'New Password',
//                           textWidgetText: 'New Password',
//                           hintTextColor: Constants().themeColor,
//                           errorText: passwordError,
//                           obscureText: true,
//                         ),
//                         const SizedBox(height: 10),
//                         CustomTextFieldWidget(
//                           borderColor: Constants().themeColor,
//                           controller: confirmPasswordController,
//                           hintText: 'Confirm Password',
//                           labelText: 'Confirm Password',
//                           textWidgetText: 'Confirm Password',
//                           hintTextColor: Constants().themeColor,
//                           errorText: confirmPasswordError,
//                           obscureText: true,
//                         ),
//                         const SizedBox(height: 10),
//                         SizedBox(
//                           width: 342,
//                           height: 60,
//                           child: ElevatedButton(
//                             onPressed: isButtonEnabled
//                                 ? () {
//                                     context.read<ForgetPasswordBloc>().add(
//                                           ResetForgetPassword(
//                                             email: widget.email,
//                                             password: passwordController.text.trim(),
//                                             confirmPassword:
//                                                 confirmPasswordController.text.trim(),
//                                           ),
//                                         );
//                                   }
//                                 : null,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Constants().themeColor,
//                               disabledBackgroundColor: Colors.grey.shade400,
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
//                                   'Update Password',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontFamily: 'Satoshi',
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                                 const SizedBox(width: 5),
//                                 Image.asset(
//                                   'assets/update_check.png',
//                                   width: 23,
//                                   height: 23,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
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



// class UpdatePasswordScreen extends StatelessWidget {
//   String email;
//   UpdatePasswordScreen({required this.email});
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();

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
//                             'Update Password',
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
//                       const Text('Update Your Password',
//                           style: TextStyle(
//                             fontSize: 32,
//                             fontWeight: FontWeight.w700,
//                             fontFamily: 'Satoshi',
//                           )),
//                       const SizedBox(height: 5),
//                       const Text("A fresh password for fresh start",
//                           style: TextStyle(
//                               fontFamily: 'Satoshi',
//                               fontSize: 24,
//                               color: Color(0xff666F80),
//                               fontWeight: FontWeight.w700)),
//                       const SizedBox(height: 40),
//                       CustomTextFieldWidget(
//                         borderColor: Constants().themeColor,
//                         controller: passwordController,
//                         hintText: 'New Password',
//                         labelText: 'New Password',
//                         textWidgetText: 'New Password',
//                         hintTextColor: Constants().themeColor,
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       CustomTextFieldWidget(
//                         borderColor: Constants().themeColor,
//                         controller: confirmPasswordController,
//                         hintText: 'Confirm Password',
//                         labelText: 'Confirm Password',
//                         textWidgetText: 'Confirm Password',
//                         hintTextColor: Constants().themeColor,
//                       ),
//                       const SizedBox(height: 10),
//                       SizedBox(
//                         width: 342,
//                         height: 60,
//                         child: Center(
//                           child: ElevatedButton(
//                             onPressed: () {
//                               context
//                                   .read<ForgetPasswordBloc>()
//                                   .add(ResetForgetPassword(
//                                     email: email,
//                                     password: passwordController.text.trim(),
//                                     confirmPassword: confirmPasswordController.text.trim(),
//                                   ));

//                               // Navigator.push(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //         builder: (context) =>
//                               //             ForgetPasswordOtpVerificationScreen()));
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
//                                   'Update Password',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontFamily: 'Satoshi',
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                                 const SizedBox(width: 5),
//                                 Image.asset(
//                                   'assets/update_check.png',
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
