import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';
import '../login/bloc/login_bloc.dart';
import '../login/bloc/login_event.dart';
import '../login/bloc/login_state.dart';
import 'edit_individual_profile_screen.dart';
import 'package:readytogo/Features/login/bloc/login_bloc.dart';
import 'package:readytogo/Model/individual_profile_model.dart';

class IndividualProfileScreen extends StatefulWidget {
  const IndividualProfileScreen({Key? key}) : super(key: key);

  @override
  State<IndividualProfileScreen> createState() =>
      _IndividualProfileScreenState();
}

class _IndividualProfileScreenState extends State<IndividualProfileScreen> {
  @override
  void initState() {
    super.initState();
    final userId = GetStorage().read("id");
    if (userId != null) {
      context.read<LoginBloc>().add(GetIndividualProfile(userId: userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = Color(0xFF5D6EFF);
    final Color lightBlue = Color(0xFF8A97FF);

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.updateProfileError &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      builder: (context, state) {
        if (state.status == LoginStatus.profileLoading ||
            state.status == LoginStatus.updateProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == LoginStatus.profileLoaded &&
            state.profile != null) {
          final profile = state.profile!;
          return CustomScaffoldWidget(
            isDrawerRequired: true,
            appbartitle: 'Profile',
            body: DecoratedBox(
              decoration: BoxDecoration(color: Color(0xFFF6F7FF)),
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryBlue, lightBlue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: primaryBlue.withOpacity(0.3),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 38,
                          backgroundImage: NetworkImage(
                            'http://173.249.27.4:343/${profile.profileImageUrl}',
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${profile.firstname} ${profile.lastname}',
                                style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24,
                                        fontFamily: 'satoshi'),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "(${profile.role})",
                                style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        fontFamily: 'satoshi'),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () async {
                              final shouldRefresh = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditIndividualProfileScreen(
                                          profile: profile),
                                ),
                              );
                              if (shouldRefresh == true) {
                                final userId = GetStorage().read("id");
                                if (userId != null) {
                                  context.read<LoginBloc>().add(
                                      GetIndividualProfile(userId: userId));
                                }
                              }
                            },
                            icon: Icon(Icons.edit, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  //_buildDetailsCard(profile),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow('DM:', '@${profile.userName}'),
                        SizedBox(height: 10),
                        _buildInfoRow('Email:', profile.email),
                        SizedBox(height: 10),
                        _buildInfoRow('Phone:', profile.phoneNumber),
                        SizedBox(height: 10),
                        _buildInfoRow(
                          'Location:',
                          profile.locations.isNotEmpty
                              ? '${profile.locations[0]["streetAddress"] ?? ""}, ${profile.locations[0]["area"] ?? ""}, ${profile.locations[0]["city"] ?? ""}, ${profile.locations[0]["state"] ?? ""}.'
                              : 'No Address Provided',
                        ),
                        SizedBox(height: 10),
                        _buildInfoRow(
                          'Zip Code:',
                          profile.locations.isNotEmpty
                              ? '${profile.locations[0]["zipCode"] ?? ""}'
                              : 'No Address Provided',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 28),
                  Text(
                    'Groups/Association',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                      color: Colors.black87,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                  SizedBox(height: 16),
                  ...profile.groupAssociations.map<Widget>((group) {
                    return Column(
                      children: [
                        _groupCard(
                          context: context,
                          title: group['groupName'],
                          memberCount: group['memberCount'],
                        ),
                        SizedBox(height: 12),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        } else if (state.status == LoginStatus.profileError) {
          return Center(
            child: Text('Error: ${state.errorMessage ?? "Unknown error"}'),
          );
        } else {
          return Center(child: Text('No profile data available.'));
        }
      },
    );
  }

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

  Widget _buildDetailsCard(IndividualProfileModel profile) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 6,
              offset: Offset(0, 3))
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _detailRow(label: 'DM:', value: '@${profile.userName}'),
          _detailRow(label: 'Email:', value: profile.email),
          _detailRow(label: 'Phone:', value: profile.phoneNumber),
          _detailRow(
            label: 'Location:',
            value: profile.locations.isNotEmpty
                ? '${profile.locations[0]["streetAddress"] ?? ""}, ${profile.locations[0]["city"] ?? ""}'
                : 'No Address Provided',
            isMultiline: true,
          ),
          _detailRow(
            label: 'Zip Code:',
            value: profile.locations.isNotEmpty
                ? profile.locations[0]["zipCode"] ?? "N/A"
                : "N/A",
          ),
        ],
      ),
    );
  }

  Widget _detailRow({
    required String label,
    required String value,
    bool isMultiline = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: RichText(
        text: TextSpan(
          text: '$label ',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            fontSize: 14,
          ),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade700,
                fontSize: 14,
              ),
            ),
          ],
        ),
        maxLines: isMultiline ? null : 1,
        overflow: isMultiline ? TextOverflow.visible : TextOverflow.ellipsis,
      ),
    );
  }

  Widget _groupCard({
    required BuildContext context,
    required String title,
    required int memberCount,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenWidth * 0.30,
      width: screenWidth * 0.92,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenWidth * 0.045,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: screenWidth * 0.10,
                width: screenWidth * 0.10,
                decoration: BoxDecoration(
                  color: Color(0xffDBE4FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: Image.asset(
                    "assets/users-02.png",
                    width: 24, height: 20,
                    //  height: 48,width:48
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20, //screenWidth * 0.04,
                    color: Colors.black87,
                    fontFamily: 'Satoshi',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.01),
          Row(
            children: [
              Image.asset(
                "assets/framegroup.png",
                height: screenWidth * 0.1,
                width: screenWidth * 0.15,
                fit: BoxFit.contain,
              ),
              SizedBox(width: screenWidth * 0.02),
              Text(
                '$memberCount other doctors',
                style: TextStyle(
                    fontSize: 15, //screenWidth * 0.03,
                    color: Colors.grey.shade900,
                    fontFamily: 'satoshi'),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 30),
                child: Icon(
                  Icons.open_in_new,
                  color: Colors.grey.shade400,
                  size: screenWidth * 0.05,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
