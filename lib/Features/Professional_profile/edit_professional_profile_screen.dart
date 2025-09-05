import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readytogo/Model/professional_profile_model.dart';
import 'package:readytogo/widgets/back_next_button_widget.dart';
import '../../Constants/constants.dart';
import '../../Model/specialization_model.dart';
import '../../widgets/toast_widget.dart';
import '../login/bloc/login_bloc.dart';
import '../login/bloc/login_state.dart';
import 'group_association_professional_profile_screen.dart';

class EditProfessionalProfileScreen extends StatefulWidget {
  final ProfessionalProfileModel profile;
  EditProfessionalProfileScreen({super.key, required this.profile});

  @override
  State<EditProfessionalProfileScreen> createState() =>
      _EditProfessionalProfileScreenState();
}

class _EditProfessionalProfileScreenState
    extends State<EditProfessionalProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  bool _submitted = false;
  final userId = GetStorage().read("id");
  String? _selectedSpecializationId; // single pick (UI)
  List<String> _selectedSpecializationIds = []; // what we pass to API

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController descriptionController;
  late TextEditingController streetController;
  late TextEditingController areaController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController zipController;
  String? _selectedSpec;
  late final List<String> _specOptions;

  @override
  void initState() {
    super.initState();
    final p = widget.profile;
    firstNameController = TextEditingController(text: p.firstname ?? '');
    lastNameController = TextEditingController(text: p.lastname ?? '');
    emailController = TextEditingController(text: p.email ?? '');
    phoneController = TextEditingController(text: p.phoneNumber ?? '');
    descriptionController = TextEditingController(text: p.description ?? '');

    final loc = (p.locations != null && p.locations!.isNotEmpty)
        ? p.locations![0]
        : null;
    streetController = TextEditingController(text: loc?.streetAddress ?? '');
    areaController = TextEditingController(text: loc?.area ?? '');
    cityController = TextEditingController(text: loc?.city ?? '');
    stateController = TextEditingController(text: loc?.state ?? '');
    zipController = TextEditingController(text: loc?.zipCode ?? '');
    _specOptions = (widget.profile.specializationIds ?? [])
        .map((e) => e.name)
        .whereType<String>()
        .toList();

    if (_specOptions.isNotEmpty) {
      _selectedSpec = _specOptions.first; // optional preselect
    }
  }

  bool _isAddressChanged() {
    final location = (widget.profile.locations != null &&
            widget.profile.locations!.isNotEmpty)
        ? widget.profile.locations![0]
        : null;

    return location == null ||
        streetController.text != (location.streetAddress ?? '') ||
        areaController.text != (location.area ?? '') ||
        cityController.text != (location.city ?? '') ||
        stateController.text != (location.state ?? '') ||
        zipController.text != (location.zipCode ?? '');
  }

  // @override
  // void initState() {
  //   super.initState();
  //   final p = widget.profile;
  //   firstNameController = TextEditingController(text: p.firstname);
  //   lastNameController = TextEditingController(text: p.lastname);
  //   emailController = TextEditingController(text: p.email);
  //   phoneController = TextEditingController(text: p.phoneNumber);
  //   descriptionController = TextEditingController(text: p.description);
  //   streetController = TextEditingController(
  //       text: p.locations.isNotEmpty
  //           ? p.locations[0]['streetAddress'] ?? ''
  //           : '');
  //   areaController = TextEditingController(
  //       text: p.locations.isNotEmpty ? p.locations[0]['area'] ?? '' : '');
  //   cityController = TextEditingController(
  //       text: p.locations.isNotEmpty ? p.locations[0]['city'] ?? '' : '');
  //   stateController = TextEditingController(
  //       text: p.locations.isNotEmpty ? p.locations[0]['state'] ?? '' : '');
  //   zipController = TextEditingController(
  //       text: p.locations.isNotEmpty ? p.locations[0]['zipCode'] ?? '' : '');
  // }

  // bool _isAddressChanged() {
  //   final location =
  //       widget.profile.locations.isNotEmpty ? widget.profile.locations[0] : {};
  //   return streetController.text != (location['streetAddress'] ?? '') ||
  //       areaController.text != (location['area'] ?? '') ||
  //       cityController.text != (location['city'] ?? '') ||
  //       stateController.text != (location['state'] ?? '') ||
  //       zipController.text != (location['zipCode'] ?? '');
  // }

  _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => selectedImage = File(image.path));
    }
  }

  var selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            // if (state.status == LoginStatus.profileLoaded &&
            //     state.profile != null) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(
            //       content: Text("Profile updated successfully",
            //           style: TextStyle(color: Colors.white)),
            //       backgroundColor: Colors.green,
            //     ),
            //   );
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
            final list = state.specializationModel ?? <SpecializationModel>[];

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
                              right: MediaQuery.of(context).size.width * 0.30,
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
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: _buildField(
                                isMultiline: true,
                                descriptionController,
                                "Description"),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    // right: MediaQuery.of(context).size.width *
                                    //     0.25,
                                    left: 8),
                                child: const Text(
                                  'Specializations',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Satoshi',
                                    color: Color(0xff323747),
                                  ),
                                ),
                              ),

                              BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                                  final list = state.specializationModel ??
                                      <SpecializationModel>[];
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.83,
                                    child: DropdownButtonFormField<String>(
                                      value: _selectedSpecializationId,
                                      decoration: InputDecoration(
                                        hintText: "Select specialization",
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 12),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16)),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16)),
                                        ),
                                      ),
                                      items: [
                                        for (final s in list)
                                          DropdownMenuItem<String>(
                                            value: s.id,
                                            child: Text(
                                              s.name,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Satoshi',
                                              ),
                                            ),
                                          ),
                                      ],
                                      onChanged: (id) => setState(() {
                                        _selectedSpecializationId = id;
                                        // store as array for the API (single choice -> 1 element array)
                                        _selectedSpecializationIds =
                                            id == null ? [] : [id];
                                      }),
                                    ),
                                  );
                                },
                              ),

                              /* BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                                  final List<SpecializationModel> list =
                                      state.specializationModel!;
                                  String? _selectedSpecializationId;

                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.83,
                                    child: DropdownButtonFormField<String>(
                                      value: _selectedSpecializationId,
                                      decoration: InputDecoration(
                                        hintText: "Select specialization",
                                        hintStyle: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: 'Satoshi',
                                          color: Color(0xff323747),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 12),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16)),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16)),
                                        ),
                                      ),
                                      // 🔹 Just map: List<SpecializationModel> -> DropdownMenuItem<String>
                                      items: [
                                        for (final s in list)
                                          DropdownMenuItem<String>(
                                            value: s.id,
                                            child: Text(
                                              s.name,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Satoshi',
                                              ),
                                            ),
                                          ),
                                      ],
                                      onChanged: (id) => setState(
                                          () => _selectedSpecializationId = id),
                                    ),
                                  );
                                },
                              ),*/

                              /* Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15),
                                  child: DropdownButtonFormField<String>(
                                    // hint: const Text('Select Specialization'),
                                    value: _specOptions.contains(_selectedSpec)
                                        ? _selectedSpec
                                        : null,
                                    items: _specOptions
                                        .map((n) => DropdownMenuItem<String>(
                                              value: n,
                                              child: Text(
                                                _selectedSpec == null
                                                    ? "Select Specialization"
                                                    : n,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Satoshi',
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (val) =>
                                        setState(() => _selectedSpec = val),
                                    decoration: InputDecoration(
                                      // hintText removed to allow `hint:` to show
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 12),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )*/

                              // Padding(
                              //   padding: const EdgeInsets.only(left: 8.0),
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(
                              //         left: 15.0, right: 15),
                              //     child: DropdownButtonFormField<String>(
                              //       hint: Text('Select Specialization'),
                              //       value: _specOptions.contains(_selectedSpec)
                              //           ? _selectedSpec
                              //           : null,
                              //       items: _specOptions
                              //           .map((n) => DropdownMenuItem<String>(
                              //                 value: n,
                              //                 child: Text(
                              //                   n,
                              //                   style: TextStyle(
                              //                     fontSize: 18,
                              //                     color: Colors.black87,
                              //                     fontWeight: FontWeight.w700,
                              //                     fontFamily: 'Satoshi',
                              //                   ),
                              //                 ),
                              //               ))
                              //           .toList(),
                              //       onChanged: (val) =>
                              //           setState(() => _selectedSpec = val),
                              //       decoration: InputDecoration(
                              //         hintText: "Select specialization",
                              //         contentPadding:
                              //             const EdgeInsets.symmetric(
                              //                 horizontal: 12, vertical: 12),
                              //         border: OutlineInputBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(16)),
                              //         enabledBorder: const OutlineInputBorder(
                              //           borderSide:
                              //               BorderSide(color: Colors.white),
                              //         ),
                              //         focusedBorder: const OutlineInputBorder(
                              //           borderSide:
                              //               BorderSide(color: Colors.white),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.40,
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
                                GroupAssociationEditProfessionalProfile(
                              specializationIds: _selectedSpecializationIds,
                              description: descriptionController.text,
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
                              email: widget.profile.email.toString(),
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

  /*Widget _buildField(
    TextEditingController controller,
    String label, {
    bool obscureText = false,
    bool isMultiline = false, // ✅ New
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
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE6DCFD), Color(0xFFD8E7FF)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextFormField(
                controller: controller,
                obscureText: obscureText,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
                keyboardType:
                    isMultiline ? TextInputType.multiline : TextInputType.text,
                minLines: isMultiline ? 1 : 1,
                maxLines: isMultiline ? null : 1, // ✅ allow growth
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
            ),
          ),
        ],
      ),
    );
  }*/

  // Widget _buildField(
  //   TextEditingController controller,
  //   String label, {
  //   bool obscureText = false,
  //   bool isMultiline = false, // ✅ New parameter
  // }) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.only(left: 12.0),
  //           child: Text(
  //             label,
  //             style: const TextStyle(
  //               fontSize: 18,
  //               fontWeight: FontWeight.w900,
  //               fontFamily: 'Satoshi',
  //               color: Color(0xff323747),
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 5),
  //         Stack(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.only(left: 8.0),
  //               child: Container(
  //                 width: MediaQuery.of(context).size.width * 0.85,
  //                 height: isMultiline ? 120 : 60, // ✅ Adjust height
  //                 decoration: BoxDecoration(
  //                   gradient: const LinearGradient(
  //                     colors: [Color(0xFFE6DCFD), Color(0xFFD8E7FF)],
  //                     begin: Alignment.centerLeft,
  //                     end: Alignment.centerRight,
  //                   ),
  //                   borderRadius: BorderRadius.circular(16),
  //                 ),
  //               ),
  //             ),
  //             TextFormField(
  //               controller: controller,
  //               obscureText: obscureText,
  //               autovalidateMode: AutovalidateMode.onUserInteraction,
  //               validator: (value) =>
  //                   value == null || value.isEmpty ? 'Required' : null,
  //               maxLines: isMultiline ? null : 1, // ✅ Allow multiple lines
  //               minLines: isMultiline ? 4 : 1, // ✅ Set min height for multiline
  //               decoration: InputDecoration(
  //                 hintText: 'Enter $label',
  //                 hintStyle: const TextStyle(
  //                   color: Color(0xff666F80),
  //                   fontSize: 18,
  //                   fontFamily: 'Satoshi',
  //                   fontWeight: FontWeight.w500,
  //                 ),
  //                 filled: true,
  //                 fillColor: Colors.transparent,
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(16),
  //                   borderSide: BorderSide.none,
  //                 ),
  //                 contentPadding: const EdgeInsets.symmetric(
  //                   horizontal: 25,
  //                   vertical: 18,
  //                 ),
  //                 errorStyle: const TextStyle(
  //                   color: Colors.red,
  //                   fontSize: 14,
  //                   height: 1.5,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildField(TextEditingController controller, String label,
  //     {bool obscureText = false}) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.only(left: 12.0),
  //           child: Text(
  //             label,
  //             style: const TextStyle(
  //               fontSize: 18,
  //               fontWeight: FontWeight.w900,
  //               fontFamily: 'Satoshi',
  //               color: Color(0xff323747),
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 5),
  //         Stack(
  //           children: [
  //             // Gradient background
  //             Padding(
  //               padding: const EdgeInsets.only(left: 8.0),
  //               child: Container(
  //                 width: MediaQuery.of(context).size.width *
  //                     0.85, //double.infinity,
  //                 height: 60,
  //                 decoration: BoxDecoration(
  //                   gradient: const LinearGradient(
  //                     colors: [Color(0xFFE6DCFD), Color(0xFFD8E7FF)],
  //                     begin: Alignment.centerLeft,
  //                     end: Alignment.centerRight,
  //                   ),
  //                   borderRadius: BorderRadius.circular(16),
  //                 ),
  //               ),
  //             ),
  //             // Text field (transparent fill to show gradient)
  //             TextFormField(

  //               controller: controller,
  //               obscureText: obscureText,
  //               autovalidateMode: AutovalidateMode.onUserInteraction,
  //               validator: (value) =>
  //                   value == null || value.isEmpty ? 'Required' : null,
  //               decoration: InputDecoration(
  //                 hintText: 'Enter $label',
  //                 hintStyle: const TextStyle(
  //                   color: Color(0xff666F80),
  //                   fontSize: 18,
  //                   fontFamily: 'Satoshi',
  //                   fontWeight: FontWeight.w500,
  //                 ),
  //                 filled: true,
  //                 fillColor: Colors.transparent,
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(16),
  //                   borderSide: BorderSide.none,
  //                 ),
  //                 contentPadding:
  //                     const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
  //                 errorStyle: const TextStyle(
  //                   color: Colors.red,
  //                   fontSize: 14,
  //                   height: 1.5,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
