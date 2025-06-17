import 'package:flutter/material.dart';

import '../../Constants/constants.dart';
import '../../widgets/boxDecorationWidget.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: boxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 76),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const CircleAvatar(
                        radius: 19,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.arrow_back,
                            color: Colors.black, size: 19),
                      ),
                    ),
                    const SizedBox(width: 17),
                    const Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Satoshi',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                const Text(
                  'At RRTG, your privacy is our priority. We are committed to protecting your personal data and providing transparency in how we collect, use, and safeguard your information.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi',
                  ),
                ),
                SizedBox(height: 15),

                // Section: Information We Collect
                const Text(
                  '1. Information We Collect',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi',
                  ),
                ),
                const Text(
                  '• Personal details (name, email, age, etc.)\n• Health and wellness preferences\n• App usage data for analytics and improvements\n',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff666F80),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Satoshi',
                  ),
                ),
                SizedBox(height: 10),

                // Section: How We Use Your Information
                const Text(
                  '2. How We Use Your Information',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi',
                  ),
                ),
                const Text(
                  '• To personalize your wellness experience\n• To improve app performance and functionality\n• To communicate updates, features, or offers\n',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff666F80),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Satoshi',
                  ),
                ),
                SizedBox(height: 10),

                // Section: Data Security
                const Text(
                  '3. Data Security',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi',
                  ),
                ),
                const Text(
                  'We implement industry-standard security measures to ensure your data is safe and protected from unauthorized access.\n',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff666F80),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Satoshi',
                  ),
                ),
                SizedBox(height: 10),

                // Section: Third-Party Services
                const Text(
                  '4. Third-Party Services',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi',
                  ),
                ),
                const Text(
                  'RRTG may use trusted third-party services to support features. We ensure these parties also uphold your privacy.\n',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff666F80),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Satoshi',
                  ),
                ),
                SizedBox(height: 20),

                // I Agree Checkbox
                Row(
                  children: [
                    // SizedBox(
                    //   width: 12,
                    // ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                      child: Container(
                        width: 21,
                        height: 21,
                        decoration: BoxDecoration(
                          color: isChecked
                              ? Constants().themeColor
                              : Colors.transparent,
                          borderRadius:
                              BorderRadius.circular(6), // Circular border
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                        child: isChecked
                            ? Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text('I agree to the Privacy Policy.',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w700)),
                  ],
                ),
                SizedBox(height: 40),

                // Back and Next buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 156,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Go back
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: Size(100, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: Color(0xff666F80),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Back',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xff666F80),
                                fontFamily: 'Satoshi',
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 156,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle the next button
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4C6FEE),
                          minimumSize: Size(100, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Next',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontFamily: 'Satoshi',
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward,
                                color: Colors.white, size: 24),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
