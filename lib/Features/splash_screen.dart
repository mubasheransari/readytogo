import 'package:flutter/material.dart';

import 'package:readytogo/Features/login/login_screen.dart';

import '../widgets/boxDecorationWidget.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

    @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => LoginScreen()),
  (Route<dynamic> route) => false, // This removes all previous routes
);
        });
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: boxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 310.0),
              child: Image.asset(
                "assets/logo.png",
                height: 166,
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Text(
                'Powered by XREDDUX',
                style: TextStyle(
                  fontFamily: 'Satoshi',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
