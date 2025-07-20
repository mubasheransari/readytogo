import 'package:flutter/material.dart';
import 'package:readytogo/Features/login/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readytogo/Features/login/bloc/login_event.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _serviceController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  double _distanceValue = 6.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE6DCFD), Color(0xFFD8E7FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 5,
              width: 60,
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Center(
            child: Text(
              'Filters',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Satoshi',
              ),
            ),
          ),
          SizedBox(height: 24),
          _buildLabel("Search"),
          _buildTextField(_searchController, "Search"),
          SizedBox(height: 20),
          _buildLabel("Zip Code"),
          _buildTextField(_zipCodeController, "Zip Code"),

          SizedBox(height: 20),
          _buildLabel("Service"),
          _buildTextField(_serviceController, "Service"),

          SizedBox(height: 24),
          _buildLabel("Distance (${_distanceValue.toStringAsFixed(1)} km)"),

          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Color(0xFF407BFF),
              inactiveTrackColor: Colors.grey.shade300,
              thumbColor: Color(0xFF407BFF),
              overlayColor: Color(0xFF407BFF).withOpacity(0.2),
              trackHeight: 4,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 18),
            ),
            child: Slider(
              value: _distanceValue,
              min: 1,
              max: 50,
              divisions: 49,
              label: "${_distanceValue.toStringAsFixed(1)} km",
              onChanged: (value) {
                setState(() {
                  _distanceValue = value;
                });
              },
            ),
          ),

          //  Spacer(),
          SizedBox(height: 20),

          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            height: 50,
            // width: double.infinity, 10@Testing
            // height: 56,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // You can pass data back here
                // context.read<LoginBloc>().add(FiltersSearchFunctionality(
                //     search: "dr irvin packwell",
                //     zipcode: "75850",
                //     service: "urologist",
                //     distance: _distanceValue));
                    //10@Testing
                    
                    
                        context.read<LoginBloc>().add(FiltersSearchFunctionality(
                    search: _searchController.text,
                    zipcode: _zipCodeController.text,
                    service: _serviceController.text,
                    distance: _distanceValue));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF407BFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 3,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Apply Filters',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.check_circle_outline,
                      color: Colors.white, size: 22),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        fontFamily: 'Satoshi',
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Container(
      margin: EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
