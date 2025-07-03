import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readytogo/widgets/back_next_button_widget.dart';
import '../../Constants/constants.dart';
import '../../Model/individual_profile_model.dart';
import '../login/bloc/login_bloc.dart';
import '../login/bloc/login_event.dart';
import '../login/bloc/login_state.dart';

class GroupAssociationEditIndividual extends StatefulWidget {
  GroupAssociationEditIndividual({
    super.key,
  });

  @override
  State<GroupAssociationEditIndividual> createState() =>
      _GroupAssociationEditIndividualState();
}

class _GroupAssociationEditIndividualState
    extends State<GroupAssociationEditIndividual> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  bool _submitted = false;

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController streetController;
  late TextEditingController areaController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController zipController;

  @override
  void initState() {
    super.initState();
    // final p = widget.profile;
    // firstNameController = TextEditingController(text: p.firstname);
    // lastNameController = TextEditingController(text: p.lastname);
    // emailController = TextEditingController(text: p.email);
    // phoneController = TextEditingController(text: p.phoneNumber);
    // streetController = TextEditingController(
    //     text: p.locations.isNotEmpty
    //         ? p.locations[0]['streetAddress'] ?? ''
    //         : '');
    // areaController = TextEditingController(
    //     text: p.locations.isNotEmpty ? p.locations[0]['area'] ?? '' : '');
    // cityController = TextEditingController(
    //     text: p.locations.isNotEmpty ? p.locations[0]['city'] ?? '' : '');
    // stateController = TextEditingController(
    //     text: p.locations.isNotEmpty ? p.locations[0]['state'] ?? '' : '');
    // zipController = TextEditingController(
    //     text: p.locations.isNotEmpty ? p.locations[0]['zipCode'] ?? '' : '');
  }

  /* void _submit() {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      final updatedProfile = widget.profile.copyWith(
        firstname: firstNameController.text,
        lastname: lastNameController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
        locations: [
          {
            "streetAddress": streetController.text,
            "area": areaController.text,
            "city": cityController.text,
            "state": stateController.text,
            "zipCode": zipController.text,
          }
        ],
      );

      final userId = GetStorage().read("id");

      if (userId != null) {
        context.read<LoginBloc>().add(UpdateIndividualProfile(
              userId: userId,
              profile: updatedProfile,
              profileImage: _selectedImage,
            ));
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.profileLoaded &&
              state.profile != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Profile updated successfully",
                    style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state.status == LoginStatus.updateProfileError) {
            print("UPDATE FAILED ${state.errorMessage}");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? "Update failed"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Container(
                      color: Colors.grey[200],
                      child: Row(
                        children: [
                          const SizedBox(width: 5),
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const CircleAvatar(
                              radius: 19,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.arrow_back,
                                  color: Colors.black, size: 19),
                            ),
                          ),
                          const SizedBox(width: 17),
                          const Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Satoshi',
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.37),
                          const Text(
                            '2 of 2 page',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Satoshi',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.40),
                          child: Text(
                            'Group/Assocation',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Satoshi',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: 342,
                    height: 60,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants().themeColor,
                          minimumSize: const Size(200, 50),
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
                              'Save Changes',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Satoshi',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 10),
                            Image.asset(
                              'assets/update_check.png',
                              width: 20,
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // const SizedBox(height: 25),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
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
          Stack(
            children: [
              // Gradient background
              Container(
                width:
                    MediaQuery.of(context).size.width * 0.90, //double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE6DCFD), Color(0xFFD8E7FF)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              // Text field (transparent fill to show gradient)
              TextFormField(
                controller: controller,
                obscureText: obscureText,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
                decoration: InputDecoration(
                  hintText: 'Enter $label',
                  hintStyle: const TextStyle(
                    color: Color(0xff666F80),
                    fontSize: 18,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  errorStyle: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

/*  Widget _buildField(TextEditingController controller, String label,
      {bool obscureText = false}) {
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
        Container(
          width: 376,
          height: 60,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFE6DCFD),
                Color(0xFFD8E7FF),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,
            decoration: InputDecoration(
              hintText: 'Enter $label',
              hintStyle: const TextStyle(
                color: Color(0xff666F80),
                fontSize: 18,
                fontFamily: 'Satoshi',
                fontWeight: FontWeight.w500,
              ),
              filled: true,
              fillColor: Colors.transparent, // shows gradient background
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }*/

  // Widget _buildField(TextEditingController controller, String label) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 12),
  //     child: TextFormField(
  //       controller: controller,
  //       decoration: InputDecoration(
  //         labelText: label,
  //         border: OutlineInputBorder(),
  //       ),
  //       validator: (value) =>
  //           value == null || value.isEmpty ? 'Required' : null,
  //     ),
  //   );
  // }
}
