import 'package:flutter/material.dart';
import 'package:readytogo/Features/Donate/add_new_card.dart';
import 'package:readytogo/Features/home_screen.dart';
import 'package:readytogo/Features/login/emergency_call_screen.dart';
import 'package:readytogo/Features/login/invite_friend.dart';
import 'package:readytogo/widgets/boxDecorationWidget.dart';

import '../../Constants/constants.dart';

class LoginSuccessScreen extends StatelessWidget {
  const LoginSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: DecoratedBox(
            decoration: boxDecoration(),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.20,
                  ),
                  Image.asset('assets/logo.png', height: 120, width: 115),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  CustomTextWidget(
                      text: "Welcome Back",
                      color: Colors.black87,
                      textSize: 30,
                      fontWeight: FontWeight.w500),
                  CustomTextWidget(
                      text: "Peter Patrick",
                      color: Constants().themeColor,
                      textSize: 35,
                      fontWeight: FontWeight.w500),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  SizedBox(
                    width: 376,
                    height: 60,
                    // width: 342,
                    // height: 60,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
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
                              'Home',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Satoshi',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 6),
                            Icon(Icons.north_east,
                                size: 20, color: Colors.white)
                            // Image.asset(
                            //   'assets/loginbuttonicon.png',
                            //   width: 23,
                            //   height: 23,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  /* SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  SizedBox(
                    width: 342,
                    height: 60,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginSuccessScreen()));
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
                              'New Search',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Satoshi',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 6),
                            Icon(Icons.north_east, size: 20, color: Colors.white)
                            // Image.asset(
                            //   'assets/loginbuttonicon.png',
                            //   width: 23,
                            //   height: 23,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  */
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  SizedBox(
                    width: 376,
                    height: 60,
                    // width: 342,
                    // height: 60,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EmergencyCallScreen()));
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
                              'Emergency',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Satoshi',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 6),
                            Icon(Icons.north_east,
                                size: 20, color: Colors.white)
                            // Image.asset(
                            //   'assets/loginbuttonicon.png',
                            //   width: 23,
                            //   height: 23,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  SizedBox(
                    width: 376,
                    height: 60,
                    // width: 342,
                    // height: 60,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InviteFriendScreen()));
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
                              'Invite a friend',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Satoshi',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 6),
                            Icon(Icons.north_east,
                                size: 20, color: Colors.white)
                            // Image.asset(
                            //   'assets/loginbuttonicon.png',
                            //   width: 23,
                            //   height: 23,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
