import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';

import '../../widgets/boxDecorationWidget.dart';
import '../login/bloc/login_bloc.dart';
import '../login/bloc/login_event.dart';
import '../login/bloc/login_state.dart';
import '../notification_screen.dart';
import 'edit_individual_profile_screen.dart';

class IndividualProfileScreen extends StatefulWidget {
  const IndividualProfileScreen({Key? key}) : super(key: key);

  @override
  State<IndividualProfileScreen> createState() => _IndividualProfileScreenState();
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
    final Color backgroundColor = Color(0xFFF6F7FF);
    final Color lightBlue = Color(0xFF8A97FF);
    final Color iconBgColor = Color(0xFFD7E0FF);

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state.status == LoginStatus.profileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == LoginStatus.profileLoaded &&
            state.profile != null) {
          final profile = state.profile!;
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
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 38,
                          backgroundImage: NetworkImage(
                            'https://randomuser.me/api/portraits/women/65.jpg',
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
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                profile.role,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditIndividualProfileScreen()));
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Details card
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
                        _detailRow(label: 'DM:', value: '@${profile.userName}'),
                        _detailRow(label: 'Email:', value: profile.email),
                        _detailRow(label: 'Phone:', value: profile.phoneNumber),
                        _detailRow(
                          label: 'Location:',
                          value: 'No Address Provided',
                          isMultiline: true,
                        ),
                        _detailRow(label: 'Zip Code:', value: 'N/A'),
                      ],
                    ),
                  ),

                  SizedBox(height: 28),

                  //   profile.groupAssociations.length !=

                  Text(
                    'Groups/Association',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
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

                  // _groupCard(
                  //   context: context,
                  //   title: 'National Association of General Practitioners',
                  //   memberCount: 22,
                  // ),
                  // SizedBox(height: 12),
                  // _groupCard(
                  //   context: context,
                  //   title: 'Diabetes Management Support Group',
                  //   memberCount: 22,
                  // ),
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
      height: screenWidth * 0.35,
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
                height: screenWidth * 0.12,
                width: screenWidth * 0.12,
                decoration: BoxDecoration(
                  color: Color(0xffDBE4FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: Image.asset(
                    "assets/users-02.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: screenWidth * 0.05,
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
                  fontSize: screenWidth * 0.03,
                  color: Colors.grey.shade600,
                ),
              ),
              Spacer(),
              Icon(
                Icons.open_in_new,
                color: Colors.grey.shade400,
                size: screenWidth * 0.05,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final Color primaryBlue = Color(0xFF5D6EFF);
//     final Color backgroundColor = Color(0xFFF6F7FF);
//     final Color lightBlue = Color(0xFF8A97FF);
//     final Color iconBgColor = Color(0xFFD7E0FF);

//     return CustomScaffoldWidget(
//       isDrawerRequired: true,
//       appbartitle: 'Profile',
//       body: DecoratedBox(
//         decoration: boxDecoration(),
//         child: ListView(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [primaryBlue, lightBlue],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: primaryBlue.withOpacity(0.3),
//                     blurRadius: 12,
//                     offset: Offset(0, 6),
//                   )
//                 ],
//               ),
//               padding: EdgeInsets.all(20),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 38,
//                     backgroundImage: NetworkImage(
//                         'https://randomuser.me/api/portraits/women/65.jpg'),
//                   ),
//                   SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Lisa Joseph',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 18,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           'Patient',
//                           style: TextStyle(
//                             color: Colors.white70,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.3),
//                       shape: BoxShape.circle,
//                     ),
//                     child: IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.edit,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: 20),

//             // Details card
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.black12.withOpacity(0.05),
//                       blurRadius: 6,
//                       offset: Offset(0, 3))
//                 ],
//               ),
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _detailRow(label: 'DM:', value: '@JohnCarlos54'),
//                   _detailRow(label: 'Email:', value: 'JohnCarlos54@gmail.com'),
//                   _detailRow(label: 'Phone:', value: '+0594 56249 5894'),
//                   _detailRow(
//                     label: 'Location:',
//                     value:
//                         '221B Baker Street, NW1, London, Greater London, NW1 6XE',
//                     isMultiline: true,
//                   ),
//                   _detailRow(label: 'Zip Code:', value: 'NW1 6XE'),
//                 ],
//               ),
//             ),

//             SizedBox(height: 28),

//             Text(
//               'Groups/Association',
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 16,
//                 color: Colors.black87,
//                 fontFamily: 'Satoshi',
//               ),
//             ),
//             SizedBox(height: 16),

//             _groupCard(
//               context: context,
//               title: 'National Association of General Practitioners',
//               memberCount: 22,
//             ),
//             SizedBox(height: 12),
//             _groupCard(
//               context: context,
//               title: 'Diabetes Management Support Group',
//               memberCount: 22,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _detailRow(
//       {required String label,
//       required String value,
//       bool isMultiline = false}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: RichText(
//         text: TextSpan(
//           text: '$label ',
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             color: Colors.black87,
//             fontSize: 14,
//           ),
//           children: [
//             TextSpan(
//               text: value,
//               style: TextStyle(
//                 fontWeight: FontWeight.w400,
//                 color: Colors.grey.shade700,
//                 fontSize: 14,
//               ),
//             ),
//           ],
//         ),
//         maxLines: isMultiline ? null : 1,
//         overflow: isMultiline ? TextOverflow.visible : TextOverflow.ellipsis,
//       ),
//     );
//   }

//   Widget _groupCard({
//     required BuildContext context,
//     required String title,
//     required int memberCount,
//   }) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Container(
//       height: screenWidth * 0.35, // ~137 on 390px width
//       width: screenWidth * 0.92, // ~376 on 410px width
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12.withOpacity(0.05),
//             blurRadius: 6,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       padding: EdgeInsets.symmetric(
//         horizontal: screenWidth * 0.05, // ~20
//         vertical: screenWidth * 0.045, // ~18
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Container(
//                 height: screenWidth * 0.12, // ~48
//                 width: screenWidth * 0.12,
//                 decoration: BoxDecoration(
//                   color: Color(0xffDBE4FF),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(screenWidth * 0.03),
//                   child: Image.asset(
//                     "assets/users-02.png",
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//               SizedBox(width: screenWidth * 0.04), // ~16
//               Expanded(
//                 child: Text(
//                   title,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                     fontSize: screenWidth * 0.05, // ~20
//                     color: Colors.black87,
//                     fontFamily: 'Satoshi',
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: screenWidth * 0.01),
//           Row(
//             children: [
//               Image.asset(
//                 "assets/framegroup.png",
//                 height: screenWidth * 0.1, // ~40
//                 width: screenWidth * 0.15, // ~60
//                 fit: BoxFit.contain,
//               ),
//               SizedBox(width: screenWidth * 0.02), // ~8
//               Text(
//                 '$memberCount other doctors',
//                 style: TextStyle(
//                   fontSize: screenWidth * 0.03, // ~12
//                   color: Colors.grey.shade600,
//                 ),
//               ),
//               Spacer(),
//               Icon(
//                 Icons.open_in_new,
//                 color: Colors.grey.shade400,
//                 size: screenWidth * 0.05, // ~20
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
