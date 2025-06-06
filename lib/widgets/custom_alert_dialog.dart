import 'package:flutter/material.dart';
import 'package:readytogo/Features/Donate/add_new_card.dart';

import '../Features/Subscription/subscription_screen.dart';

void showCancelSubscriptionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(Icons.close, size: 24, color: Colors.grey),
                ),
              ),
              SizedBox(height: 10),
              Image.asset(
                'assets/cancel_icon.png',
                width: 130,
                height: 130,
              ),
              //  SizedBox(height: 20),
              CustomTextWidget(
                  text: "Cancel Subscription",
                  color: Colors.black,
                  textSize: 22,
                  fontWeight: FontWeight.w500),
              // Text(
              //   "Cancel Subscription",
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.w600,
              //     color: Colors.black87,
              //   ),
              // ),
              SizedBox(height: 5),
              Text(
                "Are you sure, you want to cancel your subscription?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubscriptionScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF407BFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        "Go Back",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      }, 
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xFF407BFF)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Color(0xFF407BFF)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
