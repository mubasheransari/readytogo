import 'package:flutter/material.dart';

import '../widgets/boxDecorationWidget.dart';

class HowToUseScreen extends StatefulWidget {
  @override
  _HowToUseScreenState createState() => _HowToUseScreenState();
}

class _HowToUseScreenState extends State<HowToUseScreen> {
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
                SizedBox(height: 40),
                Row(
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
                    SizedBox(width: 90),
                    const Text(
                      'How To Use',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff323747),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Satoshi',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                const Text(
                  'Effective Date: ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Satoshi',
                  ),
                ),
                RichText(
                  text: const TextSpan(
                    text: '04/04/2004',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff323747),
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                const Text(
                  'Welcome to RRTG, your wellness companion. By downloading, installing, or using the RRTG app, you agree to be bound by the following terms and conditions:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Satoshi',
                  ),
                ),
                SizedBox(height: 25),
                const Text(
                  '1. Acceptance of Terms',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi',
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'By accessing or using the RRTG app, you acknowledge that you have read, understood, and agreed to be bound by this User Agreement and our Privacy Policy.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Satoshi',
                  ),
                ),
                SizedBox(height: 15),
                const Text(
                  '2. Eligibility',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi',
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'You must be at least 16 years old to use the app. If you are under 18, you must have parental or guardian consent.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Satoshi',
                  ),
                ),
                SizedBox(height: 15),
                const Text(
                  '3. Use of the App',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi',
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'You agree to use the app only for personal wellness purposes and not for any illegal or unauthorized activity.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Satoshi',
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      activeColor: Color(0xFF4C6FEE),
                    ),
                    const Text(
                      'I Agree',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff323747),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: isChecked
                        ? () {
                            // Handle Update button pressed
                          }
                        : null,
                    icon: Icon(
                      Icons.check,
                      size: 20,
                      color: isChecked ? Colors.white : Colors.black,
                    ),
                    label: Text(
                      'Update',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        fontFamily: 'Satoshi',
                        color: isChecked ? Colors.white : Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4C6FEE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
