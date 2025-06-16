import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyCallScreen extends StatelessWidget {
  const EmergencyCallScreen({super.key});

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appbartitle: '',
      isAppBarContentRequired: false,
      showNotificationIcon: false,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.90,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Emergency Call",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            fontFamily: 'satoshi'),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Image.asset("assets/emergency.png", height: 120, width: 120),
                  // const Icon(Icons.phone_in_talk_rounded,
                  //     size: 60, color: Colors.blue),
                  const SizedBox(height: 20),
                  const Text(
                    "If This is An Immediate Emergency ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'satoshi'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "for Medical Emergency",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'satoshi'),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 240,
                    height: 60,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants().themeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 32, vertical: 12),
                      ),
                      icon: Image.asset(
                        "assets/phone_rounded.png",
                        height: 24,
                        width: 24,
                      ),
                      label: Text(
                        "CALL 911",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'satoshi'),
                      ),
                      onPressed: () => _makePhoneCall("911"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "or",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'satoshi'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "for Suicide Lifeline",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'satoshi'),
                  ),

                  const SizedBox(height: 10),
                  SizedBox(
                    width: 240,
                    height: 60,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants().themeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 32, vertical: 12),
                      ),
                      icon: Image.asset(
                        "assets/phone_rounded.png",
                        height: 24,
                        width: 24,
                      ),
                      label: Text(
                        "CALL 988",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'satoshi'),
                      ),
                      onPressed: () => _makePhoneCall("988"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
