import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';
import 'package:readytogo/Features/Donate/payment_sucess.dart';

import '../../widgets/customscfaffold_widget.dart';
import 'add_new_card.dart';

class DonateScreenNavBar extends StatefulWidget {
  const DonateScreenNavBar({super.key});

  @override
  State<DonateScreenNavBar> createState() => _DonateScreenNavBarState();
}

class _DonateScreenNavBarState extends State<DonateScreenNavBar> {
  List<Map<String, dynamic>> folders = [
    {'label': 'Saved Previous Searches', 'value': true},
    {'label': 'Saved Resources', 'value': false},
    {'label': 'Saved Uploaded Resources', 'value': false},
    {'label': 'My Contacts', 'value': false},
  ];

  int folderCounter = 1;

  bool calendar = true;
  bool notifications = false;
  bool systemAlerts = false;
  bool events = false;

  bool video = true;
  bool blogs = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      isDrawerRequired: false,
      appbartitle: 'Donate',
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Enter Amount
            Container(
              height: 100,
              width: 376,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CustomTextWidget(
                    text: "Enter Amount",
                    textSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  CustomTextWidget(
                      text: "\$550",
                      textSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87),
                ],
              ),
            ),

            const SizedBox(height: 15),

            Container(
              //  height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 60,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddCardScreen()));
                      },
                      icon: Icon(
                        Icons.add,
                        color: Constants().themeColor,
                        size: 24,
                      ),
                      label: CustomTextWidget(
                        text: "Add New Card",
                        fontWeight: FontWeight.w500,
                        textSize: 20,
                        color: Constants().themeColor,
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        side: const BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildCardTile(
                      "Mastercard", "Jason Hanks", "4012888888881881"),
                  _buildCardTile("Visa", "Claire Jones", "151164513333000000"),
                  _buildCardTile(
                      "Mastercard", "Jacob Marsh", "35301113340128888"),
                ],
              ),
            ),

            // Transfer Button
            Padding(
              padding: EdgeInsets.all(24.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CompletedScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3568FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                      text: "Transfer",
                      fontWeight: FontWeight.w500,
                      textSize: 18,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Image.asset(
                      'assets/update_check.png',
                      width: 20,
                      height: 20,
                    ),
                    //  Icon(Icons.check_circle_outline, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardTile(String brand, String name, String number) {
    final brandIcon = brand == "Visa"
        ? Image.asset(
            "assets/visa.png",
            width: 64,
            height: 64,
          )
        : Image.asset(
            "assets/mastercard.png",
            width: 64,
            height: 64,
          );

    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: 340,
        height: 80,
        child: ListTile(
          leading: brandIcon,
          title: CustomTextWidget(
            text: name,
            color: Colors.black,
            textSize: 17,
            fontWeight: FontWeight.w500,
          ), //Text(name),
          subtitle: CustomTextWidget(
            text: number,
            color: Colors.black,
            textSize: 14,
            fontWeight: FontWeight.w300,
          ),
          trailing: const Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
