import 'package:flutter/material.dart';
import 'package:readytogo/Features/ForgetPassword/update_password_screen.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../Constants/constants.dart';
import '../../widgets/boxDecorationWidget.dart';

class ForgetPasswordOtpVerificationScreen extends StatefulWidget {
  const ForgetPasswordOtpVerificationScreen({super.key});

  @override
  State<ForgetPasswordOtpVerificationScreen> createState() =>
      _ForgetPasswordOtpVerificationScreenState();
}

class _ForgetPasswordOtpVerificationScreenState
    extends State<ForgetPasswordOtpVerificationScreen> with CodeAutoFill {
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
                            'Verification',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Satoshi',
                            ),
                          ),
                        ],
                      ),
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
                                  strokeColorBuilder: FixedColorBuilder(
                                      const Color(0xFF4C6FEE)),
                                  gapSpace: 10,
                                  bgColorBuilder:
                                      FixedColorBuilder(Colors.white),
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
                                            builder: (context) =>
                                                UpdatePasswordScreen()));
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
                                      const SizedBox(width: 5),
                                      const Icon(Icons.north_east,
                                          size: 21, color: Colors.white),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
