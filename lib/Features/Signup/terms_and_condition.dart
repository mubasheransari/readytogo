import 'package:flutter/material.dart';

import '../../Constants/constants.dart';
import '../../widgets/boxDecorationWidget.dart';

class TermsAndConditionScreen extends StatefulWidget {
  @override
  _TermsAndConditionScreenState createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
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
                      'Terms & Conditions',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Satoshi',
                      ),
                    ),
                  ],
                ),
                /*  Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.arrow_back, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Terms & Conditions',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff666F80),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Satoshi',
                      ),
                    ),
                  ],
                ),*/
                SizedBox(height: 40),
                const Text(
                  'Effective Date: 04/04/2004',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi',
                  ),
                ),
                SizedBox(height: 15),

                // Description
                const Text(
                  'By using the RRTG app, you agree to the following terms and conditions:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Satoshi',
                  ),
                ),
                SizedBox(height: 20),
                const Text(
                  '1. Use of the App',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi',
                  ),
                ),
                const Text(
                  'RRTG is designed for personal wellness use only. You must be at least 16 years old to use the app.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff666F80),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Satoshi',
                  ),
                ),
                SizedBox(height: 10),

                const Text(
                  '2. User Responsibilities',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi',
                  ),
                ),
                const Text(
                  'You agree not to misuse the app, share false data, or interfere with its functionality or content.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff666F80),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Satoshi',
                  ),
                ),
                SizedBox(height: 10),

                const Text(
                  '3. Health Disclaimer',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi',
                  ),
                ),
                const Text(
                  'RRTG provides wellness guidance, not medical advice. Always consult a professional for medical concerns.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff666F80),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Satoshi',
                  ),
                ),
                SizedBox(height: 10),

                const Text(
                  '4. Account & Access',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi',
                  ),
                ),
                const Text(
                  'You are responsible for maintaining your account confidentiality and ensuring accurate information.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff666F80),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Satoshi',
                  ),
                ),
                SizedBox(height: 10),

                const Text(
                  '5. Changes to Terms',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi',
                  ),
                ),
                const Text(
                  'RRTG may update these terms periodically. Continued use of the app means you accept any changes.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff666F80),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Satoshi',
                  ),
                ),
                SizedBox(height: 20),
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
                    Text('I agree to the Terms and Conditions.',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w700)),
                  ],
                ),

                // I Agree Checkbox
                /*  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    const Text(
                      'I Agree',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff666F80),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),*/
                SizedBox(height: 40),

                // Back and Next buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            // Image.asset(
                            //   'assets/arrow-narrow-left.png',
                            //   color: Color(0xff666F80),
                            // ),
                            Icon(Icons.arrow_back,
                                color: Color(0xff666F80), size: 24),
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
                      width: 10,
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
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
