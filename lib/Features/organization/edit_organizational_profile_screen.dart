import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readytogo/Model/organization_profile_model.dart';
import 'package:readytogo/widgets/back_next_button_widget.dart';
import 'package:readytogo/widgets/toast_widget.dart';
import '../../Constants/constants.dart';
import '../../Model/individual_profile_model.dart';
import '../../Model/professional_profile_model.dart';
import '../login/bloc/login_bloc.dart';
import '../login/bloc/login_state.dart';

class EditOrganizationalProfileScreen extends StatefulWidget {
  final OrganizationProfileModel profile;
  EditOrganizationalProfileScreen({super.key, required this.profile});

  @override
  State<EditOrganizationalProfileScreen> createState() =>
      _EditOrganizationalProfileScreenState();
}

class _EditOrganizationalProfileScreenState
    extends State<EditOrganizationalProfileScreen> {
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
    // streetController = TextEditingController(
    //     text: p.locations!.isNotEmpty
    //         ? p.locations!['streetAddress'] ?? ''
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

  bool _isAddressChanged() {
    return false;
    // final location =
    //     widget.profile.locations.isNotEmpty ? widget.profile.locations[0] : {};
    // return streetController.text != (location['streetAddress'] ?? '') ||
    //     areaController.text != (location['area'] ?? '') ||
    //     cityController.text != (location['city'] ?? '') ||
    //     stateController.text != (location['state'] ?? '') ||
    //     zipController.text != (location['zipCode'] ?? '');
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
            // if (state.status == LoginStatus.profileLoaded &&
            //     state.profile != null) {
            //   // ScaffoldMessenger.of(context).showSnackBar(
            //   //   SnackBar(
            //   //     content: Text("Profile updated successfully",
            //   //         style: TextStyle(color: Colors.white)),
            //   //     backgroundColor: Colors.green,
            //   //   ),
            //   // );
            //   Navigator.pop(context);
            // } else if (state.status == LoginStatus.updateProfileError) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(
            //       content: Text(state.errorMessage ?? "Update failed"),
            //       backgroundColor: Colors.red,
            //     ),
            //   );
            // }
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
                            const SizedBox(width: 12),
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
                          //10@Testing
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
                          InkWell(
                            onTap: () {
                              toastWidget(
                                  "The email address is locked for editing",
                                  Colors.red);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: _buildField(emailController, "Email",
                                  readOnly: true),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: _buildField(phoneController, "Phone Number"),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: EdgeInsets.only(
                                left:
                                    0 //MediaQuery.of(context).size.width * 0.44,
                                ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
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
                                SizedBox(
                                  width: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 7.0),
                                  child: InkWell(
                                    onTap: () {
                                      _showEditLocationDialog(
                                          context, null, null);
                                    },
                                    child: Text(
                                      "Add Address".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Constants().themeColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Satoshi',
                                      ),
                                    ),
                                  ),
                                ),
                                // InkWell(
                                //   onTap: () {
                                // _showEditLocationDialog(
                                //     context, null, null);
                                //   },
                                //   child: Container(
                                //     height: 30,
                                //     width: 1800,
                                //     decoration: BoxDecoration(
                                //         color: Constants().themeColor),
                                //     child: Center(
                                //       child: Text(
                                //         "Add Address",
                                //         style: TextStyle(
                                //           fontSize: 18,
                                //           color: Colors.black87,
                                //           fontWeight: FontWeight.w700,
                                //           fontFamily: 'Satoshi',
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          // _buildAllLocations(widget.profile.locations ?? []),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.profile.locations!.length,
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.03,
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          final location =
                                              widget.profile.locations![index];
                                          _showEditLocationDialog(
                                              context, location, index);
                                        },
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${widget.profile.locations![index].streetAddress ?? ""}, ${widget.profile.locations![index].area ?? ""}, ${widget.profile.locations![index].city ?? ""}, ${widget.profile.locations![index].state ?? ""}',
                                            style: TextStyle(
                                              fontFamily: 'Satoshi',
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })),
                          // _buildField(streetController, "Street Address"),
                          // _buildField(areaController, "Area"),
                          // _buildField(cityController, "City"),
                          // _buildField(stateController, "State"),
                          // _buildField(zipController, "Zip Code"),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    BackAndNextButton(
                      onBackPressed: () => Navigator.of(context).pop(),
                      onNextPressed: () {
                        print(state.profile!.userId);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         GroupAssociationEditIndividual(
                        //       profile: widget.profile,
                        //       area: areaController.text,
                        //       city: cityController.text,
                        //       firstName: firstNameController.text,
                        //       lastName: lastNameController.text,
                        //       phone: phoneController.text,
                        //       selectedImageFile: selectedImage,
                        //       imageUrl: widget.profile.profileImageUrl,
                        //       states: stateController.text,
                        //       street: streetController.text,
                        //       userid: userId,
                        //       zip: zipController.text,
                        //       email: widget.profile.email,
                        //       isAddressChanged: _isAddressChanged(),
                        //     ),
                        //   ),
                        // );
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

  void _showEditLocationDialog(
      BuildContext context, Location? location, int? index) {
    // Controllers pre-filled if editing
    final streetController =
        TextEditingController(text: location?.streetAddress ?? "");
    final areaController = TextEditingController(text: location?.area ?? "");
    final cityController = TextEditingController(text: location?.city ?? "");
    final stateController = TextEditingController(text: location?.state ?? "");
    final zipController = TextEditingController(text: location?.zipCode ?? "");

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? 'Add Address' : 'Edit Address'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: streetController,
                decoration: const InputDecoration(labelText: 'Street Address'),
              ),
              TextField(
                controller: areaController,
                decoration: const InputDecoration(labelText: 'Area'),
              ),
              TextField(
                controller: cityController,
                decoration: const InputDecoration(labelText: 'City'),
              ),
              TextField(
                controller: stateController,
                decoration: const InputDecoration(labelText: 'State'),
              ),
              TextField(
                controller: zipController,
                decoration: const InputDecoration(labelText: 'Zip Code'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text(index == null ? 'Add Address' : 'Edit Address'),
            onPressed: () {
              final newLocation = Location(
                id: location?.id,
                streetAddress: streetController.text.trim(),
                area: areaController.text.trim(),
                city: cityController.text.trim(),
                state: stateController.text.trim(),
                zipCode: zipController.text.trim(),
                latitude: location?.latitude,
                longitude: location?.longitude,
              );

              setState(() {
                if (index == null) {
                  // Add mode
                  if (widget.profile.locations == null) {
                    // if list is null, create it once
                    widget.profile.locations = []; // ❌ won't work if final
                    // instead: make sure your Profile model initializes locations as []
                    // OR handle new profile creation before this call
                  }
                  widget.profile.locations!.add(newLocation);
                } else {
                  // Edit mode
                  widget.profile.locations![index] = newLocation;
                }
              });

              Navigator.pop(context);

              // Optional: BLoC API update
              // context.read<ProfileBloc>().add(UpdateProfileEvent(profile: widget.profile));
            },
          ),
        ],
      ),
    );
  }

  /* void _showEditLocationDialog(
      BuildContext context, Location location, int index) {
    final streetController =
        TextEditingController(text: location.streetAddress ?? "");
    final areaController = TextEditingController(text: location.area ?? "");
    final cityController = TextEditingController(text: location.city ?? "");
    final stateController = TextEditingController(text: location.state ?? "");

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit Location'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: streetController,
                decoration: InputDecoration(labelText: 'Street Address'),
              ),
              TextField(
                controller: areaController,
                decoration: InputDecoration(labelText: 'Area'),
              ),
              TextField(
                controller: cityController,
                decoration: InputDecoration(labelText: 'City'),
              ),
              TextField(
                controller: stateController,
                decoration: InputDecoration(labelText: 'State'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text('Save'),
            onPressed: () {
              setState(() {
                widget.profile.locations![index] = location.copyWith(
                  streetAddress: streetController.text,
                  area: areaController.text,
                  city: cityController.text,
                  state: stateController.text,
                );
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }*/

  Widget _buildInfoRow(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Satoshi',
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'Satoshi',
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAllLocations(List<Location> locations) {
    if (locations.isEmpty) {
      return _buildInfoRow('Location:', 'No Address Provided');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < locations.length; i++)
          _buildInfoRow(
            '  Edit Address 1 ${i + 1}:',
            '${locations[i].streetAddress ?? ""}, ${locations[i].area ?? ""}, ${locations[i].city ?? ""}, ${locations[i].state ?? ""}',
          ),
      ],
    );
  }

  Widget _buildField(
    TextEditingController controller,
    String label, {
    bool obscureText = false,
    bool isMultiline = false,
    bool readOnly = false,
  }) {
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
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE6DCFD), Color(0xFFD8E7FF)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: GestureDetector(
                onTap: () {
                  if (readOnly) {
                    toastWidget("Unable to edit $label", Colors.red);
                  }
                },
                child: AbsorbPointer(
                  absorbing: readOnly,
                  child: TextFormField(
                    controller: controller,
                    obscureText: obscureText,
                    readOnly:
                        readOnly, // still set readOnly for keyboard suppression
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                    keyboardType: isMultiline
                        ? TextInputType.multiline
                        : TextInputType.text,
                    minLines: isMultiline ? 1 : 1,
                    maxLines: isMultiline ? null : 1,
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
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 18),
                      errorStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
