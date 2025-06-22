import 'dart:io';
import 'package:readytogo/Features/Signup/bloc/signup_event.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readytogo/Features/Signup/bloc/signup_bloc.dart';
import 'package:readytogo/Features/login/login_screen.dart';
import 'package:readytogo/Features/Signup/privacy_policy.dart';
import 'package:readytogo/Features/Signup/release_of_information.dart';
import 'package:readytogo/Features/Signup/terms_and_condition.dart';

import '../../Constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/boxDecorationWidget.dart';

bool isChecked = false;

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;
  bool _showImageError = false;
  bool _showTermsError = false;
  bool isChecked = false;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController referralCodeController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _showImageError = false;
      });
    }
  }

  Widget _buildTextField(String label, String hint,
      {bool obscureText = false,
      required TextEditingController controller,
      String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            fontFamily: 'Satoshi',
            color: Color(0xff323747),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: 376,
          height: 80,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xff666F80),
                fontSize: 18,
                fontFamily: 'Satoshi',
                fontWeight: FontWeight.w500,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: boxDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Signup & Improve Your Health Today',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 148,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _selectedImage == null
                          ? Center(
                              child: Image.asset(
                                'assets/Frame.png',
                                height: 120,
                                width: 120,
                              ),
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: 120,
                                  width: 130,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(_selectedImage!,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(height: 5),
                                SizedBox(
                                  height: 23,
                                  width: 90,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: Constants().themeColor,
                                        child: Text('change',
                                            style: TextStyle(
                                              color: Colors.white,
                                            )),
                                      )),
                                ),
                              ],
                            ),
                    ),
                  ),
                  if (_showImageError)
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Please upload a profile image',
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
                  const SizedBox(height: 25),
                  _buildTextField('First Name', 'Enter First Name',
                      controller: firstNameController,
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Required' : null),
                  const SizedBox(height: 15),
                  _buildTextField('Last Name', 'Enter Last Name',
                      controller: lastNameController,
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Required' : null),
                  const SizedBox(height: 15),
                  _buildTextField('Email', 'Enter Email',
                      controller: emailController,
                      validator: (val) => val == null || !val.contains('@')
                          ? 'Enter valid email'
                          : null),
                  const SizedBox(height: 15),
                  _buildTextField('Username', 'Enter Username',
                      controller: usernameController,
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Required' : null),
                  const SizedBox(height: 15),
                  _buildTextField('Phone Number', 'Enter Phone Number',
                      controller: phoneController,
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Required' : null),
                  const SizedBox(height: 15),
                  _buildTextField('Zip Code', 'Enter Zip Code',
                      controller: zipController,
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Required' : null),
                  const SizedBox(height: 15),
                  _buildTextField('Password', 'min. 8 characters',
                      obscureText: true,
                      controller: passwordController,
                      validator: (val) => val != null && val.length >= 8
                          ? null
                          : 'Minimum 8 characters'),
                  const SizedBox(height: 15),
                  _buildTextField('Confirm Password', 'Type again',
                      obscureText: true,
                      controller: confirmPasswordController,
                      validator: (val) => val == passwordController.text
                          ? null
                          : 'Passwords do not match'),
                  const SizedBox(height: 15),
                  _buildTextField(
                      'Referral Code (optional)', 'Enter Referral Code',
                      controller: referralCodeController),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                            if (isChecked) _showTermsError = false;
                          });
                        },
                        child: Container(
                          width: 21,
                          height: 21,
                          decoration: BoxDecoration(
                            color: isChecked
                                ? Constants().themeColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.grey, width: 2),
                          ),
                          child: isChecked
                              ? const Icon(Icons.check,
                                  size: 16, color: Colors.white)
                              : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: 'Satoshi'),
                            children: [
                              const TextSpan(
                                  text: 'I have read & accept ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w700),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              TermsAndConditionScreen())),
                              ),
                              const TextSpan(text: ', '),
                              TextSpan(
                                text: 'release of information ',
                                style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w700),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              ReleaseOfInformationScreen())),
                              ),
                              const TextSpan(text: ' & '),
                              TextSpan(
                                text: ' privacy policy.',
                                style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w700),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              PrivacyPolicyScreen())),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_showTermsError)
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Please accept the terms and conditions',
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),
                    ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 376,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showImageError = _selectedImage == null;
                          _showTermsError = !isChecked;
                        });

                        if (_formKey.currentState?.validate() == true &&
                            _selectedImage != null &&
                            isChecked) {
                          // Submit to Bloc or API
                          print("Proceed with signup");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants().themeColor,
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
                            'Register',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Satoshi',
                                fontSize: 20,
                                fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(width: 5),
                          Image.asset(
                            'assets/loginbuttonicon.png',
                            width: 23,
                            height: 23,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?",
                          style: TextStyle(
                              fontFamily: 'Satoshi',
                              fontSize: 20,
                              color: Color(0xff323747),
                              fontWeight: FontWeight.w700)),
                      GestureDetector(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => LoginScreen())),
                        child: Text(" Login",
                            style: TextStyle(
                                fontFamily: 'Satoshi',
                                fontSize: 20,
                                color: Constants().themeColor,
                                fontWeight: FontWeight.w700)),
                      ),
                    ],
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
