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

class EditIndividualProfileScreen extends StatefulWidget {
  final IndividualProfileModel profile;
  EditIndividualProfileScreen({super.key, required this.profile});

  @override
  State<EditIndividualProfileScreen> createState() =>
      _EditIndividualProfileScreenState();
}

class _EditIndividualProfileScreenState
    extends State<EditIndividualProfileScreen> {
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
    final p = widget.profile;
    firstNameController = TextEditingController(text: p.firstname);
    lastNameController = TextEditingController(text: p.lastname);
    emailController = TextEditingController(text: p.email);
    phoneController = TextEditingController(text: p.phoneNumber);
    streetController = TextEditingController(
        text: p.locations.isNotEmpty
            ? p.locations[0]['streetAddress'] ?? ''
            : '');
    areaController = TextEditingController(
        text: p.locations.isNotEmpty ? p.locations[0]['area'] ?? '' : '');
    cityController = TextEditingController(
        text: p.locations.isNotEmpty ? p.locations[0]['city'] ?? '' : '');
    stateController = TextEditingController(
        text: p.locations.isNotEmpty ? p.locations[0]['state'] ?? '' : '');
    zipController = TextEditingController(
        text: p.locations.isNotEmpty ? p.locations[0]['zipCode'] ?? '' : '');
  }

  _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _selectedImage = File(image.path));
    }
  }

  void _submit() {
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
  }

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
                            '1 of 2 page',
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
                                    child: SizedBox(
                                      height: 120,
                                      width: 130,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          'http://173.249.27.4:343/${widget.profile.profileImageUrl}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      SizedBox(
                                        height: 120,
                                        width: 130,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.file(
                                            _selectedImage!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Container(
                                        height: 23,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: Constants().themeColor,
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: _buildField(firstNameController, "First Name"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: _buildField(lastNameController, "Last Name"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: _buildField(emailController, "Email"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: _buildField(phoneController, "Phone Number"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child:
                              _buildField(streetController, "Street Address"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: _buildField(areaController, "Area"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: _buildField(cityController, "City"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: _buildField(stateController, "State"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: _buildField(zipController, "Zip Code"),
                        ),
                        // const SizedBox(height: 5),
                        // state.status == LoginStatus.updateProfileLoading
                        //     ? CircularProgressIndicator()
                        //     : ElevatedButton(
                        //         onPressed: _submit,
                        //         child: Text("Save Changes"),
                        //       ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  BackAndNextButton(onBackPressed: () {}, onNextPressed: () {}),
                  const SizedBox(height: 25),
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
