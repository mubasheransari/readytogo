import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:readytogo/Features/login/login_screen.dart';
import 'package:readytogo/Features/privacy_policy.dart';
import 'package:readytogo/Features/release_of_information.dart';
import 'package:readytogo/Features/terms_and_condition.dart';

import '../Constants/constants.dart';
import '../widgets/boxDecorationWidget.dart';

bool isChecked = false;

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      decoration: boxDecoration(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 40,
            ),
            const Text(
              'Signup & Improve Your Health Today',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                fontFamily: 'Satoshi',
              ),
            ),

            SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/Frame.png',
                height: 120,
                width: 120,
              ),
            ),
            SizedBox(height: 25),
            // Form fields with labels separated
            _buildTextField('First Name', 'Enter First Name'),
            SizedBox(height: 15),
            _buildTextField('Last Name', 'Enter Last Name'),
            SizedBox(height: 15),
            _buildTextField('Email', 'Enter Email'),
            SizedBox(height: 15),
            _buildTextField('Phone Number', 'Enter Phone Number'),
            SizedBox(height: 15),
            _buildTextField('Zip Code', 'Enter Zip Code'),
            SizedBox(height: 15),
            _buildTextField('Password', 'min. 8 characters', obscureText: true),
            SizedBox(height: 15),
            _buildTextField('Confirm Password', 'Type again',
                obscureText: true),
            SizedBox(height: 15),
            _buildTextField('Referral Code (optional)', 'Enter Referral Code'),
            SizedBox(height: 40),
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  activeColor: Constants().themeColor,
                  checkColor: Colors.white,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontFamily: 'Satoshi',
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'I have read & accept ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TermsAndConditionScreen()));
                            },
                        ),
                        TextSpan(
                          text: ', ',
                        ),
                        TextSpan(
                          text: 'release of information ',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReleaseOfInformationScreen()));
                            },
                        ),
                        TextSpan(
                          text: '& ',
                        ),
                        TextSpan(
                          text: 'privacy policy',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PrivacyPolicyScreen()));
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 40),
            SizedBox(
              width: 376,
              height: 60,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "User Registered Successuly",
                          style: TextStyle(
                            fontSize: 16, // Customize text size
                            fontWeight:
                                FontWeight.bold, // Customize text weight
                          ),
                        ),
                        duration: Duration(
                            seconds:
                                2), // Duration for how long the snackbar will be shown
                        backgroundColor: Constants()
                            .themeColor, // Customize background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Customize the corners of the snackbar
                        ),
                        behavior: SnackBarBehavior
                            .floating, // Floating snackbar instead of normal
                        margin:
                            EdgeInsets.all(16), // Custom margin for positioning
                        // action: SnackBarAction(
                        //   label: 'Undo',  // Action label text
                        //   textColor: Colors.white, // Customize action text color
                        //   onPressed: () {
                        //     // Define the action when the user taps the 'Undo' button
                        //     print("Undo action pressed!");
                        //   },
                        // ),
                      ),
                    );
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
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
                        'Register',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Satoshi',
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(width: 5),
                      Image.asset(
                        'assets/loginbuttonicon.png',
                        width: 23,
                        height: 23,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Register button
            /*   ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4C6FEE),
                minimumSize: Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),*/
            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                    width: 120,
                    child: Divider(
                      color: Colors.black38,
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('or',
                      style: TextStyle(
                          fontFamily: 'Satoshi',
                          fontSize: 20,
                          color: Color(0xff28363D),
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  width: 8,
                ),
                SizedBox(
                    width: 120,
                    child: Divider(
                      color: Colors.black38,
                    )),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 376,
              height: 60,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: Image.asset(
                  'assets/Google.png',
                  width: 32,
                  height: 32,
                ),
                label: Text(
                  'Join with Google',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Satoshi',
                      fontSize: 20,
                      color: Color(0xff323747)),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Color(0xFFDB4437)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),

            // OutlinedButton.icon(
            //   onPressed: () {},
            //   icon: Image.asset(
            //     'assets/google_logo.png', // Add Google logo in your assets
            //     width: 32,
            //     height: 32,
            //   ),
            //   label: Text(
            //     'Join with Google',
            //     style: TextStyle(
            //       fontWeight: FontWeight.w400,
            //       fontFamily: 'Satoshi',
            //       fontSize: 20,
            //       color: Color(0xff323747),
            //     ),
            //   ),
            //   style: OutlinedButton.styleFrom(
            //     backgroundColor: Colors.white,
            //     side: BorderSide(color: Color(0xFFDB4437)),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //     padding: EdgeInsets.symmetric(vertical: 15),
            //   ),
            // ),
            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                    style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: 20,
                        color: Color(0xff323747),
                        fontWeight: FontWeight.w700)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(" Login",
                      style: TextStyle(
                          fontFamily: 'Satoshi',
                          fontSize: 20,
                          color: Constants().themeColor,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ]),
        ),
      ),
    ));
  }

  Widget _buildTextField(String label, String hint,
      {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label Text
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            fontFamily: 'Satoshi',
            color: Color(0xff323747),
          ),
        ),
        SizedBox(height: 5),
        // TextField
        SizedBox(
          width: 376,
          height: 60,
          child: TextField(
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Color(0xff666F80),
                fontSize: 18,
                fontFamily: 'Satoshi',
                fontWeight: FontWeight.w500,
              ),
              filled: true,
              fillColor: Colors.white,
              // Circular border with no color (transparent)
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16), // Circular border
                borderSide: BorderSide.none, // No border color
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16), // Circular border
                borderSide: BorderSide.none, // No border color on focus
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16), // Circular border
                borderSide: BorderSide.none, // No border color when enabled
              ),
            ),
          ),
        ),
      ],
    );
  }
}
