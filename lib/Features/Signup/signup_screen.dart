import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:readytogo/Features/3MinuteAssisment/Step1Screen.dart';
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
import '../../widgets/toast_widget.dart';
import 'bloc/signup_state.dart';

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
  bool _submitted = false;
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

  _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _showImageError = false;
      });
    }
  } //Testing1234@

  Widget _buildTextField(String label, String hint,
      {bool obscureText = false,
      required TextEditingController controller,
      String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                fontFamily: 'Satoshi',
                color: Color(0xff323747))),
        const SizedBox(height: 5),
        SizedBox(
          width: 376,
          height: 80,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            autovalidateMode: _submitted
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
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

  var storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            toastWidget("Signup Successful", Colors.green);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => Step1Screen()),
            );
            storage.write("3min", "3min");
          } else if (state is SignUpFailure) {
            toastWidget(state.error, Colors.red);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              width: double.infinity,
              decoration: boxDecoration(),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
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
                                child: Image.asset('assets/Frame.png',
                                    height: 145, width: 145),
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
                                  const SizedBox(height: 5),
                                  Container(
                                    height: 23,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: Constants().themeColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'change',
                                      style: TextStyle(color: Colors.white),
                                    ),
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
                        const SizedBox(width: 3),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isChecked = !isChecked;
                              if (isChecked) _showTermsError = false;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              width: 21,
                              height: 21,
                              decoration: BoxDecoration(
                                color: isChecked
                                    ? Constants().themeColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                                border:
                                    Border.all(color: Colors.grey, width: 2),
                              ),
                              child: isChecked
                                  ? const Icon(Icons.check,
                                      size: 16, color: Colors.white)
                                  : null,
                            ),
                          ),
                        ),
                        const SizedBox(width: 9),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: 'Satoshi'),
                              children: [
                                const TextSpan(
                                    text: 'I have read & accept ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17)),
                                TextSpan(
                                  text: 'Terms & Conditions',
                                  style: TextStyle(
                                    color: Constants().themeColor,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                    decorationColor: Constants().themeColor,
                                  ),
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
                                  style: TextStyle(
                                    color: Constants().themeColor,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                    decorationColor: Constants().themeColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                ReleaseOfInformationScreen())),
                                ),
                                const TextSpan(
                                    text: ' & ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17)),
                                TextSpan(
                                  text: 'privacy policy.',
                                  style: TextStyle(
                                    color: Constants().themeColor,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                    decorationColor: Constants().themeColor,
                                  ),
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

                        // Expanded(
                        //   child: Text.rich(
                        //     TextSpan(
                        //       style: const TextStyle(
                        //           fontSize: 16,
                        //           color: Colors.black,
                        //           fontFamily: 'Satoshi'),
                        //       children: [
                        //         const TextSpan(
                        //             text: 'I have read & accept ',
                        //             style: TextStyle(
                        //                 fontWeight: FontWeight.w700,
                        //                 fontSize: 17)),
                        //         TextSpan(
                        //           text: 'Terms & Conditions',
                        //           style: TextStyle(
                        //             color: Constants().themeColor,
                        //             decoration: TextDecoration.underline,
                        //             fontWeight: FontWeight.w700,
                        //             fontSize: 17,
                        //           ),
                        //           recognizer: TapGestureRecognizer()
                        //             ..onTap = () => Navigator.push(
                        //                   context,
                        //                   MaterialPageRoute(
                        //                       builder: (_) =>
                        //                           TermsAndConditionScreen()),
                        //                 ),
                        //         ),
                        //         const TextSpan(text: ', '),
                        //         TextSpan(
                        //           text: 'release of information ',
                        //           style: TextStyle(
                        //             color: Constants().themeColor,
                        //             decoration: TextDecoration.underline,
                        //             fontWeight: FontWeight.w700,
                        //             fontSize: 17,
                        //           ),
                        //           recognizer: TapGestureRecognizer()
                        //             ..onTap = () => Navigator.push(
                        //                   context,
                        //                   MaterialPageRoute(
                        //                       builder: (_) =>
                        //                           ReleaseOfInformationScreen()),
                        //                 ),
                        //         ),
                        //         const TextSpan(text: ' & '),
                        //         TextSpan(
                        //           text: 'privacy policy.',
                        //           style: TextStyle(
                        //             color: Constants().themeColor,
                        //             decoration: TextDecoration.underline,
                        //             fontWeight: FontWeight.w700,
                        //             fontSize: 17,
                        //           ),
                        //           recognizer: TapGestureRecognizer()
                        //             ..onTap = () => Navigator.push(
                        //                   context,
                        //                   MaterialPageRoute(
                        //                       builder: (_) =>
                        //                           PrivacyPolicyScreen()),
                        //                 ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),*/
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
                            _submitted = true;
                            _showImageError = _selectedImage == null;
                            _showTermsError = !isChecked;
                          });

                          if (_formKey.currentState!.validate() &&
                              _selectedImage != null &&
                              isChecked) {
                            context.read<SignUpBloc>().add(SignupSubmitted(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  email: emailController.text,
                                  userName: usernameController.text,
                                  password: passwordController.text,
                                  confirmPassword:
                                      confirmPasswordController.text,
                                  phoneNumber: phoneController.text,
                                  zipCode: zipController.text,
                                  referralCode: referralCodeController.text,
                                  profileImage: _selectedImage!,
                                ));
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
                        child: state is SignUpLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : Row(
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
                                  Image.asset('assets/loginbuttonicon.png',
                                      width: 23, height: 23),
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
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


/*class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  bool _showImageError = false;
  bool _showTermsError = false;
  bool _submitted = false;
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
            autovalidateMode: _submitted
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
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
  } //mubhas@gmail.com     Testing1234@

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          width: double.infinity,
          decoration: boxDecoration(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
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
                              height: 145,
                              width: 145,
                            ),
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 120,
                                width: 130,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    _selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                height: 23,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: Constants().themeColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'change',
                                  style: TextStyle(color: Colors.white),
                                ),
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
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
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'Satoshi'),
                          children: [
                            const TextSpan(
                                text: 'I have read & accept ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 17)),
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: TextStyle(
                                color: Constants().themeColor,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                                decorationColor: Constants().themeColor,
                              ),
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
                              style: TextStyle(
                                color: Constants().themeColor,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                                decorationColor: Constants().themeColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            ReleaseOfInformationScreen())),
                            ),
                            const TextSpan(
                                text: ' & ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 17)),
                            TextSpan(
                              text: 'privacy policy.',
                              style: TextStyle(
                                color: Constants().themeColor,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                                decorationColor: Constants().themeColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => PrivacyPolicyScreen())),
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
                        _submitted = true;
                        _showImageError = _selectedImage == null;
                        _showTermsError = !isChecked;
                      });
                      if (_formKey.currentState!.validate() &&
                          _selectedImage != null &&
                          isChecked) {
                        context.read<SignUpBloc>().add(SignupEvent(
                              confirmPassword: confirmPasswordController.text,
                              email: emailController.text,
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              password: passwordController.text,
                              phoneNumber: phoneController.text,
                              referralCode: referralCodeController.text,
                              userName: usernameController.text,
                              zipCode: zipController.text,
                            ));
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
                        Image.asset('assets/loginbuttonicon.png',
                            width: 23, height: 23),
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
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class SignupScreen extends StatefulWidget {
//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final ImagePicker _picker = ImagePicker();

//   File? _selectedImage;
//   bool _showImageError = false;
//   bool _showTermsError = false;
//   bool isChecked = false;

//   final TextEditingController firstNameController = TextEditingController();
//   final TextEditingController lastNameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController zipController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();
//   final TextEditingController referralCodeController = TextEditingController();
//   final TextEditingController usernameController = TextEditingController();

//   Future<void> _pickImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         _selectedImage = File(image.path);
//         _showImageError = false;
//       });
//     }
//   }

//   Widget _buildTextField(String label, String hint,
//       {bool obscureText = false,
//       required TextEditingController controller,
//       String? Function(String?)? validator}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w900,
//             fontFamily: 'Satoshi',
//             color: Color(0xff323747),
//           ),
//         ),
//         const SizedBox(height: 5),
//         SizedBox(
//           width: 376,
//           height: 80,
//           child: TextFormField(
//             controller: controller,
//             obscureText: obscureText,
//             validator: validator,
//             decoration: InputDecoration(
//               hintText: hint,
//               hintStyle: const TextStyle(
//                 color: Color(0xff666F80),
//                 fontSize: 18,
//                 fontFamily: 'Satoshi',
//                 fontWeight: FontWeight.w500,
//               ),
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         decoration: boxDecoration(),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   const SizedBox(height: 40),
//                   const Text(
//                     'Signup & Improve Your Health Today',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.w700,
//                       fontFamily: 'Satoshi',
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   GestureDetector(
//                     onTap: _pickImage,
//                     child: Container(
//                       height: 148,
//                       width: 120,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: _selectedImage == null
//                           ? Center(
//                               child: Image.asset(
//                                 'assets/Frame.png',
//                                 height: 120,
//                                 width: 120,
//                               ),
//                             )
//                           : Column(
//                               children: [
//                                 SizedBox(
//                                   height: 120,
//                                   width: 130,
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(8),
//                                     child: Image.file(_selectedImage!,
//                                         fit: BoxFit.cover),
//                                   ),
//                                 ),
//                                 SizedBox(height: 5),
//                                 SizedBox(
//                                   height: 23,
//                                   width: 90,
//                                   child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(12),
//                                       child: Container(
//                                         alignment: Alignment.center,
//                                         color: Constants().themeColor,
//                                         child: Text('change',
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                             )),
//                                       )),
//                                 ),
//                               ],
//                             ),
//                     ),
//                   ),
//                   if (_showImageError)
//                     const Padding(
//                       padding: EdgeInsets.only(top: 8.0),
//                       child: Text(
//                         'Please upload a profile image',
//                         style: TextStyle(color: Colors.red, fontSize: 14),
//                       ),
//                     ),
//                   const SizedBox(height: 25),
//                   _buildTextField('First Name', 'Enter First Name',
//                       controller: firstNameController,
//                       validator: (val) =>
//                           val == null || val.isEmpty ? 'Required' : null),
//                   const SizedBox(height: 15),
//                   _buildTextField('Last Name', 'Enter Last Name',
//                       controller: lastNameController,
//                       validator: (val) =>
//                           val == null || val.isEmpty ? 'Required' : null),
//                   const SizedBox(height: 15),
//                   _buildTextField('Email', 'Enter Email',
//                       controller: emailController,
//                       validator: (val) => val == null || !val.contains('@')
//                           ? 'Enter valid email'
//                           : null),
//                   const SizedBox(height: 15),
//                   _buildTextField('Username', 'Enter Username',
//                       controller: usernameController,
//                       validator: (val) =>
//                           val == null || val.isEmpty ? 'Required' : null),
//                   const SizedBox(height: 15),
//                   _buildTextField('Phone Number', 'Enter Phone Number',
//                       controller: phoneController,
//                       validator: (val) =>
//                           val == null || val.isEmpty ? 'Required' : null),
//                   const SizedBox(height: 15),
//                   _buildTextField('Zip Code', 'Enter Zip Code',
//                       controller: zipController,
//                       validator: (val) =>
//                           val == null || val.isEmpty ? 'Required' : null),
//                   const SizedBox(height: 15),
//                   _buildTextField('Password', 'min. 8 characters',
//                       obscureText: true,
//                       controller: passwordController,
//                       validator: (val) => val != null && val.length >= 8
//                           ? null
//                           : 'Minimum 8 characters'),
//                   const SizedBox(height: 15),
//                   _buildTextField('Confirm Password', 'Type again',
//                       obscureText: true,
//                       controller: confirmPasswordController,
//                       validator: (val) => val == passwordController.text
//                           ? null
//                           : 'Passwords do not match'),
//                   const SizedBox(height: 15),
//                   _buildTextField(
//                       'Referral Code (optional)', 'Enter Referral Code',
//                       controller: referralCodeController),
//                   const SizedBox(height: 20),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(width: 12),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             isChecked = !isChecked;
//                             if (isChecked) _showTermsError = false;
//                           });
//                         },
//                         child: Container(
//                           width: 21,
//                           height: 21,
//                           decoration: BoxDecoration(
//                             color: isChecked
//                                 ? Constants().themeColor
//                                 : Colors.transparent,
//                             borderRadius: BorderRadius.circular(6),
//                             border: Border.all(color: Colors.grey, width: 2),
//                           ),
//                           child: isChecked
//                               ? const Icon(Icons.check,
//                                   size: 16, color: Colors.white)
//                               : null,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: RichText(
//                           text: TextSpan(
//                             style: const TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.black,
//                                 fontFamily: 'Satoshi'),
//                             children: [
//                               const TextSpan(
//                                   text: 'I have read & accept ',
//                                   style:
//                                       TextStyle(fontWeight: FontWeight.w700)),
//                               TextSpan(
//                                 text: 'Terms & Conditions',
//                                 style: const TextStyle(
//                                     color: Colors.blue,
//                                     decoration: TextDecoration.underline,
//                                     fontWeight: FontWeight.w700),
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () => Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (_) =>
//                                               TermsAndConditionScreen())),
//                               ),
//                               const TextSpan(text: ', '),
//                               TextSpan(
//                                 text: 'release of information ',
//                                 style: const TextStyle(
//                                     color: Colors.blue,
//                                     decoration: TextDecoration.underline,
//                                     fontWeight: FontWeight.w700),
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () => Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (_) =>
//                                               ReleaseOfInformationScreen())),
//                               ),
//                               const TextSpan(text: ' & '),
//                               TextSpan(
//                                 text: ' privacy policy.',
//                                 style: const TextStyle(
//                                     color: Colors.blue,
//                                     decoration: TextDecoration.underline,
//                                     fontWeight: FontWeight.w700),
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () => Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (_) =>
//                                               PrivacyPolicyScreen())),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   if (_showTermsError)
//                     const Padding(
//                       padding: EdgeInsets.only(top: 8.0, left: 12),
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           'Please accept the terms and conditions',
//                           style: TextStyle(color: Colors.red, fontSize: 14),
//                         ),
//                       ),
//                     ),
//                   const SizedBox(height: 40),
//                   SizedBox(
//                     width: 376,
//                     height: 55,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // setState(() {
//                         //   _showImageError = _selectedImage == null;
//                         //   _showTermsError = !isChecked;
//                         // });
//                         // context.read<SignUpBloc>().add(SignupEvent(
//                         //       confirmPassword: confirmPasswordController.text,
//                         //       email: emailController.text,
//                         //       firstName: firstNameController.text,
//                         //       lastName: lastNameController.text,
//                         //       password: passwordController.text,
//                         //       phoneNumber: phoneController.text,
//                         //       referralCode: referralCodeController.text,
//                         //       userName: 'testingabcdd',
//                         //       zipCode: zipController.text,
//                         //     ));
//                         // SignUpRepository().signUpRepository();
//                         setState(
//                             () => _showImageError = _selectedImage == null);
//                         if (_formKey.currentState?.validate() == true &&
//                             _selectedImage != null &&
//                             isChecked ) {
//                           context.read<SignUpBloc>().add(SignupEvent(
//                                 confirmPassword: confirmPasswordController.text,
//                                 email: emailController.text,
//                                 firstName: firstNameController.text,
//                                 lastName: lastNameController.text,
//                                 password: passwordController.text,
//                                 phoneNumber: phoneController.text,
//                                 referralCode: referralCodeController.text,
//                                 userName: 'testingabcdd',
//                                 zipCode: zipController.text,
//                               ));
//                           // ScaffoldMessenger.of(context).showSnackBar(
//                           //   SnackBar(
//                           //     content:
//                           //         const Text("User Registered Successfully"),
//                           //     backgroundColor: Constants().themeColor,
//                           //     behavior: SnackBarBehavior.floating,
//                           //     margin: const EdgeInsets.all(16),
//                           //   ),
//                           // );
//                           // Navigator.push(context,
//                           //     MaterialPageRoute(builder: (_) => LoginScreen()));
//                         } else if (!isChecked) {
//                           // setState(() {
//                           //   _showImageError = _selectedImage == null;
//                           //   _showTermsError = !isChecked;
//                           // });
//                           //   ScaffoldMessenger.of(context).showSnackBar(
//                           //     const SnackBar(
//                           //       content: Text(
//                           //           "Please accept the terms and conditions."),
//                           //       backgroundColor: Colors.redAccent,
//                           //     ),
//                           //   );
//                         }
//                       },
//                       /*  onPressed: () {
//                         setState(() {
//                           _showImageError = _selectedImage == null;
//                           _showTermsError = !isChecked;

//                         });

//                         if (_formKey.currentState?.validate() == true &&
//                             _selectedImage != null &&
//                             isChecked) {
//                           // Submit to Bloc or API
//                           print("Proceed with signup");
//                         }
//                       },*/

//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Constants().themeColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 10),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             'Register',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: 'Satoshi',
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w800),
//                           ),
//                           const SizedBox(width: 5),
//                           Image.asset(
//                             'assets/loginbuttonicon.png',
//                             width: 23,
//                             height: 23,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Already have an account?",
//                           style: TextStyle(
//                               fontFamily: 'Satoshi',
//                               fontSize: 20,
//                               color: Color(0xff323747),
//                               fontWeight: FontWeight.w700)),
//                       GestureDetector(
//                         onTap: () => Navigator.push(context,
//                             MaterialPageRoute(builder: (_) => LoginScreen())),
//                         child: Text(" Login",
//                             style: TextStyle(
//                                 fontFamily: 'Satoshi',
//                                 fontSize: 20,
//                                 color: Constants().themeColor,
//                                 fontWeight: FontWeight.w700)),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }*/
