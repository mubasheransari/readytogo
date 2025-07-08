import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readytogo/Model/get_all_individual_profile_model.dart';
import '../../Constants/constants.dart';
import '../../Model/individual_profile_model.dart';
import '../../Model/professional_profile_model.dart';
import '../login/bloc/login_bloc.dart';
import '../login/bloc/login_event.dart';
import '../login/bloc/login_state.dart';

class GroupAssociationEditProfessionalProfile extends StatefulWidget {
  final ProfessionalProfileModel profile;
  final File? selectedImageFile;
  final String? imageUrl;
  final String userid,
      firstName,
      lastName,
      phone,
      description,
      street,
      area,
      city,
      states,
      zip,
      email;
  final bool isAddressChanged;

  const GroupAssociationEditProfessionalProfile({
    super.key,
    required this.profile,
    this.selectedImageFile,
    this.imageUrl,
    required this.description,
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
  State<GroupAssociationEditProfessionalProfile> createState() =>
      _GroupAssociationEditProfessionalProfileState();
}

class _GroupAssociationEditProfessionalProfileState
    extends State<GroupAssociationEditProfessionalProfile> {
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
        description: widget.description,
        locationJson:
            widget.isAddressChanged ?

            jsonEncode([
          {
            "id": widget.userid,
            "streetAddress": widget.street,
            "area": widget.area,
            "city": widget.city,
            "state": widget.states,
            "zipCode": widget.zip,
            "latitude": 0,
            "longitude": 0
          }
        ])
      : jsonEncode(widget.profile.locations),
              
      );
      print("ADDRESS IS CHANGED ${widget.isAddressChanged}");
      print("ADDRESS IS CHANGED ${widget.isAddressChanged}");
      print("ADDRESS IS CHANGED ${widget.isAddressChanged}");
      print("ADDRESS IS CHANGED ${widget.isAddressChanged}");

      context.read<LoginBloc>().add(UpdateProfessionalProfile(
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
    final List<GetAllProfessionalProfileModel> selectedGroups = [];
    GetAllProfessionalProfileModel? _dropdownValue;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.updateProfessionalProfileSuccess &&
              state.professionalProfileModel != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Profile updated successfully",
                    style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state.status == LoginStatus.updateProfessionalProfileError) {
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
                        const SizedBox(height: 15),
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
                              widget.profile.groupAssociations!.length,
                              (index) => ListTile(
                                trailing: Image.asset("assets/icon_delete.png"),
                            
                                title: Text(
                                  widget.profile.groupAssociations![index].groupName!,
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
                       

                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              final allGroups =
                                  state.getAllProfessionalProfileModel ??
                                      []; 
                              return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.83,
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    canvasColor: Colors.white,
                                    dropdownMenuTheme: DropdownMenuThemeData(
                                        ),
                                  ),
                                  child: DropdownButtonFormField<
                                      GetAllProfessionalProfileModel>(
                                    elevation: 0,
                                    decoration: InputDecoration(
                                      hintText: "Select group",
                                      hintStyle:  TextStyle(
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
                                          GetAllProfessionalProfileModel>(
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
