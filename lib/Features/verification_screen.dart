import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

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
    listenForCode(); // start listening for SMS autofill
    _getAppSignature();
  }

  void _getAppSignature() async {
    final signature = await SmsAutoFill().getAppSignature;
    print("App Signature: $signature");
  }

  @override
  void codeUpdated() {
    setState(() {
      codeValue = code ?? "";
    });
  }

  @override
  void dispose() {
    cancel(); // stop listening
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              const Text(
                "Verification",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: Column(
                  children: [
                    const Text(
                      "Verification Code",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "code has been sent to +923042727074",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 32),
                    PinFieldAutoFill(
                      codeLength: 4,
                    
                      currentCode: codeValue,
                      onCodeChanged: (code) {
                        setState(() {
                          codeValue = code ?? "";
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
                        radius: const Radius.circular(12),
                        textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "00:00",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Didn't get OTP code? "),
                        Text(
                          "Resend Code",
                          style: TextStyle(
                            color: Color(0xFF4C6FEE),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        print("Verifying code: $codeValue");
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(size.width * 0.9, 50),
                        backgroundColor: const Color(0xFF4C6FEE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: const Text(
                        "Verify →",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
