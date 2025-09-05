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
import 'package:readytogo/Features/admin/user_management/user_assessments_screen.dart';
import 'package:readytogo/Features/admin/dashboard/admin_dashboard_screen.dart';

class CustomNavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final dynamic roles = box.read("role");
    final bool isAdmin = (roles is List && roles.contains("Admin")) || (roles is String && roles == "Admin");
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      final String imageUrl = state.status == LoginStatus.profileLoaded
                          ? 'http://173.249.27.4:343/${state.profile!.profileImageUrl}'
                          : state.professionalStatus == ProfessionalStatus.success
                              ? 'http://173.249.27.4:343/${state.professionalProfileModel!.profileImageUrl}'
                              : state.organizationalStatus == OrganizationalStatus.success
                                  ? 'http://173.249.27.4:343/${state.organizationProfileModel!.profileImageUrl}'
                                  : 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=64&q=80';
                      final String userRole = isAdmin
                          ? 'Admin'
                          : state.status == LoginStatus.profileLoaded
                              ? 'Individual'
                              : state.professionalStatus == ProfessionalStatus.success
                                  ? 'Professional'
                                  : state.organizationalStatus == OrganizationalStatus.success
                                      ? 'Organization'
                                      : 'Guest';
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 7),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(imageUrl),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.status == LoginStatus.profileLoaded
                                            ? '${state.profile!.firstname} ${state.profile!.lastname}'
                                            : state.professionalStatus == ProfessionalStatus.success
                                                ? '${state.professionalProfileModel!.firstname} ${state.professionalProfileModel!.lastname}'
                                                : state.organizationalStatus == OrganizationalStatus.success
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
                  const SizedBox(height: 6),
                  Divider(thickness: 1, height: 1),
                  if (!isAdmin) ...[
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          _buildMenuItem("assets/manageMyGeo.png", 'Manage My Geo', onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ManageMyGeo()),
                            );
                          }),
                          _buildMenuItem("assets/phoneiconnavbar.png", 'Call 911/988'),
                          _buildMenuItem("assets/coins-hand.png", 'One Click Donate', onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DonateScreenNavBar()),
                            );
                          }),
                          InkWell(
                            onTap: () {
                              var value = box.read("assessment");
                              if (value == "1") {
                                toastWidget("Assessment Completed", Colors.green);
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Step1Screen()),
                                );
                              }
                            },
                            child: _buildMenuItem("assets/assesment.png", 'Assessments'),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SubscriptionScreen()),
                              );
                            },
                            child: _buildMenuItem("assets/credit-card-refresh.png", 'Subscriptions'),
                          ),
                          _buildMenuItem("assets/lifesupportguard.png", 'Life Guard Support'),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SettingsScreen()),
                              );
                            },
                            child: _buildMenuItem("assets/settings-02.png", 'Settings'),
                          ),
                          _buildMenuItem("assets/aboutus.png", 'About Us', onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AboutUsScreen()),
                            );
                          }),
                          _buildMenuItem("assets/faqs.png", 'FAQs'),
                          _buildMenuItem("assets/howtouse.png", 'How to Use', onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HowToUseScreen()),
                            );
                          }),
                          _buildMenuItem("assets/invite.png", 'Invite Others'),
                        ],
                      ),
                    ),
                  ]
                  else ...[
                    // Admin-only drawer links
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.dashboard, color: Colors.blue),
                            title: Text('Dashboard', style: TextStyle(fontWeight: FontWeight.w600)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AdminDashboardScreen()),
                              );
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.assignment_ind, color: Colors.blue),
                            title: Text('User Assessments', style: TextStyle(fontWeight: FontWeight.w600)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => UserAssessmentsScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                  Divider(),
                  ListTile(
                    leading: Image.asset("assets/logout.png"),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      logoutDialog(context);
                    },
                  ),
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