import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';
import 'package:readytogo/Features/Donate/add_new_card.dart';
import 'package:readytogo/Features/Subscription/subscription_success_screen.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';
import '../../widgets/boxDecorationWidget.dart';
import '../../widgets/custom_alert_dialog.dart';

class SubscriptionActiveScreen extends StatefulWidget {
  String imageAsset, planName, price;

  SubscriptionActiveScreen(
      {required this.imageAsset, required this.planName, required this.price});
  @override
  State<SubscriptionActiveScreen> createState() =>
      _SubscriptionActiveScreenState();
}

class _SubscriptionActiveScreenState extends State<SubscriptionActiveScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appbartitle: "Subscription",
      body: DecoratedBox(
        decoration: boxDecoration(),
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Container(
            height: 623,
            width: 392,
            margin: EdgeInsets.symmetric(horizontal: 1),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(widget.imageAsset, height: 120, width: 120),
                SizedBox(height: 10),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Constants().themeColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CustomTextWidget(
                        text: "Active",
                        color: Colors.white,
                        textSize: 14,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                CustomTextWidget(
                    text: widget.planName,
                    color: Colors.black,
                    textSize: 22,
                    fontWeight: FontWeight.bold),
                SizedBox(height: 15),
                Container(
                  height: 145,
                  width: 344,
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F7FF),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  //  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Image.asset(
                        "assets/info.png",
                        height: 28,
                        width: 38,
                      ),
                      // Icon(Icons.info_outline, color: Colors.blue),
                      SizedBox(height: 8),
                      CustomTextWidget(
                        text:
                            'Your subscription will end on\nJuly 1, 2025 at 12:00am.',
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        textSize: 20,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'After that you will be automatically billed \$9',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SubscriptionDetailRow(
                    label: 'Next Payment', value: 'July 1, 2025'),
                SubscriptionDetailRow(
                    label: 'Payment Method', value: 'Mastercard'),
                SubscriptionDetailRow(
                    label: 'Total', value: '\$${widget.price}.00'),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 160,
                        height: 51,
                        child: OutlinedButton(
                          onPressed: () {
                            showCancelSubscriptionDialog(context);
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            side: BorderSide(color: Constants().themeColor),
                          ),
                          child: CustomTextWidget(
                              text: "Cancle",
                              color: Constants().themeColor,
                              textSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: SizedBox(
                        width: 160,
                        height: 51,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SubscriptionSuccess(image: widget.imageAsset)));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Constants().themeColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: CustomTextWidget(
                              text: "Continue",
                              color: Colors.white,
                              textSize: 18,
                              fontWeight: FontWeight.w500),
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

class SubscriptionDetailRow extends StatelessWidget {
  final String label;
  final String value;

  SubscriptionDetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.grey.shade700)),
          Text(value,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        ],
      ),
    );
  }
}
