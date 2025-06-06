import 'package:flutter/material.dart';
import 'package:readytogo/Features/Subscription/subscription_active_screen.dart';
import 'package:readytogo/widgets/custom_button_widget.dart';
import 'package:readytogo/widgets/custom_textwidget.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';

import '../../Constants/constants.dart';
import '../../widgets/boxDecorationWidget.dart';

class SubscriptionScreen extends StatelessWidget {
  SubscriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appbartitle: 'Subscription Plans',
      body: DecoratedBox(
        decoration: boxDecoration(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Plan Card
              PlanCard(
                  planName: 'Basic Plan',
                  description: 'Perfect for individuals starting out',
                  price: '\$9/month',
                  features: ['All Basic features', 'Priority support'],
                  buttonText: 'Get Basic Plan',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubscriptionActiveScreen(
                                  imageAsset: "assets/basicplan.png",
                                  planName: "Basic Plan",
                                  price: "9",
                                )));
                  },
                  icon: Icons.attach_money,
                  imageassets: "assets/basicplan.png"),
              SizedBox(height: 20),

              // Pro Plan Card
              PlanCard(
                  planName: 'Pro Plan',
                  description: 'Ideal for small teams needs',
                  price: '\$29/month',
                  features: ['All Basic features', 'Advanced analytics'],
                  buttonText: 'Get Pro Plan',
                  onPressed: () {},
                  icon: Icons.person,
                  imageassets: "assets/proplan.png"),
              SizedBox(height: 20),

              // Enterprise Plan Card
              PlanCard(
                  planName: 'Enterprise Plan',
                  description: 'Best for large teams solutions',
                  price: '\$49/month',
                  features: [
                    'All Basic features & Everything in Pro',
                    'Custom integrations'
                  ],
                  buttonText: 'Get Enterprise Plan',
                  onPressed: () {},
                  icon: Icons.credit_card,
                  imageassets: "assets/enterpriseplan.png"),
              // SizedBox(height: 10),

              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.88,
                  height: 90,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        //    minimumSize: const Size(100, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                              color: Constants().themeColor, width: 1),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Start Your Free Trail',
                            style: TextStyle(
                                color: Constants().themeColor,
                                fontFamily: 'Satoshi',
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 5),
                          Image.asset(
                            'assets/arrow-narrow-left.png',
                            width: 25,
                            height: 25,
                            color: Constants().themeColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*class PlanCard extends StatelessWidget {
  final String planName;
  final String description;
  final String price;
  final List<String> features;
  final String buttonText;
  final VoidCallback onPressed;
  final IconData icon;
  final String imageassets;

  const PlanCard({
    required this.planName,
    required this.description,
    required this.price,
    required this.features,
    required this.buttonText,
    required this.onPressed,
    required this.icon,
    required this.imageassets,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 380, // Adjusted height to match the design
        width: MediaQuery.of(context).size.width * 0.95,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, top: 10.0, right: 8.0), // Adjusted padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Icon Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Plan Name
                      Row(
                        children: [
                          Icon(icon,
                              size: 30, color: Constants().themeColor), // Icon
                          SizedBox(width: 8),
                          CustomTextWidget(
                            text: planName,
                            fontWeight: FontWeight.w600,
                            textSize: 24, // Larger title size
                            color: Colors.black,
                          ),
                        ],
                      ),
                      // Plan Image
                      Image.asset(
                        imageassets,
                        height: 70,
                        width: 70,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // Description
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CustomTextWidget(
                      text: description,
                      fontWeight: FontWeight.w400,
                      textSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 12),
                  Divider(color: Colors.black26),
                  SizedBox(height: 12),
                  // Price
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Price: $price",
                      style: TextStyle(
                        color: Constants().themeColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'satoshi',
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  // Feature 1
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.check,
                            color: Constants().themeColor, size: 18),
                        SizedBox(width: 8),
                        CustomTextWidget(
                          text: features[0],
                          fontWeight: FontWeight.w500,
                          textSize: 14,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  // Feature 2
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.check,
                            color: Constants().themeColor, size: 18),
                        SizedBox(width: 8),
                        CustomTextWidget(
                          text: features[1],
                          fontWeight: FontWeight.w500,
                          textSize: 14,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Button Section
                  Center(
                    child: Container(
                      width: double.infinity, // Take full width
                      height: 50, // Slightly adjusted height
                      child: ElevatedButton(
                        onPressed: onPressed,
                        child: CustomTextWidget(
                          text: buttonText,
                          color: Colors.white,
                          textSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants().themeColor,
                          minimumSize: Size(double.infinity, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}*/

/*class PlanCard extends StatelessWidget {
  final String planName;
  final String description;
  final String price;
  final List<String> features;
  final String buttonText;
  final VoidCallback onPressed;
  final IconData icon;
  final String imageassets;

  const PlanCard({
    required this.planName,
    required this.description,
    required this.price,
    required this.features,
    required this.buttonText,
    required this.onPressed,
    required this.icon,
    required this.imageassets,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 380, // Adjusted height to match the design
        width: MediaQuery.of(context).size.width * 0.95,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, top: 10.0, right: 8.0), // Adjusted padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Icon Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Plan Name
                      Row(
                        children: [
                          Icon(icon,
                              size: 30, color: Constants().themeColor), // Icon
                          SizedBox(width: 8),
                          CustomTextWidget(
                            text: planName,
                            fontWeight: FontWeight.w600,
                            textSize: 24, // Larger title size
                            color: Colors.black,
                          ),
                        ],
                      ),
                      // Plan Image
                      Image.asset(
                        imageassets,
                        height: 70,
                        width: 70,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // Description
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: CustomTextWidget(
                      text: description,
                      fontWeight: FontWeight.w400,
                      textSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 12),
                  Divider(color: Colors.black26),
                  SizedBox(height: 12),
                  // Price
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Price: $price",
                      style: TextStyle(
                        color: Constants().themeColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'satoshi',
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  // Feature 1
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.check,
                            color: Constants().themeColor, size: 18),
                        SizedBox(width: 8),
                        CustomTextWidget(
                          text: features[0],
                          fontWeight: FontWeight.w500,
                          textSize: 14,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  // Feature 2
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.check,
                            color: Constants().themeColor, size: 18),
                        SizedBox(width: 8),
                        CustomTextWidget(
                          text: features[1],
                          fontWeight: FontWeight.w500,
                          textSize: 14,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Button Section
                  Center(
                    child: Container(
                      width: double.infinity, // Take full width
                      height: 50, // Slightly adjusted height
                      child: ElevatedButton(
                        onPressed: onPressed,
                        child: CustomTextWidget(
                          text: buttonText,
                          color: Colors.white,
                          textSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants().themeColor,
                          minimumSize: Size(double.infinity, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}*/

class PlanCard extends StatelessWidget {
  final String planName;
  final String description;
  final String price;
  final List<String> features;
  final String buttonText;
  final VoidCallback onPressed;
  final IconData icon;
  final String imageassets;

  PlanCard({
    required this.planName,
    required this.description,
    required this.price,
    required this.features,
    required this.buttonText,
    required this.onPressed,
    required this.icon,
    required this.imageassets,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 320,
        width: MediaQuery.of(context).size.width * 0.95,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 12),
                                  child: CustomTextWidget(
                                    text: planName,
                                    fontWeight: FontWeight.w600,
                                    textSize: 22,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: CustomTextWidget(
                                    text: description,
                                    fontWeight: FontWeight.w400,
                                    textSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -24,
                        right: -24,
                        child: Image.asset(
                          imageassets,
                          height: 95,
                          width: 95,
                        ),
                      ),
                    ],
                  ),

                  // Stack(
                  //   children: [
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       // crossAxisAlignment: CrossAxisAlignment.stretch,
                  //       children: [
                  //         Column(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             CustomTextWidget(
                  //                 text: planName,
                  //                 fontWeight: FontWeight.w600,
                  //                 textSize: 22),
                  //             Padding(
                  //               padding: const EdgeInsets.only(left: 8.0),
                  //               child: CustomTextWidget(
                  //                 text: description,
                  //                 fontWeight: FontWeight.w400,
                  //                 textSize: 14,
                  //               ),
                  //             ),
                  //           ],
                  //         ),

                  //         // Icon(icon, size: 30, color: Colors.blue), // Add your icons
                  //         //SizedBox(width: 10),
                  //         // CustomTextWidget(
                  //         //     text: planName,
                  //         //     fontWeight: FontWeight.w600,
                  //         //     textSize: 22),
                  //         // Text(
                  //         //   planName,
                  //         //   style: TextStyle(
                  //         //     fontSize: 20,
                  //         //     fontWeight: FontWeight.bold,
                  //         //     color: Colors.blue,
                  //         //   ),
                  //         // ),SSoze
                  //         // SizedBox(
                  //         //   width: 90,
                  //         // ),
                  //         Image.asset(
                  //           imageassets,
                  //           height: 90,
                  //           width: 90,
                  //         )
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   // crossAxisAlignment: CrossAxisAlignment.stretch,
                  //   children: [
                  //     // Icon(icon, size: 30, color: Colors.blue), // Add your icons
                  //     //SizedBox(width: 10),
                  //     CustomTextWidget(
                  //         text: planName,
                  //         fontWeight: FontWeight.w600,
                  //         textSize: 22),
                  //     // Text(
                  //     //   planName,
                  //     //   style: TextStyle(
                  //     //     fontSize: 20,
                  //     //     fontWeight: FontWeight.bold,
                  //     //     color: Colors.blue,
                  //     //   ),
                  //     // ),

                  //     Image.asset(
                  //       imageassets,
                  //       height: 90,
                  //       width: 90,
                  //     )
                  //   ],
                  // ),
                  SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CustomTextWidget(
                      text: description,
                      fontWeight: FontWeight.w400,
                      textSize: 14,
                    ),
                  ),
                  SizedBox(height: 7),
                  Divider(
                    color: Colors.black26,
                  ),
                  SizedBox(height: 7),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Price : $price",
                        style: TextStyle(
                            color: Constants().themeColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'satoshi')),
                  ),
                  SizedBox(height: 7),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/update_check.png',
                          width: 16,
                          height: 16,
                          color: Constants().themeColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(features[0],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'satoshi')),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/update_check.png',
                          width: 16,
                          height: 16,
                          color: Constants().themeColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(features[1],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'satoshi')),
                      ],
                    ),
                  ),
                  // ...features.map((feature) =>
                  //     Text('$feature', style: TextStyle(fontSize: 14))),
                  SizedBox(height: 22),
                  Center(
                    child: Container(
                      width: 344, //MediaQuery.of(context).size.width * 0.75,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: onPressed,
                        child: CustomTextWidget(
                          text: buttonText,
                          color: Colors.white,
                          textSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants().themeColor,
                          minimumSize: Size(double.infinity, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
