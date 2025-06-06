import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';
import 'package:readytogo/Features/Donate/payment_sucess.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';
import 'package:sms_autofill/sms_autofill.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
        appbartitle: 'Add Card',
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),

              // Card form container
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTextWidget(
                        text: "Card Number",
                        color: Colors.black,
                        textSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 8),
                      _buildTextField("4012888888881881"),
                      const SizedBox(height: 20),
                      const CustomTextWidget(
                        text: "Expiry Date",
                        color: Colors.black,
                        textSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(child: _buildTextField("04-04-2025")),
                          const SizedBox(width: 12),
                          Expanded(child: _buildTextField("2025")),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const CustomTextWidget(
                        text: "CVV Number",
                        color: Colors.black,
                        textSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 8),
                      PinFieldAutoFill(
                        codeLength: 4,
                        currentCode: "1234",
                        onCodeChanged: (code) {
                          // setState(() {
                          //   codeValue = code ?? "";
                          // });
                        },
                        onCodeSubmitted: (code) {
                          print('Submitted: $code');
                        },
                        keyboardType: TextInputType.number,
                        decoration: BoxLooseDecoration(
                          strokeColorBuilder: FixedColorBuilder(
                            Colors.transparent,
                          ),
                          gapSpace: 10,
                          bgColorBuilder: FixedColorBuilder(Color(0xFFF1F5FF)),
                          radius: const Radius.circular(12),
                          textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Constants().themeColor),
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     _buildCVVBox("4"),
                      //     _buildCVVBox("5"),
                      //     _buildCVVBox("8"),
                      //     _buildCVVBox("5"),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),

              // Add Card Button
              SizedBox(
                width: 376,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CompletedScreen()));
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24,
                    ),
                    label: CustomTextWidget(
                        text: "Add Card",
                        color: Colors.white,
                        textSize: 18,
                        fontWeight: FontWeight.normal),
                    // const Text("+ Add Card", style: TextStyle(fontSize: 18,)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3568FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));

    /*Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0ECFF), Color(0xFFF2F4FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                child: Row(
                  children: const [
                    Icon(Icons.arrow_back, size: 28),
                    SizedBox(width: 16),
                    CustomTextWidget(
                      text: "Add Card",
                      color: Colors.black,
                      textSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Card form container
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTextWidget(
                        text: "Card Number",
                        color: Colors.black,
                        textSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 8),
                      _buildTextField("4012888888881881"),

                      const SizedBox(height: 20),
                      const CustomTextWidget(
                        text: "Expiry Date",
                        color: Colors.black,
                        textSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(child: _buildTextField("04-04-2025")),
                          const SizedBox(width: 12),
                          Expanded(child: _buildTextField("2025")),
                        ],
                      ),

                      const SizedBox(height: 20),
                      const CustomTextWidget(
                        text: "CVV Number",
                        color: Colors.black,
                        textSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildCVVBox("4"),
                          _buildCVVBox("5"),
                          _buildCVVBox("8"),
                          _buildCVVBox("5"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Add Card Button
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text("+ Add Card", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3568FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );*/
  }

  Widget _buildTextField(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        initialValue: hint,
        style: const TextStyle(
            color: Color(0xFF3D7BFF),
            fontWeight: FontWeight.w600,
            fontFamily: 'satoshi'),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

  // Widget _buildCVVBox(String number) {
  //   return Container(
  //     width: 60,
  //     height: 60,
  //     alignment: Alignment.center,
  //     decoration: BoxDecoration(
  //       color: const Color(0xFFF1F5FF),
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child:
  //     Text(
  //       number,
  //       style: const TextStyle(
  //           fontSize: 20,
  //           fontFamily: 'satoshi',
  //           color: Color(0xFF3D7BFF),
  //           fontWeight: FontWeight.w600),
  //     ),
  //   );
  // }
}

// Dummy CustomTextWidget (you should replace this with your actual implementation)
class CustomTextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double textSize;
  final FontWeight fontWeight;

  const CustomTextWidget({
    super.key,
    required this.text,
    required this.color,
    required this.textSize,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: textSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
