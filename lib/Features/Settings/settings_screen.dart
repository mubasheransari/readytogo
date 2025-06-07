import 'package:flutter/material.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';

class SettingsScreen extends StatelessWidget {
  final Color backgroundColor = Color(0xFFF5F7FF); // Light blue gradient

  final List<Map<String, dynamic>> accountItems = [
    {'icon': Icons.settings, 'title': 'Change Password'},
    {'icon': Icons.subscriptions, 'title': 'Subscription Update'},
    {'icon': Icons.payment, 'title': 'Payment Settings'},
    {'icon': Icons.description, 'title': 'Terms & Conditions'},
    {'icon': Icons.privacy_tip, 'title': 'Privacy Policy'},
    {'icon': Icons.help_outline, 'title': 'FAQs'},
  ];

  final List<String> permissionItems = [
    'Profile Visibility',
    'Address',
    'Profile Picture',
    'Contact Information',
    'Notifications',
    'Lifeguard',
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appbartitle: "Settings",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...accountItems.map((item) => SettingTile(
                    icon: item['icon'],
                    title: item['title'],
                  )),

              SizedBox(height: 20),

              Text("Permissions",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),

              SizedBox(height: 10),

              // Permission Toggles
              ...permissionItems.map((title) => PermissionTile(title: title)),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const SettingTile({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: Color(0xFFE8ECFF),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(10),
          child: Icon(icon, color: Color(0xFF4A60A1)),
        ),
        title: Text(title,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}

class PermissionTile extends StatefulWidget {
  final String title;

  const PermissionTile({required this.title});

  @override
  State<PermissionTile> createState() => _PermissionTileState();
}

class _PermissionTileState extends State<PermissionTile> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: isOn,
      onChanged: (val) => setState(() => isOn = val),
      title: Text(widget.title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
      activeColor: Color(0xFF4A60A1),
      contentPadding: EdgeInsets.zero,
    );
  }
}
