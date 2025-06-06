import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';

import '../widgets/boxDecorationWidget.dart';

class RecoveryWellnessPlanScreen extends StatefulWidget {
  @override
  _RecoveryWellnessPlanScreenState createState() =>
      _RecoveryWellnessPlanScreenState();
}

class _RecoveryWellnessPlanScreenState
    extends State<RecoveryWellnessPlanScreen> {
  bool? isVeteran;
  List<String> selectedDomains = [];
  String primaryDomain = 'Clinical Treatment/Telehealth';

  final List<String> domains = [
    'Housing',
    'Family/Reuniting, Family/Aftercare',
    'Employment',
    'Education',
    'Clinical Treatment/Telehealth',
    'Recovery Support Services',
    'Allies, Advocates, and Support',
    'Faith and Spirituality',
    'Recovery Community',
    'Legal/Criminal Justice',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD8E7FF),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      decoration: boxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 8),
                  const Text(
                    'Release Of Information',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff666F80),
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text(
                'Question 1/13',
                style: TextStyle(
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF666F80),
                ),
              ),
              SizedBox(height: 8),
              LinearProgressIndicator(
                value: 1 / 13,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation(Color(0xFF4C6FEE)),
                minHeight: 6,
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        offset: Offset(0, 2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
                          child: RawScrollbar(
                            thumbVisibility: true,
                            thickness: 6,
                            radius: Radius.circular(10),
                            thumbColor: Color(0xFF4C6FEE),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF4C6FEE),
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 14),
                                      child: Text(
                                        'Domains',
                                        style: TextStyle(
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 13.0),
                                    child: Text(
                                      'Please Select a Domain',
                                      style: TextStyle(
                                        fontFamily: 'Satoshi',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24,
                                        color: Color(0xFF323747),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 13.0),
                                    child: Text(
                                      '(check all that apply)',
                                      style: TextStyle(
                                        fontFamily: 'Satoshi',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Color(0xFF666F80),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 13.0),
                                    child: Text(
                                      'Are you a veteran?',
                                      style: TextStyle(
                                        fontFamily: 'Satoshi',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Color(0xFF323747),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Radio<bool>(
                                        value: true,
                                        groupValue: isVeteran,
                                        activeColor: Color(0xFF4C6FEE),
                                        onChanged: (val) {
                                          setState(() {
                                            isVeteran = val;
                                          });
                                        },
                                      ),
                                      Text(
                                        'Yes',
                                        style: TextStyle(
                                          fontFamily: 'Satoshi',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF323747),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Radio<bool>(
                                        value: false,
                                        groupValue: isVeteran,
                                        activeColor: Color(0xFF4C6FEE),
                                        onChanged: (val) {
                                          setState(() {
                                            isVeteran = val;
                                          });
                                        },
                                      ),
                                      Text(
                                        'No',
                                        style: TextStyle(
                                          fontFamily: 'Satoshi',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF323747),
                                        ),
                                      ),
                                    ],
                                  ),

                                  /// Updated domain selection UI
                                  Column(
                                    children: domains.map((domain) {
                                      bool isSelected =
                                          selectedDomains.contains(domain);
                                      bool isPrimary =
                                          domain == primaryDomain && isSelected;

                                      return ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 8),
                                        leading: Checkbox(
                                          value: isSelected,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value == true) {
                                                selectedDomains.add(domain);
                                              } else {
                                                selectedDomains.remove(domain);
                                              }
                                            });
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          side: const BorderSide(
                                              color: Colors.grey),
                                          activeColor: const Color(0xFF4C6FEE),
                                          checkColor: Colors.white,
                                        ),
                                        title: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                domain,
                                                style: const TextStyle(
                                                  fontFamily: 'Satoshi',
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 18,
                                                  color: Color(0xFF323747),
                                                ),
                                              ),
                                            ),
                                            if (isPrimary)
                                              const Text(
                                                'Primary Domain',
                                                style: TextStyle(
                                                  fontFamily: 'Satoshi',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  fontStyle: FontStyle.italic,
                                                  color: Color(0xFF666F80),
                                                ),
                                              ),
                                          ],
                                        ),
                                        onTap: () {
                                          setState(() {
                                            if (isSelected) {
                                              selectedDomains.remove(domain);
                                            } else {
                                              selectedDomains.add(domain);
                                            }
                                          });
                                        },
                                        onLongPress: isSelected
                                            ? () {
                                                setState(() {
                                                  primaryDomain = domain;
                                                });
                                              }
                                            : null,
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 376,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle start action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4C6FEE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Click to Start',
                    style: TextStyle(
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}









// class RecoveryWellnessPlanScreen extends StatefulWidget {
//   @override
//   _RecoveryWellnessPlanScreenState createState() =>
//       _RecoveryWellnessPlanScreenState();
// }

// class _RecoveryWellnessPlanScreenState
//     extends State<RecoveryWellnessPlanScreen> {
//   bool? isVeteran; // nullable to allow no selection initially
//   List<String> selectedDomains = [];
//   final String primaryDomain = 'Clinical Treatment/Telehealth';

//   final List<String> domains = [
//     'Housing',
//     'Family/Reuniting, Family/Aftercare',
//     'Employment',
//     'Education',
//     'Clinical Treatment/Telehealth',
//     'Recovery Support Services',
//     'Allies, Advocates, and Support',
//     'Faith and Spirituality',
//     'Recovery Community',
//     'Legal/Criminal Justice',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFD8E7FF),
    
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFFE6DCFD),
//               Color(0xFFD8E7FF),
//             ],
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 40,
//               ),
//               Row(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: CircleAvatar(
//                       radius: 17,
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.arrow_back, color: Colors.black),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 8,
//                   ),
//                   // Icon(Icons.arrow_back, color: Colors.white),

//                   ///  Image.asset("assets/arrow-narrow-left.png"),
//                   const Text(
//                     'Release Of Information',
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: Color(0xff666F80),
//                       fontWeight: FontWeight.w700,
//                       fontFamily: 'Satoshi',
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               Text(
//                 'Question 1/13',
//                 style: TextStyle(
//                   fontFamily: 'Satoshi',
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16,
//                   color: Color(0xFF666F80),
//                 ),
//               ),
//               SizedBox(height: 8),
//               LinearProgressIndicator(
//                 value: 1 / 13,
//                 backgroundColor: Colors.white,
//                 valueColor: AlwaysStoppedAnimation(Color(0xFF4C6FEE)),
//                 minHeight: 6,
//               ),
//               SizedBox(height: 20),

//               // The white rounded container with scrollable content
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(25),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.12),
//                         offset: Offset(0, 2),
//                         blurRadius: 8,
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
                     

//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 5, vertical: 2),
//                           child: RawScrollbar(
//                             thumbVisibility: true,
//                             thickness: 6,
//                             radius: Radius.circular(10),
//                             thumbColor: Color(0xFF4C6FEE),
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(height: 5),
//                                   Container(
//                                     width: MediaQuery.of(context).size.width,
//                                     height: 52,
//                                     // padding: EdgeInsets.symmetric(vertical: 15),
//                                     decoration: BoxDecoration(
//                                         color: Constants().themeColor,
//                                         borderRadius:
//                                             BorderRadius.circular(32)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 8.0),
//                                       child: Padding(
//                                         padding: const EdgeInsets.fromLTRB(
//                                             12, 12, 0, 0),
//                                         child: Text(
//                                           'Domains',
//                                           // textAlign: TextAlign.left,
//                                           style: TextStyle(
//                                             fontFamily: 'Satoshi',
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 20,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(height: 10),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 13.0),
//                                     child: Text(
//                                       'Please Select a Domain',
//                                       style: TextStyle(
//                                         fontFamily: 'Satoshi',
//                                         fontWeight: FontWeight.w700,
//                                         fontSize: 24,
//                                         color: Color(0xFF323747),
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 13.0),
//                                     child: Text(
//                                       '(check all that apply)',
//                                       style: TextStyle(
//                                         fontFamily: 'Satoshi',
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 14,
//                                         color: Color(0xFF666F80),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(height: 20),

//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 13.0),
//                                     child: Text(
//                                       'Are you a veteran?',
//                                       style: TextStyle(
//                                         fontFamily: 'Satoshi',
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 20,
//                                         color: Color(0xFF323747),
//                                       ),
//                                     ),
//                                   ),

//                                   // Radio buttons with labels aligned horizontally
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 0.0),
//                                     child: Row(
//                                       children: [
//                                         Radio<bool>(
//                                           value: true,
//                                           groupValue: isVeteran,
//                                           activeColor: Color(0xFF4C6FEE),
//                                           onChanged: (val) {
//                                             setState(() {
//                                               isVeteran = val;
//                                             });
//                                           },
//                                         ),
//                                         Text(
//                                           'Yes',
//                                           style: TextStyle(
//                                               fontFamily: 'Satoshi',
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w700,
//                                               color: Color(0xFF323747)),
//                                         ),
//                                         SizedBox(
//                                           width: 20,
//                                         ),
//                                         Radio<bool>(
//                                           value: false,
//                                           groupValue: isVeteran,
//                                           activeColor: Color(0xFF4C6FEE),
//                                           onChanged: (val) {
//                                             setState(() {
//                                               isVeteran = val;
//                                             });
//                                           },
//                                         ),
//                                         Text(
//                                           'No',
//                                           style: TextStyle(
//                                               fontFamily: 'Satoshi',
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w700,
//                                               color: Color(0xFF323747)),
//                                         ),
//                                       ],
//                                     ),
//                                   ),

                               
//                                   Column(
//                                     children: domains.map((domain) {
//                                       bool isPrimary =
//                                           domain == primaryDomain &&
//                                               selectedDomains.contains(domain);
//                                       return CheckboxListTile(
//                                         contentPadding: EdgeInsets.zero,
//                                         title: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             // Text(
//                                             //   domain,
//                                             //   style: TextStyle(
//                                             //     fontFamily: 'Satoshi',
//                                             //     fontWeight: FontWeight.w500,
//                                             //     fontSize: 16,
//                                             //     color: Color(0xFF323747),
//                                             //   ),
//                                             // ),
//                                             if (isPrimary)
//                                               Text(
//                                                 'Primary Domain',
//                                                 style: TextStyle(
//                                                   fontFamily: 'Satoshi',
//                                                   fontWeight: FontWeight.w400,
//                                                   fontSize: 12,
//                                                   color: Color(0xFF666F80),
//                                                 ),
//                                               ),
//                                             Text(
//                                               domain,
//                                               style: TextStyle(
//                                                 fontFamily: 'Satoshi',
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 16,
//                                                 color: Color(0xFF323747),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         value: selectedDomains.contains(domain),
//                                         activeColor: Color(0xFF4C6FEE),
//                                         checkColor: Colors.white,
//                                         onChanged: (bool? checked) {
//                                           setState(() {
//                                             if (checked == true) {
//                                               selectedDomains.add(domain);
//                                             } else {
//                                               selectedDomains.remove(domain);
//                                             }
//                                           });
//                                         },
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               SizedBox(height: 20),

//               // Click to Start button
//               SizedBox(
//                 width: 376,
//                 height: 60,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Handle start action
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF4C6FEE),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   child: Text(
//                     'Click to Start',
//                     style: TextStyle(
//                       fontFamily: 'Satoshi',
//                       fontWeight: FontWeight.w700,
//                       fontSize: 20,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
