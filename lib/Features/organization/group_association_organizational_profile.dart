import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readytogo/Model/organization_profile_model.dart';
import '../../Constants/constants.dart';
import '../../Model/get_all_associated_groups_model.dart';
import '../login/bloc/login_bloc.dart';
import '../login/bloc/login_event.dart';
import '../login/bloc/login_state.dart';
import 'organization_profile_screen.dart';

class GroupAssociationEditOrganizationalProfile extends StatefulWidget {
  final OrganizationProfileModel profile;
  final File? selectedImageFile;
  final String? imageUrl;
  final String userid, firstName, lastName, phone, description, wesite, email;

  const GroupAssociationEditOrganizationalProfile({
    super.key,
    required this.profile,
    this.selectedImageFile,
    this.imageUrl,
    required this.description,
    required this.wesite,
    required this.userid,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
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

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _submitted = true);

      var storage = GetStorage();
      var userId = storage.read('userid') ?? "";

      final updatedProfile = widget.profile.copyWith(
        firstname: widget.firstName,
        lastname: widget.lastName,
        email: widget.email,
        phoneNumber: widget.phone,
        description: widget.description,
        website: widget.wesite,
        locationJson: jsonEncode(widget.profile.locations),
      );

      context.read<LoginBloc>().add(UpdateOrganizationalProfile(
            userId: userId,
            organizationProfileModel: updatedProfile,
            profileImage: _selectedImage,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    GetAllAssociatedGroupModel? _dropdownValue;
    final List<GetAllAssociatedGroupModel> selectedGroups = [];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.updateOrganizationalProfileEnum ==
              UpdateOrganizationalProfileEnum.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Profile updated successfully",
                    style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
            Navigator.of(context).pop();
          } else if (state.updateOrganizationalProfileEnum ==
              UpdateOrganizationalProfileEnum.failure) {
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
                        widget.profile.groupAssociations.length != 0
                            ? Padding(
                                padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.37),
                                child: const Text(
                                  'Group/Association',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Satoshi',
                                  ),
                                ),
                              )
                            : SizedBox(),
                        BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state.removeAffiliationGroupStatus ==
                                RemoveAffiliationGroupStatusProfessional
                                    .success) {
                              final storage = GetStorage();
                              final id = storage.read("userid");

                              context
                                  .read<LoginBloc>()
                                  .add(GetOrganizationProfile(userId: id));
                            }

                            if (state.organizationalStatus ==
                                OrganizationalStatus.success) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          OrganizationProfileScreen()),
                                );
                              });

                              // final storage = GetStorage();
                              // final id = storage.read("userid");

                              // context
                              //     .read<LoginBloc>()
                              //     .add(GetOrganizationProfile(userId: id));

                              // Navigator.of(context).pop();
                              // Navigator.of(context).pop();
                              //      toastWidget('Group Removed', Colors.red);
                            }

                            if (state.removeAffiliationGroupStatus ==
                                RemoveAffiliationGroupStatusProfessional
                                    .failure) {
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(
                              //       content: Text(state.errorMessage ??
                              //           "Failed to remove group")),
                              // );
                            }
                          },
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                children: List.generate(
                                  widget.profile.groupAssociations.length,
                                  (index) => ListTile(
                                    trailing: InkWell(
                                      onTap: () {
                                        var storage = GetStorage();
                                        var useerid = storage.read('userid');

                                        context.read<LoginBloc>().add(
                                              RemoveAffiliationsOrganization(
                                                userId: useerid,
                                                groupId: widget
                                                    .profile
                                                    .groupAssociations[index]
                                                    .groupId
                                                    .toString(),
                                              ),
                                            );
                                      },
                                      child:
                                          Image.asset("assets/icon_delete.png"),
                                    ),
                                    title: Text(
                                      widget.profile.groupAssociations[index]
                                          .groupName!,
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
                        ),

                        /*  Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            children: List.generate(
                              widget.profile.groupAssociations!.length,
                              (index) => ListTile(
                                trailing: InkWell(
                                    onTap: () {
                                      print("USER ID ${widget.userid}");
                                      print(
                                          "GROUP ID ${widget.profile.groupAssociations![index].groupId}");
                                      var storage = GetStorage();

                                      var id = storage.read("id");

                                      var useerid = storage.read('userid');
                                      context.read<LoginBloc>().add(
                                            RemoveAffiliationsOrganization(
                                              userId: useerid,
                                              groupId: widget
                                                  .profile
                                                  .groupAssociations[index]
                                                  .groupId
                                                  .toString(),
                                            ),
                                          );

                                      context.read<LoginBloc>().add(
                                          GetOrganizationProfile(userId: id));
                                   //   Navigator.of(context).pop();
                                 //     Navigator.of(context).pop();
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
                        ),*/
                        widget.profile.groupAssociations.length != 0
                            ? SizedBox(
                                height: 15,
                              )
                            : SizedBox(),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            final allGroups =
                                state.getAllAssociatedGroupModel ?? [];

                            final associatedGroupIds =
                                (widget.profile.groupAssociations)
                                    .map((group) => group.groupId)
                                    .whereType<String>()
                                    .toSet();

                            final availableGroups = allGroups
                                .where((group) =>
                                    !associatedGroupIds.contains(group.id))
                                .toList();

                            if (availableGroups.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            final isValidValue =
                                availableGroups.contains(_dropdownValue);
                            final currentValue =
                                isValidValue ? _dropdownValue : null;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                const Padding(
                                  padding: EdgeInsets.only(left: 0.0),
                                  child: Text(
                                    'Select Group',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Satoshi',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                BlocConsumer<LoginBloc, LoginState>(
                                  listener: (context, state) {
                                    if (state.status ==
                                        LoginStatus
                                            .addAffilicationGroupsSuccess) {
                                      final storage = GetStorage();
                                      final id = storage.read("userid");

                                      context.read<LoginBloc>().add(
                                          GetOrganizationProfile(userId: id));
                                    }

                                    if (state.organizationalStatus ==
                                        OrganizationalStatus.success) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  OrganizationProfileScreen()),
                                        );
                                      });
                                    }

                                    if (state.status ==
                                        LoginStatus
                                            .addAffilicationGroupsError) {
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(
                                      //   SnackBar(
                                      //       content: Text(state.errorMessage ??
                                      //           "Something went wrong")),
                                      // );
                                    }
                                  },
                                  builder: (context, state) {
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.83,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          canvasColor: Colors.white,
                                          dropdownMenuTheme:
                                              const DropdownMenuThemeData(),
                                        ),
                                        child: DropdownButtonFormField<
                                            GetAllAssociatedGroupModel>(
                                          elevation: 0,
                                          value: currentValue,
                                          decoration: InputDecoration(
                                            hintText: "Select group",
                                            hintStyle: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Satoshi',
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 12,
                                            ),
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
                                                style: const TextStyle(
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
                                                !selectedGroups.any(
                                                    (g) => g.id == group.id)) {
                                              final storage = GetStorage();
                                              final userId =
                                                  storage.read('userid');

                                              context.read<LoginBloc>().add(
                                                    AddAffiliationsOrganization(
                                                      userId: userId,
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
                              ],
                            );
                          },
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
