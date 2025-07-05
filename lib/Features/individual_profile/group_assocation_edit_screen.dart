import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readytogo/widgets/back_next_button_widget.dart';
import '../../Constants/api_constants.dart';
import '../../Constants/constants.dart';
import '../../Model/get_all_associated_groups_model.dart';
import '../../Model/individual_profile_model.dart';
import '../../widgets/custom_dropdown_widget.dart';
import '../login/bloc/login_bloc.dart';
import '../login/bloc/login_event.dart';
import '../login/bloc/login_state.dart';

class GroupAssociationEditIndividual extends StatefulWidget {
  final IndividualProfileModel profile;
  final File? selectedImageFile;
  final String? imageUrl;
  final String userid,
      firstName,
      lastName,
      phone,
      street,
      area,
      city,
      states,
      zip,
      email;
  final bool isAddressChanged;

  const GroupAssociationEditIndividual({
    super.key,
    required this.profile,
    this.selectedImageFile,
    this.imageUrl,
    required this.userid,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.street,
    required this.area,
    required this.city,
    required this.states,
    required this.zip,
    required this.email,
    required this.isAddressChanged,
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

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.selectedImageFile; // ✅ FIX
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final updatedProfile = widget.profile.copyWith(
          firstname: widget.firstName,
          lastname: widget.lastName,
          email: widget.email,
          phoneNumber: widget.phone,
          locations: [
            {
              "id": widget.userid,
              "streetAddress": "samar",
              "area": "vewvwevew",
              "city": "wvevewvewv",
              "state": "ewkhfkjhewiufhew",
              "zipCode": "34796983",
              "latitude": 0,
              "longitude": 0
            }
          ]
          // widget.isAddressChanged
          //     ?
          // [
          //     {
          //       "id": widget.userid,
          //       "streetAddress": widget.street,
          //       "area": widget.area,
          //       "city": widget.city,
          //       "state": widget.states,
          //       "zipCode": widget.zip,
          //       "latitude": 0,
          //       "longitude": 0
          //     }
          //   ]
          //     : widget.profile.locations,
          );
      print("ADDRESS IS CHANGED ${widget.isAddressChanged}");
      print("ADDRESS IS CHANGED ${widget.isAddressChanged}");
      print("ADDRESS IS CHANGED ${widget.isAddressChanged}");
      print("ADDRESS IS CHANGED ${widget.isAddressChanged}");

      context.read<LoginBloc>().add(UpdateIndividualProfile(
            userId: widget.userid,
            profile: updatedProfile,
            profileImage: _selectedImage,
          ));
    }
  }

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: () async {
        final XFile? image =
            await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          setState(() => _selectedImage = File(image.path));
        }
      },
      child: Container(
        height: 148,
        width: 120,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: _selectedImage != null
            ? Column(
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
                    width: 80,
                    decoration: BoxDecoration(
                      color: Constants().themeColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Change',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            : Center(
                child: SizedBox(
                  height: 120,
                  width: 130,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'http://173.249.27.4:343/${widget.imageUrl}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<GetAllAssociatedGroupModel> selectedGroups = [];
    GetAllAssociatedGroupModel? _dropdownValue;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.profileLoaded &&
              state.profile != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
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
                  const SizedBox(height: 60),
                  Row(
                    children: [
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
                      const Spacer(),
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
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.40),
                          child: const Text(
                            'Group/Association',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Satoshi',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            children: List.generate(
                              widget.profile.groupAssociations.length,
                              (index) => ListTile(
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    print(
                                        "ID ${widget.profile.groupAssociations[index]['id']}");
                                  },
                                ),
                                title: Text(
                                  widget.profile.groupAssociations[index]
                                      ['groupName'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Satoshi',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        /* CustomDropdown(//10@Testing
                          hint: "Select Group",
                          onChanged: (value) {},
                          items: selectedGroups
                              .map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value.name,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  value.name,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            );
                          }).toList(),
                        ),*/
                        //  SizedBox(
                        //   width: MediaQuery.of(context).size.width * 0.84,
                        //   child: DropdownButtonFormField<
                        //       GetAllAssociatedGroupModel>(
                        //     //  isExpanded: true,
                        //     decoration: InputDecoration(
                        //       hintText: "Select group",
                        //       contentPadding: const EdgeInsets.symmetric(
                        //           horizontal: 12, vertical: 12),
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(16),
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(16),
                        //         borderSide:
                        //             const BorderSide(color: Colors.grey),
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(16),
                        //         borderSide:
                        //             const BorderSide(color: Colors.purple),
                        //       ),
                        //     ),
                        //     value: _dropdownValue,
                        //     items: selectedGroups.map((group) {
                        //       return DropdownMenuItem<
                        //           GetAllAssociatedGroupModel>(
                        //         value: group,
                        //         child: Text(group.name),
                        //       );
                        //     }).toList(),
                        //     onChanged: (group) {
                        //       if (group != null &&
                        //           !selectedGroups.contains(group)) {
                        //         setState(() {
                        //           _dropdownValue = group;
                        //           selectedGroups.add(group);
                        //         });
                        //       }
                        //     },
                        //   ),
                        // ),10@Testing

                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.53),
                          child: const Text(
                            'Select Group',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Satoshi',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              final allGroups =
                                  state.getAllAssociatedGroupModel ??
                                      []; // full API list
                              return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.83,
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    canvasColor: Colors.white,
                                    dropdownMenuTheme: DropdownMenuThemeData(
                                        //elevation: 0, // ✅ Set elevation to 0
                                        ),
                                  ),
                                  child: DropdownButtonFormField<
                                      GetAllAssociatedGroupModel>(
                                    elevation: 0,
                                    decoration: InputDecoration(
                                      hintText: "Select group",
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Satoshi',
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 12),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                    ),
                                    value: _dropdownValue,
                                    items: allGroups.map((group) {
                                      return DropdownMenuItem<
                                          GetAllAssociatedGroupModel>(
                                        value: group,
                                        child: Text(
                                          group.name,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Satoshi',
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (group) {
                                      if (group != null &&
                                          !selectedGroups.contains(group)) {
                                        setState(() {
                                          _dropdownValue = group;
                                          selectedGroups.add(group);
                                        });
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        /*  BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            GetAllAssociatedGroupModel? _selectedGroup;
                            // 1️⃣ Loading indicator while waiting
                            if (state.status ==
                                LoginStatus.getAllGroupsLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            // 2️⃣ Error text
                            if (state.status == LoginStatus.getAllGroupsError) {
                              return const Text('Failed to load groups');
                            }//10@Testing

                            // 3️⃣ Success → build dropdown

                            return DropdownButtonFormField<
                                GetAllAssociatedGroupModel>(
                              hint: const Text(
                                  'Select group'), // <-- “Select group”
                              value: _selectedGroup, // currently chosen
                              items: state.getAllAssociatedGroupModel!.map((g) {
                                return DropdownMenuItem<
                                    GetAllAssociatedGroupModel>(
                                  value: g,
                                  child: Row(
                                    children: [
                                      // Optional icon (remove if you don’t need it)
                                      Image.network(
                                        '${ApiConstants.baseDomain}${g.iconUrl}',
                                        color:  Colors.black,
                                        width: 24,
                                        height: 24,
                                        errorBuilder: (_, __, ___) =>
                                            const SizedBox(width: 24),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(g.name),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() => _selectedGroup = value);
                                // ‑‑ if you need to pass the ID somewhere:
                                // context.read<SomeOtherBloc>().add(SetGroupId(value?.id));
                              },
                              // decoration: const InputDecoration(
                              //   border: OutlineInputBorder(),
                              //   contentPadding: EdgeInsets.symmetric(
                              //       horizontal: 12, vertical: 8),
                              // ),
                              validator: (value) => value == null
                                  ? 'Please select a group'
                                  : null,
                            );
                          },
                        ),*/
                        // const SizedBox(height: 20),
                        // _buildProfileImage(),
                        // ListView.builder(
                        //     physics: NeverScrollableScrollPhysics(),
                        //     shrinkWrap: true,
                        //     itemCount: widget.profile.groupAssociations.length,
                        //     itemBuilder: (context, index) {
                        //       return ListTile(
                        //           title: Text(widget.profile
                        //               .groupAssociations[index]['groupName']));
                        //     })
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: 342,
                    height: 60,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants().themeColor,
                          minimumSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
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
                                fontWeight: FontWeight.w700,
                              ),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/*class GroupAssociationEditIndividual extends StatefulWidget {
  final IndividualProfileModel profile;
 // File? selectedImage;
 final File? selectedImageFile;
final String? imageUrl;
  String userid,
      firstName,
      lastName,
      phone,
      street,
      area,
      city,
      states,
      zip,
      email;

  GroupAssociationEditIndividual(
      {super.key,
      required this.profile,
      this.selectedImageFile,
      this.imageUrl,
      required this.userid,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.street,
      required this.area,
      required this.city,
      required this.states,
      required this.zip,
      required this.email});

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

  // late TextEditingController firstNameController;
  // late TextEditingController lastNameController;
  // late TextEditingController emailController;
  // late TextEditingController phoneController;
  // late TextEditingController streetController;
  // late TextEditingController areaController;
  // late TextEditingController cityController;
  // late TextEditingController stateController;
  // late TextEditingController zipController;

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

  void _submit() {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      final updatedProfile = widget.profile.copyWith(
        firstname: widget.firstName,
        lastname: widget.lastName,
        email: widget.email,
        phoneNumber: widget.phone,
        locations: [
          {
            "streetAddress": widget.street,
            "area": widget.area,
            "city": widget.city,
            "state": widget.states,
            "zipCode": widget.zip,
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
                        Padding(//Testing
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
                        onPressed: () {
                          _submit();
                        },
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
*/
