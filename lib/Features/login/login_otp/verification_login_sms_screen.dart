import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readytogo/widgets/toast_widget.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readytogo/Features/login/bloc/login_bloc.dart';
import 'dart:async';
import '../../../Constants/constants.dart';
import '../../../widgets/boxDecorationWidget.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../login_success_screen.dart';

class VerificationLoginSMSScreenOTP extends StatefulWidget {
  final String phoneNumber;

  const VerificationLoginSMSScreenOTP({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<VerificationLoginSMSScreenOTP> createState() =>
      _VerificationLoginSMSScreenOTPState();
}

class _VerificationLoginSMSScreenOTPState
    extends State<VerificationLoginSMSScreenOTP> with CodeAutoFill {
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
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.verificationLoginThroughSMS ==
                  VerificationLoginThroughSMS.success) {
                   final box = GetStorage();
                box.write("token", state.token);
                toastWidget("Logged-in Successfully", Colors.green);
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginSuccessScreen()),
                  (route) => false,
                );
              } else if (state.verificationLoginThroughSMS ==
                  VerificationLoginThroughSMS.failure) {
                toastWidget("Incorrect Code", Colors.red);
              }
            }, 
            builder: (context, state) {
              final isLoading = state.verificationLoginThroughSMS ==
                  VerificationLoginThroughSMS.loading;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.vertical,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
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
                                height: 120, width: 120),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Verification Code",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Satoshi',
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Code has been sent to ${widget.phoneNumber}",
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
                                Future.microtask(() {
                                  if (mounted) {
                                    setState(() => codeValue = code ?? "");
                                    if ((code ?? "").length == 4) {
                                      FocusScope.of(context).unfocus();
                                    }
                                  }
                                });
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
                                    final storage = GetStorage();
                                    var password =
                                        storage.read("password_login");

                                    context.read<LoginBloc>().add(
                                        LoginThroughSMSOtpRequestNew(
                                            password: password,
                                            phone: widget.phoneNumber));

                                    toastWidget(
                                        "OTP code resent", Colors.green);
                                  } else {
                                    toastWidget(
                                        "Wait for $timerText", Colors.red);
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: (codeValue.length == 4 && !isLoading)
                                  ? () {
                                      context.read<LoginBloc>().add(
                                            VerificationLoginThroughSMSOtpLoginRequest(
                                              phone: widget.phoneNumber,
                                              otp: codeValue,
                                            ),
                                          );
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
                                  isLoading
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
                                print("Click");
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => LoginScreen()));
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
                                    'Try through Email', //10@Testing
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
              );
            },
          ),
        ),
      ),
    );
  }
}

String getResendText(String timerText) {
  final parts = timerText.split(':');
  final minutes = int.parse(parts[0]);
  final seconds = int.parse(parts[1]);

  if (minutes > 0) {
    return 'You can resend the code in $minutes minute${minutes > 1 ? 's' : ''} '
        '${seconds > 0 ? '$seconds second${seconds > 1 ? 's' : ''}' : ''}.';
  } else {
    return 'You can resend the code in $seconds second${seconds > 1 ? 's' : ''}.';
  }
}
