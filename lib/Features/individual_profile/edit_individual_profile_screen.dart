import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../Constants/constants.dart';
import '../../widgets/boxDecorationWidget.dart';

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image_picker/image_picker.dart';

class EditIndividualProfileScreen extends StatefulWidget {
  @override
  State<EditIndividualProfileScreen> createState() =>
      _EditIndividualProfileScreenState();
}

class _EditIndividualProfileScreenState
    extends State<EditIndividualProfileScreen> {
  // Form key and image picker
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  // Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController streetController = TextEditingController();

  // Image state
  File? _selectedImage;
  bool _showImageError = false;

  // Terms checkbox
  bool isChecked = false;
  bool _showTermsError = false;
  bool _submitted = false;

  // State/city dropdown
  String? selectedState;
  String? selectedCity;
  Map<String, List<String>> stateCityMap = {};

  @override
  void initState() {
    super.initState();
    _loadStateCityData();
  }

  Future<void> _loadStateCityData() async {
    final jsonStr = await rootBundle.loadString('assets/data.json');
    final data = json.decode(jsonStr) as Map<String, dynamic>;
    setState(() {
      stateCityMap =
          data.map((k, v) => MapEntry(k, List<String>.from(v as List)));
    });
  }

  List<String> get citiesForSelectedState =>
      selectedState != null ? stateCityMap[selectedState!] ?? [] : [];

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _showImageError = false;
      });
    }
  }

  Widget _buildTextField(String label, String hint,
      {required TextEditingController controller,
      String? Function(String?)? validator,
      bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                fontFamily: 'Satoshi',
                color: Color(0xff323747))),
        const SizedBox(height: 5),
        Container(
          width: 376,
          height: 60,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFE6DCFD), Color(0xFFD8E7FF)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            autovalidateMode: _submitted
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xff666F80),
                fontSize: 18,
                fontFamily: 'Satoshi',
                fontWeight: FontWeight.w500,
              ),
              filled: true,
              fillColor: Colors.transparent, // show gradient
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body:
          // stateCityMap.isEmpty
          //     ? const Center(child: CircularProgressIndicator())
          //     :
          SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child:
                        Icon(Icons.arrow_back, color: Colors.black, size: 19),
                  ),
                ),
                const SizedBox(width: 17),
                const Text('Edit Profile',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Satoshi')),
              ],
            ),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 148,
                      width: 120,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: _selectedImage == null
                          ? Center(
                              child: Image.asset('assets/Frame.png',
                                  height: 130, width: 130),
                            )
                          : Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(_selectedImage!,
                                      height: 120,
                                      width: 130,
                                      fit: BoxFit.cover),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  height: 23,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text('change',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                    ),
                  ),
                  if (_showImageError)
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text('Please upload a profile image',
                          style: TextStyle(color: Colors.red)),
                    ),
                  const SizedBox(height: 25),
                  _buildTextField('First Name', 'Enter First Name',
                      controller: firstNameController,
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Required' : null),
                  const SizedBox(height: 15),
                  _buildTextField('Last Name', 'Enter Last Name',
                      controller: lastNameController,
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Required' : null),
                  const SizedBox(height: 15),
                  _buildTextField('Email', 'Enter Email',
                      controller: emailController,
                      validator: (val) => val == null || !val.contains('@')
                          ? 'Enter valid email'
                          : null),
                  const SizedBox(height: 15),
                  _buildTextField('Phone Number', 'Enter Phone Number',
                      controller: phoneController,
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Required' : null),
                  const SizedBox(height: 25),
                  _buildTextField('Street Address', 'Enter Street Address',
                      controller: streetController,
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Required' : null),
                  const SizedBox(height: 20),

                  // State Dropdown
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Select State',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Satoshi',
                              color: Color(0xff323747))),
                      const SizedBox(height: 5),
                      Container(
                        width: 376,
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFE6DCFD), Color(0xFFD8E7FF)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: selectedState,
                          items: (stateCityMap.keys.toList()..sort())
                              .map((state) => DropdownMenuItem<String>(
                                    value: state,
                                    child: Text(
                                      state,
                                      style: const TextStyle(
                                        color: Color(0xff666F80),
                                        fontSize: 18,
                                        fontFamily: 'Satoshi',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (val) => setState(() {
                            selectedState = val;
                            selectedCity = null;
                          }),
                          hint: const Text('Choose State',
                              style: TextStyle(
                                  color: Color(0xff666F80),
                                  fontSize: 18,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w300)),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                              filled: true,
                              fillColor: Colors.transparent),
                          icon: const Icon(Icons.keyboard_arrow_down_rounded,
                              color: Color(0xff323747)),
                          dropdownColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // City Dropdown
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Select City',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Satoshi',
                              color: Color(0xff323747))),
                      const SizedBox(height: 5),
                      Container(
                        width: 376,
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFE6DCFD), Color(0xFFD8E7FF)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: selectedCity,
                          items: citiesForSelectedState.map((city) {
                            return DropdownMenuItem<String>(
                              value: city.toLowerCase(),
                              child: Text(
                                city,
                                style: const TextStyle(
                                  color: Color(0xff666F80),
                                  fontSize: 18,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              setState(() => selectedCity = val),
                          hint: const Text('Choose City',
                              style: TextStyle(
                                  color: Color(0xff666F80),
                                  fontSize: 18,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w300)),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                              filled: true,
                              fillColor: Colors.transparent),
                          icon: const Icon(Icons.keyboard_arrow_down_rounded,
                              color: Color(0xff323747)),
                          dropdownColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  if (_showTermsError)
                    const Text('You must agree to proceed',
                        style: TextStyle(color: Colors.red)),

                  // Submit Button
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 376,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        setState(() {
                          _submitted = true;
                          _showImageError = _selectedImage == null;
                          _showTermsError = !isChecked;
                        });

                        if (_formKey.currentState!.validate() &&
                            !_showImageError &&
                            !_showTermsError) {
                          // Successful submission logic
                        }
                      },
                      child: const Text('Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Satoshi',
                              fontSize: 20,
                              fontWeight: FontWeight.w800)),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class EditIndividualProfileScreen extends StatefulWidget {
//   @override
//   State<EditIndividualProfileScreen> createState() =>
//       _EditIndividualProfileScreenState();
// }

// class _EditIndividualProfileScreenState
//     extends State<EditIndividualProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final ImagePicker _picker = ImagePicker();
//   File? _selectedImage;
//   bool _showImageError = false;
//   bool _showTermsError = false;
//   bool _submitted = false;
//   bool isChecked = false;

//   String? selectedCity;

//   final List<String> cities = [
//     "New York", "Los Angeles", "Chicago", "Houston", "Phoenix", "Philadelphia",
//     "San Antonio", "San Diego", "Dallas", "San Jose", "Austin", "Jacksonville",
//     "Fort Worth", "Columbus", "San Francisco", "Charlotte", "Indianapolis",
//     "Seattle", "Denver", "Washington", "Boston", "El Paso", "Nashville",
//     "Detroit", "Oklahoma City", "Portland", "Las Vegas", "Memphis",
//     "Louisville",
//     "Baltimore", "Milwaukee", "Albuquerque", "Tucson", "Fresno", "Mesa",
//     "Sacramento",
//     "Atlanta", "Kansas City", "Colorado Springs", "Miami", "Raleigh", "Omaha",
//     "Long Beach", "Virginia Beach", "Oakland", "Minneapolis", "Tulsa",
//     "Arlington",
//     "Tampa", "New Orleans", "Wichita", "Cleveland", "Bakersfield", "Aurora",
//     "Anaheim", "Honolulu", "Santa Ana", "Riverside", "Corpus Christi",
//     "Lexington",
//     // You can add more cities if needed
//   ];

//   String? selectedState;

//   final List<String> states = [
//     'Alabama',
//     'Alaska',
//     'Arizona',
//     'Arkansas',
//     'California',
//     'Colorado',
//     'Connecticut',
//     'Delaware',
//     'Florida',
//     'Georgia',
//     'Hawaii',
//     'Idaho',
//     'Illinois',
//     'Indiana',
//     'Iowa',
//     'Kansas',
//     'Kentucky',
//     'Louisiana',
//     'Maine',
//     'Maryland',
//     'Massachusetts',
//     'Michigan',
//     'Minnesota',
//     'Mississippi',
//     'Missouri',
//     'Montana',
//     'Nebraska',
//     'Nevada',
//     'New Hampshire',
//     'New Jersey',
//     'New Mexico',
//     'New York',
//     'North Carolina',
//     'North Dakota',
//     'Ohio',
//     'Oklahoma',
//     'Oregon',
//     'Pennsylvania',
//     'Rhode Island',
//     'South Carolina',
//     'South Dakota',
//     'Tennessee',
//     'Texas',
//     'Utah',
//     'Vermont',
//     'Virginia',
//     'Washington',
//     'West Virginia',
//     'Wisconsin',
//     'Wyoming',
//   ];

//   final Map<String, List<String>> stateCityMap = {
//     'California': ['Los Angeles', 'San Francisco', 'San Diego'],
//     'Texas': ['Houston', 'Dallas', 'Austin'],
//     'New York': ['New York City', 'Buffalo', 'Rochester'],
//     'Florida': ['Miami', 'Orlando', 'Tampa'],
//     'Illinois': ['Chicago', 'Springfield', 'Naperville'],
//     // Add more states and cities as needed
//   };

//   List<String> get citiesForSelectedState {
//     return selectedState != null ? stateCityMap[selectedState!] ?? [] : [];
//   }

//   final TextEditingController firstNameController = TextEditingController();
//   final TextEditingController lastNameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController zipController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();
//   final TextEditingController referralCodeController = TextEditingController();
//   final TextEditingController usernameController = TextEditingController();

//   _pickImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         _selectedImage = File(image.path);
//         _showImageError = false;
//       });
//     }
//   }

//   Widget _buildTextField(String label, String hint,
//       {bool obscureText = false,
//       required TextEditingController controller,
//       String? Function(String?)? validator}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label,
//             style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w900,
//                 fontFamily: 'Satoshi',
//                 color: Color(0xff323747))),
//         const SizedBox(height: 5),
//         Container(
//           width: 376,
//           height: 60,
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [
//                 Color(0xFFE6DCFD),
//                 Color(0xFFD8E7FF),
//               ],
//               begin: Alignment.centerLeft,
//               end: Alignment.centerRight,
//             ),
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: TextFormField(
//             controller: controller,
//             obscureText: obscureText,
//             validator: validator,
//             autovalidateMode: _submitted
//                 ? AutovalidateMode.always
//                 : AutovalidateMode.disabled,
//             decoration: InputDecoration(
//               hintText: hint,
//               hintStyle: const TextStyle(
//                 color: Color(0xff666F80),
//                 fontSize: 18,
//                 fontFamily: 'Satoshi',
//                 fontWeight: FontWeight.w500,
//               ),
//               filled: true,
//               fillColor:
//                   Colors.transparent, // Make fill transparent to show gradient
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   /* Widget _buildTextField(String label, String hint,
//       {bool obscureText = false,
//       required TextEditingController controller,
//       String? Function(String?)? validator}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label,
//             style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w900,
//                 fontFamily: 'Satoshi',
//                 color: Color(0xff323747))),
//         const SizedBox(height: 5),
//         SizedBox(
//           width: 376,
//           height: 80,
//           child: TextFormField(
//             controller: controller,
//             obscureText: obscureText,
//             validator: validator,
//             autovalidateMode: _submitted
//                 ? AutovalidateMode.always
//                 : AutovalidateMode.disabled,
//             decoration: InputDecoration(
//               hintText: hint,
//               hintStyle: const TextStyle(
//                 color: Color(0xff666F80),
//                 fontSize: 18,
//                 fontFamily: 'Satoshi',
//                 fontWeight: FontWeight.w500,
//               ),
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }*/

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.grey[200],
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 60.0),
//                 child: Container(
//                   color: Colors.grey[200],
//                   child: Row(
//                     children: [
//                       const SizedBox(width: 10),
//                       InkWell(
//                         onTap: () => Navigator.pop(context),
//                         child: const CircleAvatar(
//                           radius: 16,
//                           backgroundColor: Colors.white,
//                           child: Icon(Icons.arrow_back,
//                               color: Colors.black, size: 19),
//                         ),
//                       ),
//                       const SizedBox(width: 17),
//                       const Text(
//                         'Edit Profile',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.black87,
//                           fontWeight: FontWeight.w700,
//                           fontFamily: 'Satoshi',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 decoration:
//                     BoxDecoration(color: Colors.grey[200]), //boxDecoration(),
//                 child: SingleChildScrollView(
//                   physics: const ClampingScrollPhysics(),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.only(top: 30.0, left: 10, right: 10),
//                     child: Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         // gradient: LinearGradient(
//                         //   colors: [
//                         //     Color(0xFFE6DCFD),
//                         //     Color(0xFFD8E7FF),
//                         //   ],
//                         //   begin: Alignment.centerLeft,
//                         //   end: Alignment.centerRight,
//                         // ),
//                       ), //boxDecoration(),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20.0, vertical: 30.0),
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             const SizedBox(height: 10),
//                             GestureDetector(
//                               onTap: _pickImage,
//                               child: Container(
//                                 height: 148,
//                                 width: 120,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: _selectedImage == null
//                                     ? Center(
//                                         child: Image.asset('assets/Frame.png',
//                                             height: 130, width: 130),
//                                       )
//                                     : Column(
//                                         children: [
//                                           SizedBox(
//                                             height: 120,
//                                             width: 130,
//                                             child: ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                               child: Image.file(_selectedImage!,
//                                                   fit: BoxFit.cover),
//                                             ),
//                                           ),
//                                           const SizedBox(height: 5),
//                                           Container(
//                                             height: 23,
//                                             width: 80,
//                                             decoration: BoxDecoration(
//                                               color: Constants().themeColor,
//                                               borderRadius:
//                                                   BorderRadius.circular(12),
//                                             ),
//                                             alignment: Alignment.center,
//                                             child: const Text(
//                                               'change',
//                                               style: TextStyle(
//                                                   color: Colors.white),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                               ),
//                             ),
//                             if (_showImageError)
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 8.0),
//                                 child: Text(
//                                   'Please upload a profile image',
//                                   style: TextStyle(
//                                       color: Colors.red, fontSize: 14),
//                                 ),
//                               ),
//                             Padding(
//                               padding: EdgeInsets.only(
//                                   right:
//                                       MediaQuery.of(context).size.width * 0.25),
//                               child: SizedBox(
//                                 //width: MediaQuery.of(context).size.width * 0.75,
//                                 child: Text("Personal Information",
//                                     // textAlign: TextAlign.left,
//                                     style: const TextStyle(
//                                         fontSize: 23,
//                                         fontWeight: FontWeight.w900,
//                                         fontFamily: 'Satoshi',
//                                         color: Color(0xff323747))),
//                               ),
//                             ),
//                             const SizedBox(height: 25),
//                             _buildTextField('First Name', 'Enter First Name',
//                                 controller: firstNameController,
//                                 validator: (val) => val == null || val.isEmpty
//                                     ? 'Required'
//                                     : null),
//                             const SizedBox(height: 15),
//                             _buildTextField('Last Name', 'Enter Last Name',
//                                 controller: lastNameController,
//                                 validator: (val) => val == null || val.isEmpty
//                                     ? 'Required'
//                                     : null),
//                             const SizedBox(height: 15),
//                             _buildTextField('Email', 'Enter Email',
//                                 controller: emailController,
//                                 validator: (val) =>
//                                     val == null || !val.contains('@')
//                                         ? 'Enter valid email'
//                                         : null),
//                             const SizedBox(height: 15),
//                             _buildTextField(
//                                 'Phone Number', 'Enter Phone Number',
//                                 controller: phoneController,
//                                 validator: (val) => val == null || val.isEmpty
//                                     ? 'Required'
//                                     : null),
//                             const SizedBox(height: 15),
//                             Padding(
//                               padding: EdgeInsets.only(
//                                   right:
//                                       MediaQuery.of(context).size.width * 0.40),
//                               child: SizedBox(
//                                 //width: MediaQuery.of(context).size.width * 0.75,
//                                 child: Text("Address Details",
//                                     // textAlign: TextAlign.left,
//                                     style: const TextStyle(
//                                         fontSize: 23,
//                                         fontWeight: FontWeight.w900,
//                                         fontFamily: 'Satoshi',
//                                         color: Color(0xff323747))),
//                               ),
//                             ),
//                             const SizedBox(height: 15),
//                             _buildTextField(
//                                 'Street Address', 'Enter Street Address',
//                                 controller: phoneController,
//                                 validator: (val) => val == null || val.isEmpty
//                                     ? 'Required'
//                                     : null),
//                             const SizedBox(height: 15),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text('Area #',
//                                         style: const TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w900,
//                                             fontFamily: 'Satoshi',
//                                             color: Color(0xff323747))),
//                                     Text('(Optional)',
//                                         style: const TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.w700,
//                                             fontFamily: 'Satoshi',
//                                             color: Colors.black54)),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Container(
//                                   width: 376,
//                                   height: 60,
//                                   decoration: BoxDecoration(
//                                     gradient: const LinearGradient(
//                                       colors: [
//                                         Color(0xFFE6DCFD),
//                                         Color(0xFFD8E7FF),
//                                       ],
//                                       begin: Alignment.centerLeft,
//                                       end: Alignment.centerRight,
//                                     ),
//                                     borderRadius: BorderRadius.circular(16),
//                                   ),
//                                   child: TextFormField(
//                                     controller: phoneController,
//                                     // obscureText: obscureText,
//                                     validator: (val) =>
//                                         val == null || val.isEmpty
//                                             ? 'Required'
//                                             : null,
//                                     autovalidateMode: _submitted
//                                         ? AutovalidateMode.always
//                                         : AutovalidateMode.disabled,
//                                     decoration: InputDecoration(
//                                       hintText: "Area #",
//                                       hintStyle: const TextStyle(
//                                         color: Color(0xff666F80),
//                                         fontSize: 18,
//                                         fontFamily: 'Satoshi',
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                       filled: true,
//                                       fillColor: Colors
//                                           .transparent, // Make fill transparent to show gradient
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(16),
//                                         borderSide: BorderSide.none,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 15,
//                             ),
//                             const Text(
//                               'Select State',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w900,
//                                 fontFamily: 'Satoshi',
//                                 color: Color(0xff323747),
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             Container(
//                               width: 376,
//                               height: 60,
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 12),
//                               decoration: BoxDecoration(
//                                 gradient: const LinearGradient(
//                                   colors: [
//                                     Color(0xFFE6DCFD),
//                                     Color(0xFFD8E7FF)
//                                   ],
//                                   begin: Alignment.centerLeft,
//                                   end: Alignment.centerRight,
//                                 ),
//                                 borderRadius: BorderRadius.circular(16),
//                               ),
//                               child: DropdownButtonFormField<String>(
//                                 value: selectedState,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     selectedState = value;
//                                     selectedCity =
//                                         null; // reset city on state change
//                                   });
//                                 },
//                                 items: stateCityMap.keys.map((state) {
//                                   return DropdownMenuItem<String>(
//                                     value: state,
//                                     child: Text(
//                                       state,
//                                       style: const TextStyle(
//                                         color: Color(0xff666F80),
//                                         fontSize: 18,
//                                         fontFamily: 'Satoshi',
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                                 hint: const Text(
//                                   "Choose State",
//                                   style: TextStyle(
//                                     color: Color(0xff666F80),
//                                     fontSize: 18,
//                                     fontFamily: 'Satoshi',
//                                     fontWeight: FontWeight.w300,
//                                   ),
//                                 ),
//                                 decoration: const InputDecoration(
//                                   border: OutlineInputBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(16)),
//                                     borderSide: BorderSide.none,
//                                   ),
//                                   filled: true,
//                                   fillColor: Colors.transparent,
//                                 ),
//                                 icon: const Icon(
//                                     Icons.keyboard_arrow_down_rounded,
//                                     color: Color(0xff323747)),
//                                 dropdownColor: Colors.white,
//                               ),
//                             ),

//                             const SizedBox(height: 20),

//                             // City Dropdown
//                             const Text(
//                               'Select City',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w900,
//                                 fontFamily: 'Satoshi',
//                                 color: Color(0xff323747),
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             Container(
//                               width: 376,
//                               height: 60,
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 12),
//                               decoration: BoxDecoration(
//                                 gradient: const LinearGradient(
//                                   colors: [
//                                     Color(0xFFE6DCFD),
//                                     Color(0xFFD8E7FF)
//                                   ],
//                                   begin: Alignment.centerLeft,
//                                   end: Alignment.centerRight,
//                                 ),
//                                 borderRadius: BorderRadius.circular(16),
//                               ),
//                               child: DropdownButtonFormField<String>(
//                                 value: selectedCity,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     selectedCity = value;
//                                   });
//                                 },
//                                 items: citiesForSelectedState.map((city) {
//                                   return DropdownMenuItem<String>(
//                                     value: city,
//                                     child: Text(
//                                       city,
//                                       style: const TextStyle(
//                                         color: Color(0xff666F80),
//                                         fontSize: 18,
//                                         fontFamily: 'Satoshi',
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                                 hint: const Text(
//                                   "Choose City",
//                                   style: TextStyle(
//                                     color: Color(0xff666F80),
//                                     fontSize: 18,
//                                     fontFamily: 'Satoshi',
//                                     fontWeight: FontWeight.w300, // thin text
//                                   ),
//                                 ),
//                                 decoration: const InputDecoration(
//                                   border: OutlineInputBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(16)),
//                                     borderSide: BorderSide.none,
//                                   ),
//                                   filled: true,
//                                   fillColor: Colors.transparent,
//                                 ),
//                                 icon: const Icon(
//                                     Icons.keyboard_arrow_down_rounded,
//                                     color: Color(0xff323747)),
//                                 dropdownColor: Colors.white,
//                               ),
//                             ),

//                             const SizedBox(height: 40),
//                             SizedBox(
//                               width: 376,
//                               height: 55,
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     _submitted = true;
//                                     _showImageError = _selectedImage == null;
//                                     _showTermsError = !isChecked;
//                                   });
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Constants().themeColor,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(30),
//                                   ),
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 20, vertical: 10),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Text(
//                                       'Register',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontFamily: 'Satoshi',
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w800),
//                                     ),
//                                     const SizedBox(width: 5),
//                                     Image.asset('assets/loginbuttonicon.png',
//                                         width: 23, height: 23),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 30),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }
