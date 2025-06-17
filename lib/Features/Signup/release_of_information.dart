import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Constants/constants.dart';
import '../../widgets/boxDecorationWidget.dart';

class ReleaseOfInformationScreen extends StatefulWidget {
  @override
  _ReleaseOfInformationScreenState createState() =>
      _ReleaseOfInformationScreenState();
}

class _ReleaseOfInformationScreenState
    extends State<ReleaseOfInformationScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: ,
      //   leading: Image.asset("assets/arrow-narrow-left.png"),

      //   // IconButton(
      //   //   icon: Icon(Icons.arrow_back),
      //   //   onPressed: () {
      //   //     Navigator.pop(context); // Go back to the previous screen
      //   //   },
      //   // ),
      //   title: Text('Release Of Information'),
      // ),
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
                      'Release of Information',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Satoshi',
                      ),
                    ),
                  ],
                ),
                /* Row(
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
                    // Icon(Icons.arrow_back, color: Colors.white),

                    ///  Image.asset("assets/arrow-narrow-left.png"),
                    const Text(
                      'Release Of Information',
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
                  'By using the RRTG wellness app, you consent to the collection, storage, and use of your personal and wellness-related information as described in our Privacy Policy. In certain cases, and only with your explicit consent (except where legally required), we may release information for the following purposes:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323747), //color: Color(0xff666F80),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Satoshi',
                  ),
                ),
                SizedBox(height: 20),
                const Text(
                  '1. With Your Consent',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi',
                  ),
                ),

                // Numbered list for purposes
                const Text(
                  // '1. With Your Consent\n\n'
                  'We may share your data with third parties (e.g., wellness coaches, fitness partners, or health experts) only when you give clear, written or digital permission.\n',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff666F80),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Satoshi',
                  ),
                ),
                const Text(
                  '2. Legal Requirements',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi',
                  ),
                ),
                const Text(
                  'We may disclose information if required by law, regulation, subpoena, or government request.\n',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff666F80),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Satoshi',
                  ),
                ),

                const Text(
                  '3. Health & Safety',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323747),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi',
                  ),
                ),
                const Text(
                  'In cases where there is a serious threat to your health or safety or that of others, we may share limited data with appropriate parties to prevent harm.\n',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff666F80),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Satoshi',
                  ),
                ),
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
                    Text('I agree to the Release of Information.',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w700)),
                  ],
                ),
                // SizedBox(height: 20),

                // // I Agree Checkbox
                // Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     Checkbox(
                //       value: isChecked,
                //       onChanged: (bool? value) {
                //         setState(() {
                //           isChecked = value!;
                //         });
                //       },
                //     ),
                //     const Text(
                //       'I Agree',
                //       style: TextStyle(
                //         fontSize: 16,
                //         color: Color(0xff666F80),
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ],
                // ),
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
                          // Handle the back button
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
