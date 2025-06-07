import 'package:flutter/material.dart';

import '../../Constants/constants.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/custom_textwidget.dart';
import '../../widgets/customscfaffold_widget.dart';

class SubscriptionSuccess extends StatelessWidget {
  String image;
  SubscriptionSuccess({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
        isAppBarContentRequired: false,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 36.0, vertical: 90),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image (replace with your own asset if needed)
                  SizedBox(
                    height: 140,
                    child: Image.asset(
                      image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 25),
                  CustomTextWidget(
                      text: "Subscribed",
                      color: Constants().themeColor,
                      textSize: 40,
                      fontWeight: FontWeight.w700),

                  const SizedBox(height: 8),
                  CustomTextWidget(
                      text: "Would you like to",
                      color: Colors.black,
                      textSize: 32,
                      fontWeight: FontWeight.w500),

                  const SizedBox(height: 25),
                  CustomButton(
                    onTap: () {},
                    buttonText: 'Go to MyGeo',
                    iconName: 'assets/loginbuttonicon.png',
                  ),

                  /*    SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3D7BFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Go to MyGeo →",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),*/

                  const SizedBox(height: 12),

                  CustomTextWidget(
                      text: "OR",
                      color: Colors.black,
                      textSize: 18,
                      fontWeight: FontWeight.w400),

                  const SizedBox(height: 12),
                  CustomButton(
                    onTap: () {},
                    buttonText: 'New Search',
                    iconName: 'assets/loginbuttonicon.png',
                  ),

                  // New Search button
                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 45,
                  //   child: ElevatedButton(
                  //     onPressed: () {},
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: const Color(0xFF3D7BFF),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //       elevation: 0,
                  //     ),
                  //     child: const Text(
                  //       "New Search ↗",
                  //       style: TextStyle(fontSize: 16),
                  //     ),
                  //   ),
                  // ),

                  const SizedBox(height: 12),
                  CustomButton(
                    onTap: () {},
                    buttonText: 'Invite a Friend',
                    iconName: 'assets/loginbuttonicon.png',
                  ),

                  // Invite a Friend button
                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 45,
                  //   child: ElevatedButton(
                  //     onPressed: () {},
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: const Color(0xFF3D7BFF),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //       elevation: 0,
                  //     ),
                  //     child: const Text(
                  //       "Invite a Friend ↗",
                  //       style: TextStyle(fontSize: 16),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
        appbartitle: '');
  }
}
