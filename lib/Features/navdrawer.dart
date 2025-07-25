import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readytogo/Features/3MinuteAssisment/Step1Screen.dart';
import 'package:readytogo/Features/Donate/donate_navbar.dart';
import 'package:readytogo/Features/Subscription/subscription_screen.dart';
import 'package:readytogo/Features/howtouse_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readytogo/Features/login/bloc/login_bloc.dart';
import 'package:readytogo/widgets/toast_widget.dart';
import '../widgets/custom_alert_dialog.dart';
import 'Settings/settings_screen.dart';
import 'aboutus_screen.dart';
import 'login/login_screen.dart';
import 'manage_my_geo_navbar.dart';
import 'package:readytogo/Features/login/bloc/login_state.dart';

class CustomNavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 65.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.88,
        child: Drawer(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE7EFFE), Color(0xFFF8FAFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  // Main content - a column with all the items10@Testing
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocConsumer<LoginBloc, LoginState>(
                        listener: (context, state) {
                          // Add any side-effects if needed (e.g., navigation, SnackBars)
                        },
                        builder: (context, state) {
                          print("INDIVIDUAL ${state.status}");
                          print("PROFESSIONAL ${state.professionalStatus}");
                          print("ORGANIZATION ${state.organizationalStatus}");
                          final String imageUrl = state.status ==
                                  LoginStatus.profileLoaded //10@Testing
                              ? 'http://173.249.27.4:343/${state.profile!.profileImageUrl}'
                              : state.professionalStatus ==
                                      ProfessionalStatus.success
                                  ? 'http://173.249.27.4:343/${state.professionalProfileModel!.profileImageUrl}'
                                  : state.organizationalStatus ==
                                          OrganizationalStatus.success
                                      ? 'http://173.249.27.4:343/${state.organizationProfileModel!.profileImageUrl}'
                                      : 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=64&q=80';

                          final String userRole =
                              state.status == LoginStatus.profileLoaded
                                  ? 'Individual'
                                  : state.professionalStatus ==
                                          ProfessionalStatus.success
                                      ? 'Professional'
                                      : state.organizationalStatus ==
                                              OrganizationalStatus.success
                                          ? 'Organization'
                                          : 'Guest';

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 12),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 7),//10@Testing
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(imageUrl),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,//10@Testing
                                        children: [
                                          Text(
                                            state.status == LoginStatus.profileLoaded
                                                ? '${state.profile!.firstname} ${state.profile!.lastname}'
                                                : state.professionalStatus ==
                                                        ProfessionalStatus
                                                            .success
                                                    ? '${state.professionalProfileModel!.firstname} ${state.professionalProfileModel!.lastname}'
                                                    : state.organizationalStatus ==
                                                            OrganizationalStatus
                                                                .success
                                                        ? '${state.organizationProfileModel!.firstname} ${state.organizationProfileModel!.lastname}'
                                                        : 'Dr. John',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 24,
                                              color: Color(0xff323747),
                                              fontFamily: 'Satoshi',
                                            ),
                                          ),
                                          Text(
                                            userRole,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color: Color(0xff666F80),
                                              fontFamily: 'Satoshi',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          );
                        },
                      ),

                      /*   BlocBuilder<LoginBloc, LoginState>( 10@Testing
                          builder: (context, state) {
                        final String imageUrl = state
                                    .profile?.profileImageUrl !=
                                null
                            ? 'http://173.249.27.4:343/${state.profile!.profileImageUrl}'
                            : state.professionalProfileModel?.profileImageUrl !=
                                    null
                                ? 'http://173.249.27.4:343/${state.professionalProfileModel!.profileImageUrl}'
                                : state.organizationProfileModel
                                            ?.profileImageUrl !=
                                        null
                                    ? 'http://173.249.27.4:343/${state.organizationProfileModel!.profileImageUrl}'
                                    : 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=64&q=80';

                        final String userRole = state.profile != null
                            ? 'Individual'
                            : state.professionalProfileModel != null
                                ? 'Professional'
                                : state.organizationProfileModel != null
                                    ? 'Organization'
                                    : 'Guest';

                        return Padding(
                          // padding: const EdgeInsets.only(
                          //     left: 16, right: 16, top: 0, bottom: 18),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 7,
                                  ), //10@Testing

                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(imageUrl),
                                  ),
                                  /* state.profile != null
                                        ? CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                'http://173.249.27.4:343/${state.profile!.profileImageUrl}' //'https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=64&q=80'),
                                                )):
                                        state.professionalProfileModel != null? CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                'http://173.249.27.4:343/${state.professionalProfileModel!.profileImageUrl}' //'https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=64&q=80'),
                                                )): 
                                                state.organizationProfileModel != null?CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                'http://173.249.27.4:343/${state.organizationProfileModel!.profileImageUrl}' //'https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=64&q=80'),
                                                )):CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                'https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=64&q=80' //'https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=64&q=80'),
                                                )) ,*/

                                  // CircleAvatar(
                                  //   radius: 30,
                                  //   backgroundImage: NetworkImage(
                                  //     'http://173.249.27.4:343/${context.read<LoginBloc>().profile.profileImageUrl}'  //'https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=64&q=80'),
                                  // )),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.profile != null
                                              ? '${state.profile!.firstname} ${state.profile!.lastname}'
                                              : state.professionalProfileModel !=
                                                      null
                                                  ? '${state.professionalProfileModel!.firstname} ${state.professionalProfileModel!.lastname}'
                                                  : state.organizationProfileModel !=
                                                          null
                                                      ? '${state.organizationProfileModel!.firstname} ${state.organizationProfileModel!.lastname}'
                                                      : 'Dr. John',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 24,
                                            color: Color(0xff323747),
                                            fontFamily: 'Satoshi',
                                          ),
                                        ),

                                        // Text(
                                        //   'Dr. John',
                                        //   style: TextStyle(
                                        //     fontWeight: FontWeight.w600,
                                        //     fontSize: 24,
                                        //     color: Color(0xff323747),
                                        //     fontFamily: 'Satoshi',
                                        //   ),
                                        // ),

                                        Text(
                                          userRole,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: Color(0xff666F80),
                                            fontFamily: 'Satoshi',
                                          ),
                                        ),

                                        // SizedBox(height: 6),

                                        // Container(
                                        //   padding:
                                        //       EdgeInsets.symmetric(horizontal: 12),
                                        //   decoration: BoxDecoration(
                                        //     color: Colors.white,
                                        //     borderRadius: BorderRadius.circular(15),
                                        //     border: Border.all(
                                        //         color: Colors.grey.shade300),
                                        //   ),
                                        //   child: DropdownButtonHideUnderline(
                                        //     child: DropdownButton<String>(
                                        //       value: 'Professional',
                                        //       items: [
                                        //         'Professional',
                                        //         'Personal',
                                        //         'Other'
                                        //       ].map((String value) {
                                        //         return DropdownMenuItem<String>(
                                        //           value: value,
                                        //           child: Text(value,
                                        //               style: TextStyle(fontSize: 14)),
                                        //         );
                                        //       }).toList(),
                                        //       onChanged: (value) {
                                        //         // Handle dropdown change
                                        //       },
                                        //       iconSize: 20,
                                        //       icon: Icon(Icons.keyboard_arrow_down),
                                        //       style: TextStyle(color: Colors.black87),
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                            /*  Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width*0.9,
                                //  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top:8.0,left: 18),
                                  child: Text(userRole,
                                  style: TextStyle(
                                    fontFamily: 'satoshi',
                                    fontSize: 19
                                  ),),
                                ),
                              ),*/
                            ],
                          ),
                        );
                      }),*/
                      // Padding(
                      //   // padding: const EdgeInsets.only(
                      //   //     left: 16, right: 16, top: 0, bottom: 18),
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 5, vertical: 12),
                      //   child: Row(
                      //     children: [
                      //       SizedBox(
                      //         width: 7,
                      //       ),//10@Testing
                      //       BlocBuilder<LoginBloc, LoginState>(
                      //           builder: (context, state) {
                      //         return state.profile!= null ?
                      //          CircleAvatar(
                      //             radius: 30,
                      //             backgroundImage: NetworkImage(
                      //                 'http://173.249.27.4:343/${state.profile!.profileImageUrl}' //'https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=64&q=80'),
                      //                 )):CircleAvatar(
                      //             radius: 30,
                      //             backgroundImage: NetworkImage(
                      //                 'http://173.249.27.4:343/${state.professionalProfileModel!.profileImageUrl}' //'https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=64&q=80'),
                      //                 ));
                      //       }),
                      //       // CircleAvatar(
                      //       //   radius: 30,
                      //       //   backgroundImage: NetworkImage(
                      //       //     'http://173.249.27.4:343/${context.read<LoginBloc>().profile.profileImageUrl}'  //'https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=64&q=80'),
                      //       // )),
                      //       SizedBox(width: 12),
                      //       Expanded(
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //               'Dr. John',
                      //               style: TextStyle(
                      //                 fontWeight: FontWeight.w600,
                      //                 fontSize: 24,
                      //                 color: Color(0xff323747),
                      //                 fontFamily: 'Satoshi',
                      //               ),
                      //             ),
                      //             Text(
                      //               'Psychiatrist, General Hospital',
                      //               style: TextStyle(
                      //                 fontWeight: FontWeight.w700,
                      //                 fontSize: 16,
                      //                 color: Color(0xff666F80),
                      //                 fontFamily: 'Satoshi',
                      //               ),
                      //             ),
                      //             // SizedBox(height: 6),

                      //             // Container(
                      //             //   padding:
                      //             //       EdgeInsets.symmetric(horizontal: 12),
                      //             //   decoration: BoxDecoration(
                      //             //     color: Colors.white,
                      //             //     borderRadius: BorderRadius.circular(15),
                      //             //     border: Border.all(
                      //             //         color: Colors.grey.shade300),
                      //             //   ),
                      //             //   child: DropdownButtonHideUnderline(
                      //             //     child: DropdownButton<String>(
                      //             //       value: 'Professional',
                      //             //       items: [
                      //             //         'Professional',
                      //             //         'Personal',
                      //             //         'Other'
                      //             //       ].map((String value) {
                      //             //         return DropdownMenuItem<String>(
                      //             //           value: value,
                      //             //           child: Text(value,
                      //             //               style: TextStyle(fontSize: 14)),
                      //             //         );
                      //             //       }).toList(),
                      //             //       onChanged: (value) {
                      //             //         // Handle dropdown change
                      //             //       },
                      //             //       iconSize: 20,
                      //             //       icon: Icon(Icons.keyboard_arrow_down),
                      //             //       style: TextStyle(color: Colors.black87),
                      //             //     ),
                      //             //   ),
                      //             // )
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      /* Container(
                        height: 40,
                        width: 296,
                        //  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton<String>(
                          value: '    Professional',
                          underline: SizedBox(),
                          dropdownColor: Colors.white,
                          icon: Padding(
                              padding: const EdgeInsets.only(left: 152.0),
                              child: Image.asset(
                                "assets/chevron-down.png",
                                height: 24,
                                width: 24,
                                color: Colors.black,
                              )),
                          items: <String>[
                            '    Professional',
                            '    Personal',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Satoshi',
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {},10@Testing
                        ),
                      ),*/
                      SizedBox(height: 6),

                      Divider(thickness: 1, height: 1),
                      // Menu Items
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            _buildMenuItem(
                                "assets/manageMyGeo.png", 'Manage My Geo',
                                onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ManageMyGeo()));
                            }),
                            _buildMenuItem(
                                "assets/phoneiconnavbar.png", 'Call 911/988'),
                            _buildMenuItem(
                                "assets/coins-hand.png", 'One Click Donate',
                                onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DonateScreenNavBar()));
                            }),
                            // _buildExpandableMenu(
                            //   context,
                            //   icon: Icons.menu_book_outlined,
                            //   title: 'Assessments', //Assessments.png
                            //   children: [
                            //     // Add sub menu items here if needed
                            //   ],
                            // ),
                            InkWell(
                              onTap: () {
                                var box = GetStorage();
                                var value = box.read("assessment");
                                if (value == "1") {
                                  toastWidget(
                                      "Assessment Completed", Colors.green);
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Step1Screen()));
                                }
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Step1Screen()));
                              },
                              child: _buildMenuItem(
                                "assets/assesment.png",
                                'Assessments',
                                //  selected: true
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SubscriptionScreen()));
                              },
                              child: _buildMenuItem(
                                "assets/credit-card-refresh.png",
                                'Subscriptions',
                                //  selected: true
                              ),
                            ),
                            _buildMenuItem("assets/lifesupportguard.png",
                                'Life Guard Support'),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SettingsScreen()));
                              },
                              child: _buildMenuItem(
                                  "assets/settings-02.png", 'Settings'),
                            ),
                            _buildMenuItem("assets/aboutus.png", 'About Us',
                                onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AboutUsScreen()));
                            }),
                            _buildMenuItem("assets/faqs.png", 'FAQs'),
                            _buildMenuItem("assets/howtouse.png", 'How to Use',
                                onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HowToUseScreen()));
                            }),
                            _buildMenuItem(
                                "assets/invite.png", 'Invite Others'),
                            Divider(),
                            ListTile(
                              leading: Image.asset("assets/logout.png"),
                              // Icon(Icons.logout, color: Colors.redAccent),
                              title: Text(
                                'Logout',
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                              onTap: () {
                                logoutDialog(context);

                                // final box = GetStorage();
                                // box.remove("token");
                                // box.remove("id");
                                // box.remove("role");
                                // toastWidget("Logout", Colors.red);
                                // Navigator.of(context).pushAndRemoveUntil(
                                //   MaterialPageRoute(
                                //       builder: (context) => LoginScreen()),
                                //   (Route<dynamic> route) => false,
                                // );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Positioned Close Icon at top right
                  /*  Positioned(
                    top: 0,
                    right: 8,
                    //  bottom: -10,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        size: 26,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    String icon,
    String title, {
    bool selected = false,
    VoidCallback? onTap,
  }) {
    return Container(
      color: selected ? Color(0xFFDDE8FF) : Colors.transparent,
      child: ListTile(
          leading: Image.asset(
              icon), //Icon(icon, color: Colors.grey[800], size: 22),
          title: Text(title,
              style: TextStyle(
                fontSize: 19,
                color: Color(0xff323747),
                fontWeight: FontWeight.w800,
                fontFamily: 'Satoshi',
              )),
          onTap: onTap),
    );
  }

  Widget _buildExpandableMenu(BuildContext context,
      {required IconData icon, required String title, List<Widget>? children}) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.grey[800], size: 22),
      title: Text(title, style: TextStyle(fontSize: 16, color: Colors.black87)),
      children: children ?? [],
      trailing: Icon(Icons.keyboard_arrow_down),
    );
  }
}





// import 'package:flutter/material.dart';

// class CustomNavDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 65.0),
//       child: SizedBox(
//         height: MediaQuery.of(context).size.height * 0.88,
//         child: Drawer(
//           child: Container(
//             // height: 499, //MediaQuery.of(context).size.height * 0.8,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFFE7EFFE), Color(0xFFF8FAFF)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: SafeArea(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Header with profile image, name, and dropdown
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10, vertical: 12),
//                     child: Row(
//                       children: [
//                         CircleAvatar(
//                           radius: 28,
//                           backgroundImage: NetworkImage(
//                               'https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=64&q=80'),
//                         ),
//                         SizedBox(width: 12),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Dr. John',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 18,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                               Text(
//                                 'Psychiatrist, General Hospital',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 14,
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                               SizedBox(height: 6),
//                               Container(
//                                 padding: EdgeInsets.symmetric(horizontal: 12),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(15),
//                                   border:
//                                       Border.all(color: Colors.grey.shade300),
//                                 ),
//                                 child: DropdownButtonHideUnderline(
//                                   child: DropdownButton<String>(
//                                     value: 'Professional',
//                                     items: ['Professional', 'Personal', 'Other']
//                                         .map((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value,
//                                             style: TextStyle(fontSize: 14)),
//                                       );
//                                     }).toList(),
//                                     onChanged: (value) {
//                                       // Handle dropdown change
//                                     },
//                                     iconSize: 20,
//                                     icon: Icon(Icons.keyboard_arrow_down),
//                                     style: TextStyle(color: Colors.black87),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () => Navigator.pop(context),
//                           child: Icon(
//                             Icons.close,
//                             size: 26,
//                             color: Colors.grey[700],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Divider(thickness: 1, height: 1),
//                   // Menu Items
//                   Expanded(
//                     child: ListView(
//                       padding: EdgeInsets.zero,
//                       children: [
//                         _buildMenuItem(Icons.public, 'Manage My Geo'),
//                         _buildMenuItem(Icons.call, 'Call 911/988'),
//                         _buildMenuItem(Icons.volunteer_activism_outlined,
//                             'One Click Donate'),
//                         _buildExpandableMenu(
//                           context,
//                           icon: Icons.menu_book_outlined,
//                           title: 'Assessments',
//                           children: [
//                             // Add sub menu items here if needed
//                             // ListTile(title: Text('Submenu 1')),
//                           ],
//                         ),
//                         _buildMenuItem(Icons.sync_alt, 'Subscriptions',
//                             selected: true),
//                         _buildMenuItem(
//                             Icons.support_agent_outlined, 'Life Guard Support'),
//                         _buildMenuItem(Icons.settings, 'Settings'),
//                         _buildMenuItem(Icons.info_outline, 'About Us'),
//                         _buildMenuItem(Icons.help_outline, 'FAQs'),
//                         _buildMenuItem(
//                             Icons.description_outlined, 'How to Use'),
//                         _buildMenuItem(
//                             Icons.person_add_alt_1_outlined, 'Invite Others'),
//                         Divider(),
//                         ListTile(
//                           leading: Icon(Icons.logout, color: Colors.redAccent),
//                           title: Text(
//                             'Logout',
//                             style: TextStyle(color: Colors.redAccent),
//                           ),
//                           onTap: () {
//                             // Logout action
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMenuItem(IconData icon, String title, {bool selected = false}) {
//     return Container(
//       color: selected ? Color(0xFFDDE8FF) : Colors.transparent,
//       child: ListTile(
//         leading: Icon(icon, color: Colors.grey[800], size: 22),
//         title:
//             Text(title, style: TextStyle(fontSize: 16, color: Colors.black87)),
//         onTap: () {
//           // Handle tap
//         },
//       ),
//     );
//   }

//   Widget _buildExpandableMenu(BuildContext context,
//       {required IconData icon, required String title, List<Widget>? children}) {
//     return ExpansionTile(
//       leading: Icon(icon, color: Colors.grey[800], size: 22),
//       title: Text(title, style: TextStyle(fontSize: 16, color: Colors.black87)),
//       children: children ?? [],
//       trailing: Icon(Icons.keyboard_arrow_down),
//     );
//   }
// }
