import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../Constants/constants.dart';
import '../../Model/get_all_associated_groups_model.dart';
import '../../Model/individual_profile_model.dart';
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
      print("id :${widget.userid}"); //10@Testing
      // final updatedProfile = widget.profile.copyWith(
      //   firstname: widget.firstName,
      //   lastname: widget.lastName,
      //   email: widget.email,
      //   phoneNumber: widget.phone,
      //   locationJson: widget.isAddressChanged
      //       ?
      //           {
      //             "id": widget.userid,
      //             "streetAddress": widget.street,
      //             "area": widget.area,
      //             "city": widget.city,
      //             "state": widget.states,
      //             "zipCode": widget.zip,
      //             "latitude": 0,
      //             "longitude": 0
      //           }

      //       : widget.profile.locations,
      // );
                               var storage = GetStorage();

                                      var useerid = storage.read('userid');
      final updatedProfile = widget.profile.copyWith(
        firstname: widget.firstName,
        lastname: widget.lastName,
        email: widget.email,
        phoneNumber: widget.phone,
        locationJson: widget.isAddressChanged
            ? jsonEncode([
                {
                  "id": useerid,
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

//10@Testing
      context.read<LoginBloc>().add(UpdateIndividualProfile(
            userId: useerid,
            profile: updatedProfile,
            profileImage: _selectedImage,
          ));
    }
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
                        widget.profile.groupAssociations.isNotEmpty
                            ? BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                                  final groups =
                                      state.profile?.groupAssociations ?? [];

                                  return Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      children: List.generate(
                                        groups.length,
                                        (index) => ListTile(
                                          trailing: InkWell(
                                            onTap: () {
                                              print("USER ID ${widget.userid}");
                                              print(
                                                  "GROUP ID ${groups[index]['groupId']}");
                                              var storage = GetStorage();

                                              var useerid =
                                                  storage.read('userid');
                                              context.read<LoginBloc>().add(
                                                    RemoveAffiliations(
                                                      userId: useerid,
                                                      groupId: groups[index]
                                                          ['groupId'],
                                                    ),
                                                  ); //10@Testing
                                            },
                                            child: Image.asset(
                                                "assets/icon_delete.png"),
                                          ),
                                          title: Text(
                                            groups[index]['groupName'],
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Satoshi',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )

                            /*Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  children: List.generate(
                                    widget.profile.groupAssociations.length,
                                    (index) => ListTile(
                                      trailing: InkWell(
                                          onTap: () {
                                            context.read<LoginBloc>().add(
                                                //10@Testing
                                                RemoveAffiliations(
                                                    userId: widget.userid,
                                                    groupId: widget.profile
                                                            .groupAssociations[
                                                        index]['groupId']));
                                          },
                                          child: Image.asset(
                                              "assets/icon_delete.png")),
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
                              )*/
                            : Padding(
                                padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.42,
                                    top: 5),
                                child: Text(
                                  'No Groups Found',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Satoshi',
                                  ),
                                ),
                              ),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            final allGroups =
                                state.getAllAssociatedGroupModel ?? [];

                            // 10@Testing Extract already associated group IDs
                            final associatedGroupIds = state
                                .profile!.groupAssociations
                                .map((group) => group['groupId'] ?? group['id'])
                                .whereType<String>()
                                .toSet();

                            // 🔽 Filter only unassociated groups
                            final availableGroups = allGroups
                                .where((group) =>
                                    !associatedGroupIds.contains(group.id))
                                .toList();

                            // ⛔ Hide dropdown if no available groups
                            if (availableGroups.isEmpty) {
                              return SizedBox.shrink();
                            }

                            // ✅ Validate dropdown value
                            final isValidValue =
                                availableGroups.contains(_dropdownValue);
                            final currentValue =
                                isValidValue ? _dropdownValue : null;

                            return Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.53),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.83,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                        canvasColor: Colors.white,
                                        dropdownMenuTheme:
                                            DropdownMenuThemeData()),
                                    child: DropdownButtonFormField<
                                        GetAllAssociatedGroupModel>(
                                      elevation: 0,
                                      value: currentValue,
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
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                        ),
                                      ),
                                      items: availableGroups.map((group) {
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
                                        var storage = GetStorage();

                                        var useerid = storage.read('userid');
                                        print("USER ID $useerid");
                                        if (group != null &&
                                            !selectedGroups
                                                .any((g) => g.id == group.id)) {
                                          context.read<LoginBloc>().add(
                                                AddAffiliations(
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
                                ),
                              ],
                            );
                          },
                        ),

                        /*    BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            final allGroups =
                                state.getAllAssociatedGroupModel ?? [];

                            // 🔍 Extract already associated group IDs (adjust 'groupId' if needed)
                            final associatedGroupIds = state
                                .profile!.groupAssociations
                                .map((group) => group['groupId'] ?? group['id'])
                                .whereType<String>()
                                .toSet();

                            // 🔽 Filter only unassociated groups
                            final availableGroups = allGroups
                                .where((group) =>
                                    !associatedGroupIds.contains(group.id))
                                .toList();

                            // ✅ Validate dropdown value
                            final isValidValue =
                                availableGroups.contains(_dropdownValue);
                       
                            final currentValue =
                                isValidValue ? _dropdownValue : null;
                         
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.83,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  canvasColor: Colors.white,
                                  dropdownMenuTheme: DropdownMenuThemeData(
                                      ),
                                ),
                                child: DropdownButtonFormField<
                                    GetAllAssociatedGroupModel>(
                                  elevation: 0,
                                  value: currentValue,
                                  decoration: InputDecoration(
                                    hintText: "Select group",
                                    hintStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Satoshi',
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  items: availableGroups.map((group) {
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
                                        !selectedGroups
                                            .any((g) => g.id == group.id)) {
                                      print("Selected group: ${group.name}");
                              
                              
                                      context.read<LoginBloc>().add(
                                            AddAffiliations(
                                              userId: widget.userid,
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
                        ),*/

                        /*  BlocBuilder<LoginBloc, LoginState>(
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
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
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
                                      print("GROUP NAME ${group.name}");
                                      print("GROUP NAME ${group.name}");
                                      context.read<LoginBloc>().add(
                                          AddAffiliations(
                                              userId: widget.userid,
                                              groupId: group.id));

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
                        ),*/
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
