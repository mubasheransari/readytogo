import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readytogo/Model/professional_profile_model.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';

import '../../widgets/boxDecorationWidget.dart';
import '../login/bloc/login_bloc.dart';
import '../login/bloc/login_event.dart';
import '../login/bloc/login_state.dart';
import 'edit_professional_profile_screen.dart';

class ProfessionalProfileScreen extends StatefulWidget {
  const ProfessionalProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfessionalProfileScreen> createState() =>
      _ProfessionalProfileScreenState();
}

class _ProfessionalProfileScreenState extends State<ProfessionalProfileScreen> {
  @override
  void initState() {
    super.initState();
    final userId = GetStorage().read("id");
    if (userId != null) {
      context.read<LoginBloc>().add(GetProfessionalProfile(userId: userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = Color(0xFF5D6EFF);
    final Color backgroundColor = Color(0xFFF6F7FF);
    final Color lightBlue = Color(0xFF8A97FF);
    final Color iconBgColor = Color(0xFFD7E0FF);

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state.professionalStatus == ProfessionalStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.professionalStatus == ProfessionalStatus.success &&
            state.professionalProfileModel != null) {
          final profile = state.professionalProfileModel!;
          return CustomScaffoldWidget(
            isDrawerRequired: true,
            appbartitle: 'Profile',
            body: DecoratedBox(
              decoration: boxDecoration(),
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
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 35,
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
                                    'Dr. ${profile.firstname} ${profile.lastname}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24,
                                        fontFamily: 'satoshi'),
                                  ),
                                  // Row(
                                  //   children: (profile.specializations ?? [])
                                  //       .map<Widget>((e) => Text(e))
                                  //       .toList(),
                                  // ),

                                  //    profile.specializations?.map((e) => Text(e)).toList() ?? [],

                                  //  profile.specializations.map((e) => Text(e.name)).toList(),
                                  Text(
                                    profile.specializationNames.isNotEmpty
                                        ? profile.specializationNames
                                            .first // "Periodontics"
                                        : '—',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      fontFamily: 'satoshi',
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfessionalProfileScreen(
                                                      profile: profile)));
                                    },
                                    icon: Image.asset(
                                      "assets/icon_edit.png",
                                      color: Colors.black,
                                    ))),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Organization Name:\n',
                                style: TextStyle(
                                  fontFamily: 'satoshi',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                                children: [
                                  TextSpan(
                                    text: profile.organizationName ?? '',
                                    style: TextStyle(
                                      fontFamily: 'satoshi',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Date:',
                                  style: TextStyle(
                                    fontFamily: 'satoshi',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  profile.organizationJoiningDate != null
                                      ? profile.organizationJoiningDate!
                                          .toIso8601String()
                                          .split('T')[0]
                                      : 'N/A',
                                  style: TextStyle(
                                    fontFamily: 'satoshi',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _badgeBox("assets/shield-tick.png", "Verified"),
                      SizedBox(
                        width: 3,
                      ),
                      _badgeBox("assets/book-open-01.png", "Contributor"),
                      SizedBox(
                        width: 3,
                      ),
                      _badgeBox("assets/life-buoy-02.png", "Lifeguard"),
                    ],
                  ),
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
                        _buildInfoRow('DM:', '@${profile.userName ?? ''}'),
                        SizedBox(height: 10),
                        _buildInfoRow('Email:', profile.email ?? ''),
                        SizedBox(height: 10),
                        _buildInfoRow('Phone:', profile.phoneNumber ?? ''),
                        SizedBox(height: 10),
                        _buildInfoRow(
                          'Location:',
                          (profile.locations != null &&
                                  profile.locations!.isNotEmpty)
                              ? '${profile.locations![0].streetAddress ?? ""}, ${profile.locations![0].area ?? ""}, ${profile.locations![0].city ?? ""}, ${profile.locations![0].state ?? ""}.'
                              : 'No Address Provided',
                        ),
                        SizedBox(height: 10),
                        _buildInfoRow(
                          'Zip Code:',
                          (profile.locations != null &&
                                  profile.locations!.isNotEmpty)
                              ? '${profile.locations![0].zipCode ?? ""}'
                              : 'No Address Provided',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
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
                        Text(
                          "Description",
                          style: TextStyle(
                              fontFamily: 'satoshi',
                              fontSize: 17,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          profile.description ?? '',
                          style: TextStyle(
                              fontFamily: 'satoshi',
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 28),
                  Text(
                    'Groups/Association',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                  SizedBox(height: 16),
                  ...(profile.groupAssociations ?? []).map<Widget>((group) {
                    return Column(
                      children: [
                        _groupCard(
                          context: context,
                          title: group.groupName ?? '',
                          memberCount: group.memberCount ?? 0,
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

  Widget _badgeBox(String imagePath, String label) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.28,
      height: 88,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 15),
            Image.asset(imagePath, width: 32, height: 32),
            Text(
              label,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'satoshi'),
            )
          ],
        ),
      ),
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
                    width: 24,
                    height: 20,
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
                    fontSize: 20,
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
                  fontSize: 15,
                  color: Colors.grey.shade900,
                  fontFamily: 'satoshi',
                ),
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
