import 'package:flutter/material.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../Constants/constants.dart';
import 'login_success_screen.dart';


class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    with CodeAutoFill {
  String codeValue = "";

  @override
  void initState() {
    super.initState();

    // Delay SMS listening to avoid triggering setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      listenForCode();
    });

    _getAppSignature();
  }

  void _getAppSignature() async {
    final signature = await SmsAutoFill().getAppSignature;
    print("App Signature: $signature");
  }

  @override
  void codeUpdated() {
    final newCode = code ?? "";
    if (newCode != codeValue) {
      Future.microtask(() {
        if (mounted) {
          setState(() {
            codeValue = newCode;
          });
          if (newCode.length == 4) {
            FocusScope.of(context).unfocus(); // Close keyboard on auto-fill
          }
        }
      });
    }
  }

  @override
  void dispose() {
    cancel(); // Stop listening for SMS
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return CustomScaffoldWidget(
      showNotificationIcon: false,
      appbartitle: 'Verification',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Center(
              child: Image.asset(
                "assets/lock.png",
                height: 120,
                width: 120,
              ),
            ),
            Center(
              child: Column(
                children: [
                  const Text(
                    "Verification Code",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'satoshi',
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "code has been sent to +923042727074",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontFamily: 'satoshi',
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    height: 64,
                    width: 299,
                    child: PinFieldAutoFill(
                      autoFocus: true,
                      codeLength: 4,
                      currentCode: codeValue,
                      onCodeChanged: (code) {
                        Future.microtask(() {
                          if (mounted) {
                            setState(() {
                              codeValue = code ?? "";
                            });
                            if ((code ?? "").length == 4) {
                              FocusScope.of(context)
                                  .unfocus(); // Close keyboard
                            }
                          }
                        });
                      },
                      onCodeSubmitted: (code) {
                        print('Submitted: $code');
                      },
                      keyboardType: TextInputType.number,
                      decoration: BoxLooseDecoration(
                        strokeColorBuilder:
                            FixedColorBuilder(const Color(0xFF4C6FEE)),
                        gapSpace: 10,
                        bgColorBuilder: FixedColorBuilder(Colors.white),
                        radius: const Radius.circular(16),
                        textStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "00:00",
                    style: TextStyle(
                      color: Constants().themeColor,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'satoshi',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't get OTP code? ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'satoshi',
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Resend Code",
                        style: TextStyle(
                          color: Constants().themeColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'satoshi',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 342,
                    height: 60,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginSuccessScreen(),
                            ),
                          );
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
                              'Verify',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Satoshi',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 3),
                            const Icon(Icons.north_east,
                                size: 20, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    with CodeAutoFill {
  String codeValue = "";

  @override
  void initState() {
    super.initState();

    // Delay SMS listening to avoid triggering setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      listenForCode();
    });

    _getAppSignature();
  }

  void _getAppSignature() async {
    final signature = await SmsAutoFill().getAppSignature;
    print("App Signature: $signature");
  }

  @override
  void codeUpdated() {
    final newCode = code ?? "";
    if (newCode != codeValue) {
      Future.microtask(() {
        if (mounted) {
          setState(() {
            codeValue = newCode;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    cancel(); // Stop listening for SMS
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return CustomScaffoldWidget(
      showNotificationIcon: false,
      appbartitle: 'Verification',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Center(
              child: Image.asset(
                "assets/lock.png",
                height: 120,
                width: 120,
              ),
            ),
            Center(
              child: Column(
                children: [
                  const Text(
                    "Verification Code",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'satoshi'),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "code has been sent to +923042727074",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontFamily: 'satoshi'),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    height: 64,
                    width: 299,
                    child: PinFieldAutoFill(
                      autoFocus: false,
                      codeLength: 4,
                      currentCode: codeValue,
                      onCodeChanged: (code) {
                        Future.microtask(() {
                          if (mounted) {
                            setState(() {
                              codeValue = code ?? "";
                            });
                          }
                        });
                      },
                      onCodeSubmitted: (code) {
                        print('Submitted: $code');
                      },
                      keyboardType: TextInputType.number,
                      decoration: BoxLooseDecoration(
                        strokeColorBuilder:
                            FixedColorBuilder(const Color(0xFF4C6FEE)),
                        gapSpace: 10,
                        bgColorBuilder: FixedColorBuilder(Colors.white),
                        radius: const Radius.circular(16),
                        textStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "00:00",
                    style: TextStyle(
                        color: Constants().themeColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'satoshi'),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't get OTP code? ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'satoshi',
                            fontSize: 16),
                      ),
                      Text(
                        "Resend Code",
                        style: TextStyle(
                            color: Constants().themeColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'satoshi',
                            fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 342,
                    height: 60,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginSuccessScreen()));
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
                              'Verify',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Satoshi',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 3),
                            Icon(Icons.north_east,
                                size: 20, color: Colors.white)
                            // Image.asset(
                            //   'assets/loginbuttonicon.png',
                            //   width: 23,
                            //   height: 23,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/


// class VerificationScreen extends StatefulWidget {
//   const VerificationScreen({super.key});

//   @override
//   State<VerificationScreen> createState() => _VerificationScreenState();
// }

// class _VerificationScreenState extends State<VerificationScreen>
//     with CodeAutoFill {
//   String codeValue = "";

//   @override
//   void initState() {
//     super.initState();
//     listenForCode(); // start listening for SMS autofill
//     _getAppSignature();
//   }

//   void _getAppSignature() async {
//     final signature = await SmsAutoFill().getAppSignature;
//     print("App Signature: $signature");
//   }

//   @override
//   void codeUpdated() {
//     final newCode = code ?? "";
//     if (newCode != codeValue) {
//       Future.microtask(() {
//         if (mounted) {
//           setState(() {
//             codeValue = newCode;
//           });
//         }
//       });
//     }
//   }

//   // @override
//   // void codeUpdated() {
//   //   WidgetsBinding.instance.addPostFrameCallback((_) {
//   //     if (mounted) {
//   //       setState(() {
//   //         codeValue = code ?? "";
//   //       });
//   //     }
//   //   });
//   // }

//   @override
//   void dispose() {
//     cancel(); // stop listening
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return CustomScaffoldWidget(
//       appbartitle: 'Verification',
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 50),
//           Center(
//             child: Column(
//               children: [
//                 const Text(
//                   "Verification Code",
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   "code has been sent to +923042727074",
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.black54,
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//                 Container(
//                   height: 64,
//                   width: 284,
//                   child: PinFieldAutoFill(
//                     codeLength: 4,
//                     currentCode: codeValue,
//                     onCodeChanged: (code) {
//                       setState(() {
//                         codeValue = code ?? "";
//                       });
//                     },
//                     onCodeSubmitted: (code) {
//                       print('Submitted: $code');
//                     },
//                     keyboardType: TextInputType.number,
//                     decoration: BoxLooseDecoration(
//                       strokeColorBuilder:
//                           FixedColorBuilder(const Color(0xFF4C6FEE)),
//                       gapSpace: 10,
//                       bgColorBuilder: FixedColorBuilder(Colors.white),
//                       radius: const Radius.circular(16),
//                       textStyle: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   "00:00",
//                   style: TextStyle(
//                     color: Colors.blueAccent,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Text("Didn't get OTP code? "),
//                     Text(
//                       "Resend Code",
//                       style: TextStyle(
//                         color: Color(0xFF4C6FEE),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 30),
//                 ElevatedButton(
//                   onPressed: () {
//                     print("Verifying code: $codeValue");
//                   },
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: Size(size.width * 0.9, 50),
//                     backgroundColor: const Color(0xFF4C6FEE),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(28),
//                     ),
//                   ),
//                   child: const Text(
//                     "Verify →",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
