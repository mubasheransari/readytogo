import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readytogo/Model/organization_profile_model.dart';
import '../../Constants/constants.dart';
import '../../Model/get_all_individual_profile_model.dart';
import '../login/bloc/login_bloc.dart';
import '../login/bloc/login_event.dart';
import '../login/bloc/login_state.dart';

class GroupAssociationEditOrganizationalProfile extends StatefulWidget {
  final OrganizationProfileModel profile;
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

  const GroupAssociationEditOrganizationalProfile({
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
  State<GroupAssociationEditOrganizationalProfile> createState() =>
      _GroupAssociationEditOrganizationalProfileState();
}

class _GroupAssociationEditOrganizationalProfileState
    extends State<GroupAssociationEditOrganizationalProfile> {
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
      var storage = GetStorage();

      var useerid = storage.read('userid');
      final updatedProfile = widget.profile.copyWith(
        firstname: widget.firstName,
        lastname: widget.lastName,
        email: widget.email,
        phoneNumber: widget.phone,
        description: widget.description,
        locationJson: widget.isAddressChanged
            ? jsonEncode([
                {
                  if (widget.profile.locations != null &&
                      widget.profile.locations!.isNotEmpty &&
                      widget.profile.locations!.first.id != null)
                    "id": widget.profile.locations!.first.id, // existing Guid
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

        // jsonEncode([
        //     {
        //       "id": useerid,
        //       "streetAddress": widget.street,
        //       "area": widget.area,
        //       "city": widget.city,
        //       "state": widget.states,
        //       "zipCode": widget.zip,
        //       "latitude": 0,
        //       "longitude": 0
        //     }
        //   ])
        // : jsonEncode(widget.profile.locations),
      );
      if (_selectedImage != null) {
        print("Null nhi hai");
      } else {
        print("Null hai");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<GetAllProfessionalProfileModel> selectedGroups = [];
    GetAllProfessionalProfileModel? _dropdownValue;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.updateProfessionalProfileStatus ==
                  UpdateProfessionalProfileStatus.success &&
              state.professionalProfileModel != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Profile Updated Successfully",
                    style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.green,
              ),
            );
            print("PROFESSIONAL STATUS ${state.status}");
            print("PROFESSIONAL STATUS ${state.status}");
            Navigator.pop(context);
            Navigator.pop(context);
          } else if (state.removeAffiliationGroupStatus ==
              RemoveAffiliationGroupStatusProfessional.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Profile Updated Successfully",
                    style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.green,
              ),
            );
            print("PROFESSIONAL STATUS ${state.status}");
            print("PROFESSIONAL STATUS ${state.status}");
            Navigator.pop(context);
            Navigator.pop(context);
          } else if (state.addAffiliationGroupStatusProfessional ==
              AddAffiliationGroupStatusProfessional.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Profile Updated Successfully",
                    style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.green,
              ),
            );
            print("PROFESSIONAL STATUS ${state.status}");
            print("PROFESSIONAL STATUS ${state.status}");
            Navigator.pop(context);
            Navigator.pop(context);
          } else if (state.updateProfessionalProfileStatus ==
              UpdateProfessionalProfileStatus.failure) {
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
                                trailing: InkWell(
                                    onTap: () {
                                      /*     print("USER ID ${widget.userid}");
                                      print(
                                          "GROUP ID ${widget.profile.groupAssociations![index].groupId}");
                                      var storage = GetStorage();

                                      var useerid = storage.read('userid');
                                      context.read<LoginBloc>().add(
                                            RemoveAffiliationsProfrofessional(
                                              userId: useerid,
                                              groupId: widget
                                                  .profile
                                                  .groupAssociations![index]
                                                  .groupId
                                                  .toString(),
                                            ),
                                          ); //10@Testing
                                      print(state.removeAffiliationGroupStatus
                                          .toString());
                                      print(state.removeAffiliationGroupStatus
                                          .toString());
                                      print(state.removeAffiliationGroupStatus
                                          .toString());*/
                                    },
                                    child:
                                        Image.asset("assets/icon_delete.png")),
                                title: Text(
                                  widget.profile.groupAssociations![index]
                                      .groupName!,
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
                                  state.getAllProfessionalProfileModel ?? [];
                              return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.83,
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    canvasColor: Colors.white,
                                    dropdownMenuTheme: DropdownMenuThemeData(),
                                  ),
                                  child: DropdownButtonFormField<
                                      GetAllProfessionalProfileModel>(
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
                                      var storage = GetStorage();
                                      var useerid = storage.read('userid');
                                      print("USER ID $useerid");
                                      if (group != null &&
                                          !selectedGroups
                                              .any((g) => g.id == group.id)) {
                                        context.read<LoginBloc>().add(
                                              AddAffiliationsProfrofessional(
                                                userId: useerid,
                                                groupId: group.id,
                                              ),
                                            );

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
