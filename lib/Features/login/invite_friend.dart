import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Constants/constants.dart';
import '../../widgets/customscfaffold_widget.dart';

class InviteFriendScreen extends StatelessWidget {
  const InviteFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appbartitle: '',
      isAppBarContentRequired: false,
      showNotificationIcon: false,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.98,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Invite a Friend",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            fontFamily: 'satoshi'),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Image.asset("assets/invite_friend.png",
                      height: 120, width: 120),
                  // const Icon(Icons.phone_in_talk_rounded,
                  //     size: 60, color: Colors.blue),
                  const SizedBox(height: 20),
                  const Text(
                    "Invite Your Friend And Reward Yourself",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'satoshi'),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: const Text(
                      "Share your link below ! Enjoy when each of your friend signs up.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'satoshi'),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: 344,
                    height: 60,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F5FF), // Light blue background
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      //   mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'https://www.apple.com/app-store/',
                            style: const TextStyle(
                              color: Color(0xFF3B82F6), // Blue color
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: ''));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Link copied to clipboard')),
                            );
                          },
                          child: const Icon(
                            Icons.copy,
                            size: 18,
                            color: Color(0xFF3B82F6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Image.asset(
                    "assets/share.png",
                    width: 112,
                    height: 62,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: 60,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants().themeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 32, vertical: 12),
                      ),
                      icon: Icon(Icons.add, size: 24, color: Colors.white),
                      label: Text(
                        "Invite From Contacts",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'satoshi'),
                      ),
                      onPressed: () => {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
