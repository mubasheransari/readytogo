import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readytogo/Features/Donate/add_new_card.dart';
import 'package:readytogo/widgets/toast_widget.dart';
import '../Features/Subscription/subscription_screen.dart';
import '../Features/login/login_screen.dart';

// class DialogWidget extends StatelessWidget {
//   final VoidCallback onGoBackPressed;
//   final VoidCallback onCancelPressed;
//   final Widget goBackText;
//   final Widget cancelText;
//   final String icon;

//   const DialogWidget({
//     super.key,
//     required this.onGoBackPressed,
//     required this.onCancelPressed,
//     required this.goBackText,
//     required this.cancelText,
//     required this.icon
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       backgroundColor: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Align(
//               alignment: Alignment.topRight,
//               child: GestureDetector(
//                 onTap: () => Navigator.of(context).pop(),
//                 child: const Icon(Icons.close, size: 24, color: Colors.grey),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Image.asset(
//               icon,
//               width: 130,
//               height: 130,
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               "Cancel Subscription",
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               "Are you sure, you want to cancel your subscription?",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 14, color: Colors.grey[700]),
//             ),
//             const SizedBox(height: 25),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: onGoBackPressed,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF407BFF),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                     ),
//                     child: goBackText,
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: onCancelPressed,
//                     style: OutlinedButton.styleFrom(
//                       side: const BorderSide(color: Color(0xFF407BFF)),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                     ),
//                     child: cancelText,
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

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

void logoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                'assets/logout_text.png',
                width: 130,
                height: 80,
              ),
              //  SizedBox(height: 20),
              // CustomTextWidget(//10@Testing
              //     text: "Cancel Subscription",
              //     color: Colors.black,
              //     textSize: 22,
              //     fontWeight: FontWeight.w500),
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
                "Are you sure, you want to logout?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 42,
                    width: 115,
                    child: Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          side: BorderSide(color: Colors.green),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 7),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: 'satoshi',
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    height: 42,
                    width: 115,
                    child: Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          final box = GetStorage();
                          box.remove("token");
                          box.remove("id");
                          box.remove("role");
                          toastWidget("Logout", Colors.red);
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.red,
                          side: BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 7),
                        ),
                        child: Text(
                          "Logout",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: 'satoshi',
                              fontWeight: FontWeight.w700),
                        ),
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
