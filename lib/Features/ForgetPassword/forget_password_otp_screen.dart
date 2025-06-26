import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../Constants/constants.dart';
import '../../widgets/boxDecorationWidget.dart';
import '../../widgets/toast_widget.dart';
import 'bloc/forget_password_bloc.dart';
import 'bloc/forget_password_event.dart';
import 'bloc/forget_password_state.dart';
import 'package:get_storage/get_storage.dart';

class ForgetPasswordOtpVerificationScreen extends StatefulWidget {
  final String email;
  // final String password;

  ForgetPasswordOtpVerificationScreen({
    //  Key? key,
    required this.email,
    //required this.password,
  });

  @override
  State<ForgetPasswordOtpVerificationScreen> createState() =>
      _ForgetPasswordOtpVerificationScreenState();
}

class _ForgetPasswordOtpVerificationScreenState
    extends State<ForgetPasswordOtpVerificationScreen> with CodeAutoFill {
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          child: Image.asset("assets/lock.png",
                              height: 120, width: 120)),
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
                        "Code has been sent to ${widget.email}",
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
                            strokeColorBuilder:
                                FixedColorBuilder(Constants().themeColor),
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
                                toastWidget("OTP code resent", Colors.green);
                              } else {
                                toastWidget(
                                    "Please wait $timerText", Colors.red);
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
                          if (state is ForgetPasswordOtpVerifiedSuccess) {
                            print("OTP Verified Token: ${state.token}");
                            final box = GetStorage();
                            box.write("token", state.token);

                            toastWidget(
                                "Password reset successfully", Colors.green);

                            // Navigator.of(context).pushAndRemoveUntil(
                            //   MaterialPageRoute(
                            //     builder: (_) => const LoginSuccessScreen(),
                            //   ),
                            //   (route) => false,
                            // );
                          } else if (state
                              is ForgetPasswordOtpVerifiedFailure) {
                            toastWidget(state.error, Colors.red);
                          }
                        },
                        builder: (context, state) {
                          return SizedBox(
                            width: 376,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: (codeValue.length == 4 &&
                                      state is! ForgetPasswordLoading)
                                  ? () {
                                      context.read<ForgetPasswordBloc>().add(
                                          SubmitForgetPasswordOtp(
                                              email:
                                                  "testuser1@yopmail.com", //widget.email,
                                              otp: codeValue,
                                              password: "" //widget.password,
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
                                    horizontal: 20, vertical: 10),
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
                                  const Icon(Icons.north_east,
                                      size: 21, color: Colors.white),
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
    );
  }
}
