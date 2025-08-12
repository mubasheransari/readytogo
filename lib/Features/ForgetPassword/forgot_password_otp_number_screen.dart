import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readytogo/Features/ForgetPassword/update_password_screen.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../Constants/constants.dart';
import '../../widgets/boxDecorationWidget.dart';
import '../../widgets/toast_widget.dart';
import '../login/verification_screen.dart';
import 'bloc/forget_password_bloc.dart';
import 'bloc/forget_password_event.dart';
import 'bloc/forget_password_state.dart';
import 'forget_password_screen.dart';
import 'forgot_password_number.dart';

class ForgetPasswordOtpNumberScreen extends StatefulWidget {
  final String phone;
  // final String password; Testing1234@

  ForgetPasswordOtpNumberScreen({
    //  Key? key,
    required this.phone,
  });

  @override
  State<ForgetPasswordOtpNumberScreen> createState() =>
      _ForgetPasswordOtpNumberScreenState();
}

class _ForgetPasswordOtpNumberScreenState
    extends State<ForgetPasswordOtpNumberScreen> with CodeAutoFill {
  String codeValue = "";
  late Timer _timer;
  int _remainingSeconds = 120;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      listenForCode();
    });
    _getAppSignature();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  String get timerText {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
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
            FocusScope.of(context).unfocus();
          }
        }
      });
    }
  }

  @override
  void dispose() {
    cancel();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var token = box.read("token-forgetPassword");
    print("TOKEN $token");
    print("TOKEN $token");
    print("TOKEN $token");
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
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const CircleAvatar(
                              radius: 19,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 19,
                              ),
                            ),
                          ),
                          const SizedBox(width: 17),
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
                      const SizedBox(height: 16),
                      const Text(
                        "Verification Code",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Satoshi',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Code has been sent to ${widget.phone}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Constants().greyColor,
                          fontFamily: 'Satoshi',
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        height: 64,
                        width: 299,
                        child: PinFieldAutoFill(
                          autoFocus: true,
                          codeLength: 4,
                          currentCode: codeValue,
                          onCodeChanged: (code) {
                            setState(() => codeValue = code ?? "");
                          },
                          keyboardType: TextInputType.number,
                          decoration: BoxLooseDecoration(
                            strokeColorBuilder: FixedColorBuilder(
                              Constants().themeColor,
                            ),
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
                        timerText,
                        style: TextStyle(
                          fontSize: 16,
                          color: Constants().themeColor,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Satoshi',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Didn't get OTP code? ",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Satoshi',
                              fontSize: 16,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (_remainingSeconds == 0) {
                                setState(() => _remainingSeconds = 120);
                                _startTimer();
                                //    FocusScope.of(context).unfocus();
                                context.read<ForgetPasswordBloc>().add(
                                      RequestForgetPasswordOtpSMS(
                                        phone: widget.phone,
                                      ),
                                    );

                                // final box = GetStorage();
                                // var email = box.read("forgotPassword-email");
                                // context.read<ForgetPasswordBloc>().add(
                                //       ForgetPasswordToken(
                                //         email: email.trim(),
                                //       ),
                                //     );
                                // context.read<ForgetPasswordBloc>().add(
                                //       RequestForgetPasswordOtp(
                                //         email: widget.email,
                                //       ),
                                //     );
                                toastWidget("OTP code resent", Colors.green);
                              } else {
                                toastWidget(
                                  getResendText(timerText),
                                  Colors.red,
                                );
                              }
                            },
                            child: Text(
                              "Resend Code",
                              style: TextStyle(
                                color: Constants().themeColor,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Satoshi',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      /// ✅ BlocConsumer with ForgetPasswordBloc
                      BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
                        listener: (context, state) {
                          if (state
                              is ForgetPasswordVerificationSuccessNumber) {
                            // print("OTP Verified Token: ${state.token}");
                            // final box = GetStorage();
                            // box.write("token", state.token);

                            toastWidget(
                              "Verification successful. You can now change your password.",
                              Colors.green,
                            );
                            final box = GetStorage();
                            var email = box.read("forgotPassword-email");

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    UpdatePasswordScreen(email: email),
                              ),
                            );
                          } else if (state
                              is ForgetPasswordVerificationFailureNumber) {
                            toastWidget(
                              "Wrong or Expired OTP Code",
                              Colors.red,
                            );
                          }
                        },
                        builder: (context, state) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: (codeValue.length == 4 &&
                                      state is! ForgetPasswordLoading)
                                  ? () {
                                      context.read<ForgetPasswordBloc>().add(
                                              SubmitForgetPasswordOtpThroughNumber(
                                            phone: widget.phone,
                                            otp: codeValue,
                                          ));
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Constants().themeColor,
                                minimumSize: const Size(200, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  state is ForgetPasswordLoading
                                      ? const SizedBox(
                                          width: 25,
                                          height: 25,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text(
                                          'Verify',
                                          style: TextStyle(
                                            letterSpacing: 1,
                                            color: Colors.white,
                                            fontFamily: 'Satoshi',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.north_east,
                                    size: 21,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 50,
                        // width: 376,
                        // height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            print("Click");//100@Testing
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgetPasswordScreen()));
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
                                'Try through Email',
                                style: TextStyle(
                                  letterSpacing: 1,
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
                      )
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
