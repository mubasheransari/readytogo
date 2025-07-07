import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readytogo/widgets/back_next_button_widget.dart';
import '../../Constants/constants.dart';
import '../../Model/individual_profile_model.dart';
import '../login/bloc/login_bloc.dart';
import '../login/bloc/login_state.dart';
import 'group_assocation_edit_screen.dart';

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
  File? selectedImage;
  bool _submitted = false;
  final userId = GetStorage().read("id");

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

  bool _isAddressChanged() {
    final location =
        widget.profile.locations.isNotEmpty ? widget.profile.locations[0] : {};
    return streetController.text != (location['streetAddress'] ?? '') ||
        areaController.text != (location['area'] ?? '') ||
        cityController.text != (location['city'] ?? '') ||
        stateController.text != (location['state'] ?? '') ||
        zipController.text != (location['zipCode'] ?? '');
  }

  _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => selectedImage = File(image.path));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.profileLoaded &&
                state.profile != null) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text("Profile updated successfully",
              //         style: TextStyle(color: Colors.white)),
              //     backgroundColor: Colors.green,
              //   ),
              // );
              Navigator.pop(context);
            } else if (state.status == LoginStatus.updateProfileError) {
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: const CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child:
                                    Icon(Icons.arrow_back, color: Colors.black),
                              ),
                            ),
                            const SizedBox(
                                width:
                                    12), // 👈 Gap between back button and title
                            const Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Satoshi',
                              ),
                            ),
                          ],
                        ),
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
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              height: 158,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: selectedImage == null
                                  ? Column(
                                      children: [
                                        Center(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                              'http://173.249.27.4:343/${widget.profile.profileImageUrl}',
                                              height: 120,
                                              width: 130,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          height: 29,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: Constants().themeColor,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'change',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
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
                                              selectedImage!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          height: 29,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: Constants().themeColor,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'change',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.33,
                            ),
                            child: const Text(
                              'Personal Information',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Satoshi',
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child:
                                _buildField(firstNameController, "First Name"),
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

                          const SizedBox(height: 30),
                          Padding(
                            padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.49,
                            ),
                            child: const Text(
                              'Address Details',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Satoshi',
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildField(streetController, "Street Address"),
                          _buildField(areaController, "Area"),
                          _buildField(cityController, "City"),
                          _buildField(stateController, "State"),
                          _buildField(zipController, "Zip Code"),

                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    BackAndNextButton(
                      onBackPressed: () => Navigator.of(context).pop(),
                      onNextPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GroupAssociationEditIndividual(
                              profile: widget.profile,
                              area: areaController.text,
                              city: cityController.text,
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              phone: phoneController.text,
                              selectedImageFile: selectedImage,
                              imageUrl: widget.profile.profileImageUrl,
                              states: stateController.text,
                              street: streetController.text,
                              userid: userId,
                              zip: zipController.text,
                              email: widget.profile.email,
                              isAddressChanged: _isAddressChanged(),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            );
          },
        ),
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
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                fontFamily: 'Satoshi',
                color: Color(0xff323747),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Stack(
            children: [
              // Gradient background
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.85, //double.infinity,
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
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
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
}
