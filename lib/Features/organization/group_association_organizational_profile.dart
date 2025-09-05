import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readytogo/Model/organization_profile_model.dart';
import '../../Constants/constants.dart';
import '../../Model/get_all_associated_groups_model.dart';
import '../../Model/get_all_individual_profile_model.dart';
import '../../Repositories/login_repository.dart';
import '../login/bloc/login_bloc.dart';
import '../login/bloc/login_event.dart';
import '../login/bloc/login_state.dart';

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

      // ✅ Create updated profile with UI values
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

      /*  try {
        final response = await LoginRepository().updateOrganizationalProfile(
          id: userId,
          profile: updatedProfile,
          profileImage: _selectedImage, // can be null
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Profile Updated Successfully",
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Update failed: ${response.body}"),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $e"),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() => _submitted = false);
      }*/
    }
  }

  /* void _submit() {
    if (_formKey.currentState!.validate()) {
      var storage = GetStorage();

      var useerid = storage.read('userid');
      final updatedProfile = widget.profile.copyWith(
        firstname: widget.firstName,
        lastname: widget.lastName,
        email: widget.email,
        phoneNumber: widget.phone,
        description: widget.description,
        locationJson: jsonEncode(widget.profile.locations)

      );
      if (_selectedImage != null) {
        print("Null nhi hai");
      } else {
        print("Null hai");
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    GetAllAssociatedGroupModel? _dropdownValue;
    final List<GetAllAssociatedGroupModel> selectedGroups = [];
    // final List<GetAllProfessionalProfileModel> selectedGroups = [];
    // GetAllProfessionalProfileModel? _dropdownValue;
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
            print("UPDATE FAILED ${state.errorMessage}");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? "Update failed"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        //   listener: (context, state) {

        /*      if (state.updateProfessionalProfileStatus ==
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
          }*/
        //},
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
                        BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state.removeAffiliationGroupStatus ==
                                RemoveAffiliationGroupStatusProfessional
                                    .success) {
                              final storage = GetStorage();
                              final id = storage.read("id");

                              context
                                  .read<LoginBloc>()
                                  .add(GetOrganizationProfile(userId: id));

                              Navigator.of(context).pop();
                              // Navigator.of(context).pop();
                            }

                            if (state.removeAffiliationGroupStatus ==
                                RemoveAffiliationGroupStatusProfessional
                                    .failure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(state.errorMessage ??
                                        "Failed to remove group")),
                              );
                            }
                          },
                          builder: (context, state) {
                            return Padding(
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
                                        var useerid = storage.read('userid');

                                        context.read<LoginBloc>().add(
                                              RemoveAffiliationsOrganization(
                                                userId: useerid,
                                                groupId: widget
                                                    .profile
                                                    .groupAssociations![index]
                                                    .groupId
                                                    .toString(),
                                              ),
                                            );
                                      },
                                      child:
                                          Image.asset("assets/icon_delete.png"),
                                    ),
                                    title: Text(
                                      widget.profile.groupAssociations![index]
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
                        SizedBox(
                          height: 15,
                        ),
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
                                  padding: EdgeInsets.only(left: 8.0),
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
                                      final id = storage.read("id");

                                      context.read<LoginBloc>().add(
                                          GetOrganizationProfile(userId: id));

                                      Navigator.of(context).pop();
                                      //  Navigator.of(context).pop();
                                    }

                                    if (state.status ==
                                        LoginStatus
                                            .addAffilicationGroupsError) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(state.errorMessage ??
                                                "Something went wrong")),
                                      );
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

                                /*    SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.83,
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
                                            !selectedGroups
                                                .any((g) => g.id == group.id)) {
                                          final storage = GetStorage();
                                          final userId = storage.read('userid');

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

                                          var id = storage.read("id");


                                          context.read<LoginBloc>().add(
                                              GetOrganizationProfile(
                                                  userId: id));
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        }
                                      },
                                    ),
                                  ),
                                ),*/
                              ],
                            );
                          },
                        ),
                        /* BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            final allGroups =
                                state.getAllAssociatedGroupModel ?? [];

                            final List<GetAllAssociatedGroupModel>
                                selectedGroups = [];
                            GetAllAssociatedGroupModel? _dropdownValue;

                            // ✅ Handle null profile or groupAssociations
                            final associatedGroupIds = (state
                                        .profile?.groupAssociations ??
                                    [])
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
                              return const SizedBox.shrink();
                            }

                            // ✅ Validate dropdown value
                            final isValidValue =
                                availableGroups.contains(_dropdownValue);
                            final currentValue =
                                isValidValue ? _dropdownValue : null;

                            return Column(
                              children: [
                                const SizedBox(height: 15),
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.53,
                                  ),
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
                                        var storage = GetStorage();
                                        var userId = storage.read('userid');

                                        if (group != null &&
                                            !selectedGroups
                                                .any((g) => g.id == group.id)) {
                                          context.read<LoginBloc>().add(
                                                AddAffiliations(
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
                                ),
                              ],
                            );
                          },
                        ),*/

                        /*    BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            final allGroups =
                                state.getAllAssociatedGroupModel ?? [];

                            final List<GetAllAssociatedGroupModel>
                                selectedGroups = [];
                            GetAllAssociatedGroupModel? _dropdownValue;

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
                        ),*/
                        /*  Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              final allGroups =
                                  state.getAllProfessionalProfileModel ?? [];
                              final joinedGroupIds = widget
                                  .profile.groupAssociations!
                                  .map((g) => g.groupId)
                                  .toSet();

                              final filteredGroups = allGroups
                                  .where((g) => !joinedGroupIds.contains(g.id))
                                  .toList();
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
                                    items: filteredGroups.map((group) {
                                      return DropdownMenuItem<
                                          GetAllProfessionalProfileModel>(
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
