import 'package:flutter/material.dart';

import '../Constants/constants.dart';
import 'home_screen.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final TextEditingController _zipCodeController =
      TextEditingController(text: "NW1 6XE");

  String _selectedMemberType = 'Provider';
  String _selectedService = 'Nutritionist';
  String _selectedDistance = 'Under 6km';

  final List<String> _memberTypes = ['Provider', 'Client', 'Other'];
  final List<String> _services = ['Nutritionist', 'Therapist', 'Coach'];
  final List<String> _distances = ['Under 6km', 'Under 12km', 'Under 20km'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.84,
      // Height can be adjusted as per need
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        gradient: LinearGradient(
          colors: [
            Color(0xFFE6DCFD),
            Color(0xFFD8E7FF),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(20)),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              'Filters',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
            ),
          ),
          SizedBox(height: 20),

          // Zip Code
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Zip Code',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
            ),
          ),
          SizedBox(height: 4),
          TextField(
            controller: _zipCodeController,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
              ),
            ),
          ),
          SizedBox(height: 20),

          // Type of Member Dropdown
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Type of Member',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
            ),
          ),
          SizedBox(height: 4),
          DropdownButtonFormField<String>(
            value: _selectedMemberType,
            items: _memberTypes
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) {
              setState(() {
                _selectedMemberType = val!;
              });
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
              ),
            ),
          ),
          SizedBox(height: 20),

          // Service Dropdown
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Service',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
            ),
          ),
          SizedBox(height: 4),
          DropdownButtonFormField<String>(
            value: _selectedService,
            items: _services
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) {
              setState(() {
                _selectedService = val!;
              });
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
              ),
            ),
          ),
          SizedBox(height: 20),

          // Distance Dropdown
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Distance',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
            ),
          ),
          SizedBox(height: 4),
          DropdownButtonFormField<String>(
            value: _selectedDistance,
            items: _distances
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) {
              setState(() {
                _selectedDistance = val!;
              });
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
              ),
            ),
          ),
          SizedBox(height: 30),
          SizedBox(
            width: 342,
            height: 60,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen
                              // VerificationScreen
                              ()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants().themeColor,
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Apply Filters',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Satoshi',
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 10),
                    Image.asset(
                      'assets/loginbuttonicon.png',
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Apply Filters Button
          // SizedBox(
          //   width: double.infinity,
          //   child: ElevatedButton.icon(
          //     onPressed: () {
          //       // You can pass the selected filters back or handle them here
          //       Navigator.of(context).pop({
          //         'zipCode': _zipCodeController.text,
          //         'memberType': _selectedMemberType,
          //         'service': _selectedService,
          //         'distance': _selectedDistance,
          //       });
          //     },
          //     icon: Icon(Icons.check_circle_outline),
          //     label: Text('Apply Filters'),
          //     style: ElevatedButton.styleFrom(
          //       padding: EdgeInsets.symmetric(vertical: 14),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //       textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          //       backgroundColor: Colors.blue.shade600,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
