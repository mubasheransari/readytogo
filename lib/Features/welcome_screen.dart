import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';
import 'package:readytogo/Features/recoveryWellnessPlans.dart';

import '../widgets/boxDecorationWidget.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
       decoration: boxDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 45),
                // Logo or image
                Image.asset(
                  'assets/welcome.png', // Replace with your logo image
                  height: 120,
                  width: 120,
                ),
                const SizedBox(height: 40),

                Text(
                  'Thank You!',
                  style: TextStyle(
                    fontSize: 40,
                    color: Constants().themeColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi',
                  ),
                ),
                const SizedBox(height: 5),

                const Text(
                  'Welcome to Recovery \n"ready to go"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'Satoshi',
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 40),

                // Continue button
                SizedBox(
                  width: 376,
                  height: 60,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4C6FEE), // Blue color
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
                            'Continue', // Button text
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Satoshi',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Center(
                          //   child: Image.asset(
                          //     "assets/arrow-narrow-left.png",
                          //     height: 24,
                          //     width: 24,
                          //   ),
                          // )
                          Icon(Icons.arrow_forward,
                              color: Colors.white), // Right arrow icon
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Profile completion text
                const Text(
                  'Complete your profile by taking the',
                  style: TextStyle(
                    fontFamily: 'Satoshi',
                    fontSize: 20,
                    color: Color(0xff666F80),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // "2-Minute Assessment" text with blue color
                GestureDetector(
                  onTap: () {
                    // Navigate to the assessment screen
                  },
                  child: const Text(
                    '2-Minute Assessment',
                    style: TextStyle(
                      fontFamily: 'Satoshi',
                      fontSize: 20,
                      color: Color(0xFF4C6FEE),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 40),
                SizedBox(
                  width: 376,
                  height: 60,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RecoveryWellnessPlanScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Background color
                        side: BorderSide(
                          color: Constants()
                              .themeColor, // Outline color (theme color)
                          width: 1, // Width of the border
                        ),
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
                          Text(
                            'Assessment', // Button text
                            style: TextStyle(
                              color: Constants()
                                  .themeColor, // Text color (theme color)
                              fontFamily: 'Satoshi',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            color: Constants()
                                .themeColor, // Icon color (theme color)
                          ), // Right arrow icon
                        ],
                      ),
                    ),
                  ),
                ),

                // Assessment button
                //  SizedBox(
                //     width: 376,
                //     height: 60,
                //     child: Center(
                //       child: ElevatedButton(
                //         onPressed: () {},
                //         style: ElevatedButton.styleFrom(
                //           backgroundColor: Colors.white, // Blue color
                //           minimumSize: const Size(200, 50),
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(30),
                //           ),
                //           padding: const EdgeInsets.symmetric(
                //               horizontal: 20, vertical: 10),
                //         ),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Text(
                //               'Assessment', // Button text
                //               style: TextStyle(
                //                 color: Constants().themeColor,
                //                 fontFamily: 'Satoshi',
                //                 fontSize: 20,
                //                 fontWeight: FontWeight.w500,
                //               ),
                //             ),
                //             const SizedBox(width: 10),
                //             Icon(
                //               Icons.arrow_forward,
                //               color: Constants().themeColor,
                //             ), // Right arrow icon
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
