import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';
import 'package:readytogo/widgets/boxDecorationWidget.dart';

class Step1Screen extends StatefulWidget {
  const Step1Screen({Key? key}) : super(key: key);

  @override
  State<Step1Screen> createState() => _Step1ScreenState();
}

class _Step1ScreenState extends State<Step1Screen> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _domainScrollController = ScrollController();
  bool _isVeteran = true;

  List<String> _selectedDomains = [];

  final List<String> _domains = [
    'Housing',
    'Family/Reuniting, Family/Aftercare',
    'Employment',
    'Education',
    'Clinical Treatment/Telehealth',
    'Allies, Advocates and Support',
    'Housing',
    'Family/Reuniting, Family/Aftercare',
    'Employment',
    'Education',
    'Clinical Treatment/Telehealth',
    'Allies, Advocates and Support',
    'Housing',
    'Family/Reuniting, Family/Aftercare',
    'Employment',
    'Education',
    'Clinical Treatment/Telehealth',
    'Allies, Advocates and Support',
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    _domainScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: boxDecoration(),
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              const SizedBox(height: 76),
              Row(
                children: [
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const CircleAvatar(
                      radius: 19,
                      backgroundColor: Colors.white,
                      child:
                          Icon(Icons.arrow_back, color: Colors.black, size: 19),
                    ),
                  ),
                  const SizedBox(width: 17),
                  const Text(
                    'Recovery Wellness Plan',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: const Text(
                      'Question 1/13',
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'satoshi',
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white,
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(10),
                      stopIndicatorColor: Colors.white,
                      value: 1 / 13,
                      valueColor: AlwaysStoppedAnimation(
                        Constants().themeColor,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0), // only horizontal
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 16), // added margin to separate from top bar
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Constants().themeColor,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 12.0, left: 25),
                          child: Text(
                            'Domains',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'satoshi',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          'Please Select a Domain',
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          '(check all that apply)',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'satoshi',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          'Are you a veteran?',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Radio<bool>(
                            value: true,
                            groupValue: _isVeteran,
                            onChanged: (value) {
                              setState(() {
                                _isVeteran = value!;
                              });
                            },
                            activeColor: Constants().themeColor,
                          ),
                          const Text('Yes'),
                          Radio<bool>(
                            value: false,
                            groupValue: _isVeteran,
                            onChanged: (value) {
                              setState(() {
                                _isVeteran = value!;
                              });
                            },
                            activeColor: Constants().themeColor,
                          ),
                          const Text('No'),
                        ],
                      ),
                      // Domain scroll list with no extra spacing above
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.41,
                        child: RawScrollbar(
                          thumbVisibility: true,
                          trackVisibility: true,
                          thickness: 10,
                          radius: const Radius.circular(10),
                          thumbColor: Constants().themeColor,
                          controller: _domainScrollController,
                          child: ListView.builder(
                            controller: _domainScrollController,
                            padding: EdgeInsets.zero,
                            itemCount: _domains.length,
                            itemBuilder: (context, index) {
                              final domain = _domains[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: _selectedDomains.contains(domain),
                                      onChanged: (value) {
                                        setState(() {
                                          if (value == true) {
                                            _selectedDomains.add(domain);
                                          } else {
                                            _selectedDomains.remove(domain);
                                          }
                                        });
                                      },
                                      activeColor: Constants().themeColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            domain,
                                            style: const TextStyle(
                                              fontFamily: 'satoshi',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                            ),
                                          ),
                                          if (domain ==
                                              'Clinical Treatment/Telehealth')
                                            Text(
                                              'Primary Domain',
                                              style: TextStyle(
                                                color: Constants().themeColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4C6FEE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Click to Start →',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Satoshi',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height),
            ],
          ),
        ),
      ),
    );
  }
}


/*class Step1Screen extends StatefulWidget {
  const Step1Screen({Key? key}) : super(key: key);

  @override
  State<Step1Screen> createState() => _Step1ScreenState();
}

class _Step1ScreenState extends State<Step1Screen> {
  final ScrollController _scrollController = ScrollController();
  bool _isVeteran = true;
  final ScrollController _domainScrollController = ScrollController();

  List<String> _selectedDomains = [];

  final List<String> _domains = [
    'Housing',
    'Family/Reuniting, Family/Aftercare',
    'Employment',
    'Education',
    'Clinical Treatment/Telehealth',
    'Allies, Advocates and Support',
    'Housing',
    'Family/Reuniting, Family/Aftercare',
    'Employment',
    'Education',
    'Clinical Treatment/Telehealth',
    'Allies, Advocates and Support',
    'Housing',
    'Family/Reuniting, Family/Aftercare',
    'Employment',
    'Education',
    'Clinical Treatment/Telehealth',
    'Allies, Advocates and Support',
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: boxDecoration(),
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              const SizedBox(height: 70),
              Row(
                children: [
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const CircleAvatar(
                      radius: 19,
                      backgroundColor: Colors.white,
                      child:
                          Icon(Icons.arrow_back, color: Colors.black, size: 19),
                    ),
                  ),
                  const SizedBox(width: 17),
                  const Text(
                    'Recovery Wellness Plan',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Constants().themeColor),
                        width: MediaQuery.of(context).size.width,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 12.0, left: 25),
                          child: Text(
                            'Domains',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'satoshi',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          'Please Select a Domain',
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          '(check all that apply)',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'satoshi',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          'Are you a veteran?',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Radio<bool>(
                            value: true,
                            groupValue: _isVeteran,
                            onChanged: (value) {
                              setState(() {
                                _isVeteran = value!;
                              });
                            },
                            activeColor: Constants().themeColor,
                          ),
                          const Text('Yes'),
                          Radio<bool>(
                            value: false,
                            groupValue: _isVeteran,
                            onChanged: (value) {
                              setState(() {
                                _isVeteran = value!;
                              });
                            },
                            activeColor: Constants().themeColor,
                          ),
                          const Text('No'),
                        ],
                      ),
                      SizedBox(
                        height:
                            300, // or whatever height you want for the scrollable domain list
                        child: RawScrollbar(
                          thumbVisibility: true,
                          trackVisibility: true,
                          thickness: 10,
                          radius: const Radius.circular(10),
                          thumbColor: Constants().themeColor,
                          controller: _domainScrollController,
                          child: ListView.builder(
                            controller: _domainScrollController,
                            itemCount: _domains.length,
                            itemBuilder: (context, index) {
                              final domain = _domains[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: _selectedDomains.contains(domain),
                                      onChanged: (value) {
                                        setState(() {
                                          if (value == true) {
                                            _selectedDomains.add(domain);
                                          } else {
                                            _selectedDomains.remove(domain);
                                          }
                                        });
                                      },
                                      activeColor: Constants().themeColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            domain,
                                            style: const TextStyle(
                                              fontFamily: 'satoshi',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                            ),
                                          ),
                                          if (domain ==
                                              'Clinical Treatment/Telehealth')
                                            Text(
                                              'Primary Domain',
                                              style: TextStyle(
                                                color: Constants().themeColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      /*  SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.60, // Adjust height if needed
                        child: RawScrollbar(
                          thumbVisibility: true,
                          trackVisibility: true,
                          thickness: 10,
                          radius: const Radius.circular(10),
                          thumbColor: Constants().themeColor,
                          controller:
                              _domainScrollController, // ✅ use dedicated controller
                          child: ListView.builder(
                            controller:
                                _domainScrollController, // ✅ use dedicated controller
                            itemCount: _domains.length,
                            itemBuilder: (context, index) {
                              final domain = _domains[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: _selectedDomains.contains(domain),
                                      onChanged: (value) {
                                        setState(() {
                                          if (value == true) {
                                            _selectedDomains.add(domain);
                                          } else {
                                            _selectedDomains.remove(domain);
                                          }
                                        });
                                      },
                                      activeColor: Constants().themeColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            domain,
                                            style: const TextStyle(
                                              fontFamily: 'satoshi',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                            ),
                                          ),
                                          if (domain ==
                                              'Clinical Treatment/Telehealth')
                                            Text(
                                              'Primary Domain',
                                              style: TextStyle(
                                                color: Constants().themeColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),*/
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4C6FEE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Click to Start →',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Satoshi',
                        color: Colors.white,
                      ),
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
}*/


// class Step1Screen extends StatefulWidget {
//   const Step1Screen({Key? key}) : super(key: key);

//   @override
//   State<Step1Screen> createState() => _Step1ScreenState();
// }

// class _Step1ScreenState extends State<Step1Screen> {
//   final ScrollController _scrollController = ScrollController();
//   bool _isVeteran = true;

//   // ✅ Unchecked by default
//   List<String> _selectedDomains = [];

//   final List<String> _domains = [
//     'Housing',
//     'Family/Reuniting, Family/Aftercare',
//     'Employment',
//     'Education',
//     'Clinical Treatment/Telehealth',
//     'Allies, Advocates and Support',
//     'Housing',
//     'Family/Reuniting, Family/Aftercare',
//     'Employment',
//     'Education',
//     'Clinical Treatment/Telehealth',
//     'Allies, Advocates and Support',
//     'Housing',
//     'Family/Reuniting, Family/Aftercare',
//     'Employment',
//     'Education',
//     'Clinical Treatment/Telehealth',
//     'Allies, Advocates and Support',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //  backgroundColor: const Color(0xFFF3F4FD),
//       /*  appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         leading: const BackButton(color: Colors.black),
//         title: const Text(
//           'Recovery Wellness Plan',
//           style: TextStyle(color: Colors.black),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(4),
//           child: Column(
//             children: [
              // const Text(
              //   'Question 1/13',
              //   style: TextStyle(color: Colors.black54),
              // ),
              // const SizedBox(height: 4),
              // LinearProgressIndicator(
              //   value: 1 / 13,
              //   valueColor: AlwaysStoppedAnimation(Constants().themeColor),
              //   backgroundColor: Colors.grey.shade300,
              // ),
//             ],
//           ),
//         ),
//       ),*/
//       body: DecoratedBox(
//         decoration: boxDecoration(),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 70),
//               Row(
//                 children: [
//                   const SizedBox(width: 10),
//                   InkWell(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: CircleAvatar(
//                       radius: 19,
//                       backgroundColor: Colors.white,
//                       child: Icon(
//                         Icons.arrow_back,
//                         color: Colors.black,
//                         size: 19,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 17,
//                   ),
//                   const Text(
//                     'Recovery Wellness Plan',
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: Colors.black87,
//                       fontWeight: FontWeight.w700,
//                       fontFamily: 'Satoshi',
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: RawScrollbar(
//                   trackColor: Constants().themeColor,
//                   controller: _scrollController,
//                   thumbColor: Constants().themeColor,
//                   radius: const Radius.circular(10),
//                   thickness: 10, // ✅ Increased thickness
//                   thumbVisibility: true,
//                   interactive: true,
//                   child: SingleChildScrollView(
//                     controller: _scrollController,
//                     child: Container(
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(18),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             height: 48,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(30),
//                                 color: Constants().themeColor),
//                             width: MediaQuery.of(context).size.width,
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.only(top: 12.0, left: 25),
//                               child: Text(
//                                 'Domains',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: 'satoshi'),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 14.0),
//                             child: const Text(
//                               'Please Select a Domain',
//                               style: TextStyle(
//                                   fontSize: 22,
//                                   fontFamily: 'satoshi',
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 14.0),
//                             child: const Text(
//                               '(check all that apply)',
//                               style: TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w700,
//                                   fontFamily: 'satoshi'),
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 14.0),
//                             child: const Text(
//                               'Are you a veteran?',
//                               style: TextStyle(
//                                   fontSize: 20,
//                                   fontFamily: 'satoshi',
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Radio<bool>(
//                                 value: true,
//                                 groupValue: _isVeteran,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _isVeteran = value!;
//                                   });
//                                 },
//                                 activeColor: Constants().themeColor,
//                               ),
//                               const Text('Yes'),
//                               Radio<bool>(
//                                 value: false,
//                                 groupValue: _isVeteran,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _isVeteran = value!;
//                                   });
//                                 },
//                                 activeColor: Constants().themeColor,
//                               ),
//                               const Text('No'),
//                             ],
//                           ),
//                           const SizedBox(height: 4),
//                           ..._domains.map((domain) {
//                             return Scrollbar(
//                               thumbVisibility: true,
//                               trackVisibility: true,
//                               thickness: 10,
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 4.0),
//                                 child: Row(
//                                   children: [
//                                     Checkbox(
//                                       value: _selectedDomains.contains(domain),
//                                       onChanged: (value) {
//                                         setState(() {
//                                           if (value == true) {
//                                             _selectedDomains.add(domain);
//                                           } else {
//                                             _selectedDomains.remove(domain);
//                                           }
//                                         });
//                                       },
//                                       activeColor: Constants().themeColor,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(4),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             domain,
//                                             style: TextStyle(
//                                                 fontFamily: 'satoshi',
//                                                 fontWeight: FontWeight.w700,
//                                                 fontSize: 18),
//                                           ),
//                                           if (domain ==
//                                               'Clinical Treatment/Telehealth')
//                                             Text(
//                                               'Primary Domain',
//                                               style: TextStyle(
//                                                 color: Constants().themeColor,
//                                                 fontSize: 12,
//                                               ),
//                                             ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }).toList(),

//                           const SizedBox(height: 20),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 55,
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF4C6FEE),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                     child: const Text(
//                       'Click to Start →',
//                       style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'Satoshi',
//                         color: Colors.white,
//                       ),
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


/*class Step1Screen extends StatefulWidget {
  const Step1Screen({Key? key}) : super(key: key);

  @override
  State<Step1Screen> createState() => _Step1ScreenState();
}

class _Step1ScreenState extends State<Step1Screen> {
  final ScrollController _scrollController = ScrollController();
  bool _isVeteran = true;

  final List<String> _domains = [
    'Housing',
    'Family/Reuniting, Family/Aftercare',
    'Employment',
    'Education',
    'Clinical Treatment/Telehealth',
    'Allies, Advocates and Support',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4FD),
      /* appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Recovery Wellness Plan',
          style: TextStyle(color: Colors.black),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Column(
            children: [
              const Text(
                'Question 1/13',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: 1 / 13,
                valueColor: AlwaysStoppedAnimation(Constants().themeColor),
                backgroundColor: Colors.grey.shade300,
              ),
            ],
          ),
        ),
      ),*/
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RawScrollbar(
          controller: _scrollController,
          thumbColor: Constants().themeColor,
          radius: const Radius.circular(10),
          thickness: 8,
          thumbVisibility: true,
          interactive: true,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Question 1/13',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: 1 / 13,
                    valueColor: AlwaysStoppedAnimation(Constants().themeColor),
                    backgroundColor: Colors.grey.shade300,
                  ),
                  Text(
                    'Domains',
                    style: TextStyle(
                      color: Constants().themeColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please Select a Domain',
                    style: TextStyle(fontSize: 16),
                  ),
                  const Text(
                    '(check all that apply)',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  const Text('Are you a veteran?',
                      style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: _isVeteran,
                        onChanged: (value) {
                          setState(() {
                            _isVeteran = value!;
                          });
                        },
                        activeColor: Constants().themeColor,
                      ),
                      const Text('Yes'),
                      Radio<bool>(
                        value: false,
                        groupValue: _isVeteran,
                        onChanged: (value) {
                          setState(() {
                            _isVeteran = value!;
                          });
                        },
                        activeColor: Constants().themeColor,
                      ),
                      const Text('No'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ..._domains.map((domain) {
                    return CheckboxListTile(
                      title: Row(
                        children: [
                          Expanded(child: Text(domain)),
                          if (domain == 'Clinical Treatment/Telehealth')
                            Text(
                              'Primary Domain',
                              style: TextStyle(
                                color: Constants().themeColor,
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                      value: true, // Static checked
                      onChanged: null, // Non-interactive
                      activeColor: Constants().themeColor,
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Constants().themeColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          onPressed: () {
            // Handle next
          },
          child: const Text(
            'Click to Start →',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}*/


/*class Step1Screen extends StatefulWidget {
  const Step1Screen({Key? key}) : super(key: key);

  @override
  State<Step1Screen> createState() => _Step1ScreenState();
}

class _Step1ScreenState extends State<Step1Screen> {
  final ScrollController _scrollController = ScrollController();
  bool _isVeteran = true;
  List<String> _selectedDomains = ['Housing', 'Clinical Treatment/Telehealth'];

  final List<String> _domains = [
    'Housing',
    'Family/Reuniting, Family/Aftercare',
    'Employment',
    'Education',
    'Clinical Treatment/Telehealth',
    'Allies, Advocates and Support',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4FD),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Recovery Wellness Plan',
          style: TextStyle(color: Colors.black),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Column(
            children: [
              const Text(
                'Question 1/13',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: 1 / 13,
                valueColor: AlwaysStoppedAnimation(Constants().themeColor),
                backgroundColor: Colors.grey.shade300,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RawScrollbar(
          controller: _scrollController,
          thumbColor: Constants().themeColor,
          radius: const Radius.circular(10),
          thickness: 8,
          thumbVisibility: true,
          interactive: true,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Domains',
                    style: TextStyle(
                      color: Constants().themeColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please Select a Domain',
                    style: TextStyle(fontSize: 16),
                  ),
                  const Text(
                    '(check all that apply)',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  const Text('Are you a veteran?',
                      style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: _isVeteran,
                        onChanged: (value) {
                          setState(() {
                            _isVeteran = value!;
                          });
                        },
                        activeColor: Constants().themeColor,
                      ),
                      const Text('Yes'),
                      Radio<bool>(
                        value: false,
                        groupValue: _isVeteran,
                        onChanged: (value) {
                          setState(() {
                            _isVeteran = value!;
                          });
                        },
                        activeColor: Constants().themeColor,
                      ),
                      const Text('No'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ..._domains.map((domain) {
                    return CheckboxListTile(
                      title: Row(
                        children: [
                          //   Expanded(child: Text(domain)),
                          if (domain == 'Clinical Treatment/Telehealth') ...[
                            // const SizedBox(width: 8),
                            // Text(
                            //   'Primary Domain',
                            //   style: TextStyle(
                            //     color: Constants().themeColor,
                            //     fontSize: 12,
                            //   ),
                            // ),
                          ],
                          Expanded(child: Text(domain)),
                        ],
                      ),
                      value: _selectedDomains.contains(domain),
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            _selectedDomains.add(domain);
                          } else {
                            _selectedDomains.remove(domain);
                          }
                        });
                      },
                      activeColor: Constants().themeColor,
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Constants().themeColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          ),
          onPressed: () {
            // Handle next
          },
          child: const Text(
            'Click to Start →',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}*/


// import 'package:flutter/material.dart';

// import '../../Constants/constants.dart';

// class Step1Screen extends StatefulWidget {
//   const Step1Screen({super.key});

//   @override
//   State<Step1Screen> createState() => _Step1ScreenState();
// }

// class _Step1ScreenState extends State<Step1Screen> {
//   bool? isVeteran = true;

//   final List<String> domains = [
//     'Housing',
//     'Family/Reuniting, Family/Aftercare',
//     'Employment',
//     'Education',
//     'Clinical Treatment/Telehealth',
//     'Allies, Advocates and Support',
//     'Recovery Support Services',
//     'Faith and Spirituality',
//     'Recovery Community',
//     'Legal/Criminal Justice',
//   ];

//   final List<String> selectedDomains = [
//     'Housing',
//     'Clinical Treatment/Telehealth'
//   ];

//   void toggleDomain(String domain) {
//     setState(() {
//       if (selectedDomains.contains(domain)) {
//         selectedDomains.remove(domain);
//       } else {
//         selectedDomains.add(domain);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       extendBodyBehindAppBar: true,
//       body: DecoratedBox(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFFE8ECF9), Color(0xFFF7F8FC)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
//                 child: Row(
//                   children: [
//                     Icon(Icons.arrow_back, color: Colors.black),
//                     SizedBox(width: 12),
//                     Text(
//                       "Recovery Wellness Plan",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'Satoshi',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Question 1/13",
//                     style: TextStyle(
//                       fontSize: 13,
//                       fontFamily: 'Satoshi',
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: LinearProgressIndicator(
//                   value: 1 / 13,
//                   backgroundColor: Color(0xFFE0E0E0),
//                   color: Color(0xFF4C6FEE),
//                   minHeight: 4,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: ScrollbarTheme(
//                     data: ScrollbarThemeData(
//                       thumbColor:
//                           MaterialStateProperty.all(Color(0xFF4C6FEE)), // Blue
//                       thickness:
//                           MaterialStateProperty.all(10), // Thicker scrollbar
//                       radius: const Radius.circular(10),
//                       trackColor: MaterialStateProperty.all(Colors.transparent),
//                       trackBorderColor:
//                           MaterialStateProperty.all(Colors.transparent),
//                     ),
//                     child: Scrollbar(
//                       thumbVisibility: true, // Always show
//                       interactive: true,
//                       child: SingleChildScrollView(
//                         physics: const BouncingScrollPhysics(),
//                         child: Container(
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(18),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Domains',
//                                 style: TextStyle(
//                                   fontSize: 17,
//                                   fontWeight: FontWeight.w600,
//                                   fontFamily: 'Satoshi',
//                                   color: Color(0xFF4C6FEE),
//                                 ),
//                               ),
//                               const SizedBox(height: 12),
//                               const Text(
//                                 "Please Select a Domain",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w700,
//                                   fontFamily: 'Satoshi',
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               const Text(
//                                 "(check all that apply)",
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   fontFamily: 'Satoshi',
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               const Text(
//                                 "Are you a veteran?",
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               Row(
//                                 children: [
//                                   Radio<bool>(
//                                     value: true,
//                                     groupValue: isVeteran,
//                                     onChanged: (val) {
//                                       setState(() {
//                                         isVeteran = val;
//                                       });
//                                     },
//                                     activeColor: Color(0xFF4C6FEE),
//                                   ),
//                                   const Text(
//                                     "Yes",
//                                     style: TextStyle(
//                                       fontFamily: 'Satoshi',
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                   Radio<bool>(
//                                     value: false,
//                                     groupValue: isVeteran,
//                                     onChanged: (val) {
//                                       setState(() {
//                                         isVeteran = val;
//                                       });
//                                     },
//                                     activeColor: Color(0xFF4C6FEE),
//                                   ),
//                                   const Text(
//                                     "No",
//                                     style: TextStyle(
//                                       fontFamily: 'Satoshi',
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 12),
//                               ...domains.map((domain) {
//                                 final isSelected =
//                                     selectedDomains.contains(domain);
//                                 return Padding(
//                                   padding: const EdgeInsets.only(bottom: 6),
//                                   child: CheckboxListTile(
//                                     value: isSelected,
//                                     onChanged: (_) => toggleDomain(domain),
//                                     title: RichText(
//                                       text: TextSpan(
//                                         text: domain,
//                                         style: const TextStyle(
//                                           fontSize: 16,
//                                           color: Colors.black,
//                                           fontFamily: 'Satoshi',
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                         children: [
//                                           if (domain ==
//                                               "Clinical Treatment/Telehealth")
//                                             const TextSpan(
//                                               text: '  Primary Domain',
//                                               style: TextStyle(
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: Colors.blue,
//                                                 fontFamily: 'Satoshi',
//                                               ),
//                                             )
//                                         ],
//                                       ),
//                                     ),
//                                     activeColor: const Color(0xFF4C6FEE),
//                                     controlAffinity:
//                                         ListTileControlAffinity.leading,
//                                     contentPadding: EdgeInsets.zero,
//                                   ),
//                                 );
//                               }).toList(),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 55,
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF4C6FEE),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                     child: const Text(
//                       'Click to Start →',
//                       style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'Satoshi',
//                         color: Colors.white,
//                       ),
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


// class Step1Screen extends StatefulWidget {
//   const Step1Screen({super.key});

//   @override
//   State<Step1Screen> createState() => _Step1ScreenState();
// }

// class _Step1ScreenState extends State<Step1Screen> {
//   bool? isVeteran = true;

//   final List<String> domains = [
//     'Housing',
//     'Family/Reuniting, Family/Aftercare',
//     'Employment',
//     'Education',
//     'Clinical Treatment/Telehealth',
//     'Allies, Advocates and Support',
//     'Recovery Support Services',
//     'Faith and Spirituality',
//     'Recovery Community',
//     'Legal/Criminal Justice',
//   ];

//   final List<String> selectedDomains = [
//     'Housing',
//     'Clinical Treatment/Telehealth'
//   ];

//   void toggleDomain(String domain) {
//     setState(() {
//       if (selectedDomains.contains(domain)) {
//         selectedDomains.remove(domain);
//       } else {
//         selectedDomains.add(domain);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       extendBodyBehindAppBar: true,
//       body: DecoratedBox(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFFE8ECF9), Color(0xFFF7F8FC)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
//                 child: Row(
//                   children: [
//                     Icon(Icons.arrow_back, color: Colors.black),
//                     SizedBox(width: 12),
//                     Text(
//                       "Recovery Wellness Plan",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'Satoshi',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Question 1/13",
//                     style: TextStyle(
//                       fontSize: 13,
//                       fontFamily: 'Satoshi',
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: LinearProgressIndicator(
//                   value: 1 / 13,
//                   backgroundColor: Color(0xFFE0E0E0),
//                   color: Color(0xFF4C6FEE),
//                   minHeight: 4,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Expanded(
//                 child: Padding(
//                   padding:  EdgeInsets.symmetric(horizontal: 16),
//                   child: ScrollbarTheme(
//                     data: ScrollbarThemeData(
//                       trackColor: Constants()
//                       .themeColor,

//                       thumbColor:
//                           MaterialStateProperty.all(Color(0xFF4C6FEE)), // Blue
//                       thickness: MaterialStateProperty.all(
//                           5), // Optional: scrollbar width
//                       radius: Radius.circular(6), // Rounded edges
//                     ),
//                     // data: ScrollbarThemeData(
//                     //   thumbColor: MaterialStateProperty.all(Colors.blue),
//                     //   //  thumbColor: MaterialStateProperty.all(Colors.red),
//                     //   thickness: MaterialStateProperty.all(9),
//                     //   radius: Radius.circular(6),
//                     //   trackColor: MaterialStateProperty.all(Colors.blue),
//                     //   trackBorderColor: MaterialStateProperty.all(Colors.blue),
//                     // ),
//                     child: Scrollbar(
//                       thumbVisibility: true,
//                       child: SingleChildScrollView(
//                         physics: BouncingScrollPhysics(),
//                         child: Container(
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(18),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Domains',
//                                 style: TextStyle(
//                                   fontSize: 17,
//                                   fontWeight: FontWeight.w600,
//                                   fontFamily: 'Satoshi',
//                                   color: Color(0xFF4C6FEE),
//                                 ),
//                               ),
//                               const SizedBox(height: 12),
//                               const Text(
//                                 "Please Select a Domain",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w700,
//                                   fontFamily: 'Satoshi',
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               const Text(
//                                 "(check all that apply)",
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   fontFamily: 'Satoshi',
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               const Text(
//                                 "Are you a veteran?",
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               Row(
//                                 children: [
//                                   Radio<bool>(
//                                     value: true,
//                                     groupValue: isVeteran,
//                                     onChanged: (val) {
//                                       setState(() {
//                                         isVeteran = val;
//                                       });
//                                     },
//                                     activeColor: Color(0xFF4C6FEE),
//                                   ),
//                                   const Text(
//                                     "Yes",
//                                     style: TextStyle(
//                                       fontFamily: 'Satoshi',
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                   Radio<bool>(
//                                     value: false,
//                                     groupValue: isVeteran,
//                                     onChanged: (val) {
//                                       setState(() {
//                                         isVeteran = val;
//                                       });
//                                     },
//                                     activeColor: Color(0xFF4C6FEE),
//                                   ),
//                                   const Text(
//                                     "No",
//                                     style: TextStyle(
//                                       fontFamily: 'Satoshi',
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 12),
//                               ...domains.map((domain) {
//                                 final isSelected =
//                                     selectedDomains.contains(domain);
//                                 return Padding(
//                                   padding: const EdgeInsets.only(bottom: 6),
//                                   child: CheckboxListTile(
//                                     value: isSelected,
//                                     onChanged: (_) => toggleDomain(domain),
//                                     title: RichText(
//                                       text: TextSpan(
//                                         text: domain,
//                                         style: const TextStyle(
//                                           fontSize: 16,
//                                           color: Colors.black,
//                                           fontFamily: 'Satoshi',
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                         children: [
//                                           if (domain ==
//                                               "Clinical Treatment/Telehealth")
//                                             const TextSpan(
//                                               text: '  Primary Domain',
//                                               style: TextStyle(
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: Colors.blue,
//                                                 fontFamily: 'Satoshi',
//                                               ),
//                                             )
//                                         ],
//                                       ),
//                                     ),
//                                     activeColor: Constants().themeColor,
//                                     controlAffinity:
//                                         ListTileControlAffinity.leading,
//                                     contentPadding: EdgeInsets.zero,
//                                   ),
//                                 );
//                               }).toList(),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 55,
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF4C6FEE),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                     child: const Text(
//                       'Click to Start →',
//                       style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'Satoshi',
//                         color: Colors.white,
//                       ),
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


// class Step1Screen extends StatefulWidget {
//   const Step1Screen({super.key});

//   @override
//   State<Step1Screen> createState() => _Step1ScreenState();
// }

// class _Step1ScreenState extends State<Step1Screen> {
//   bool? isVeteran = true;

//   final List<String> domains = [
//     'Housing',
//     'Family/Reuniting, Family/Aftercare',
//     'Employment',
//     'Education',
//     'Clinical Treatment/Telehealth',
//     'Allies, Advocates and Support',
//     'Recovery Support Services',
//     'Faith and Spirituality',
//     'Recovery Community',
//     'Legal/Criminal Justice',
//   ];

//   final List<String> selectedDomains = [
//     'Housing',
//     'Clinical Treatment/Telehealth'
//   ];

//   void toggleDomain(String domain) {
//     setState(() {
//       if (selectedDomains.contains(domain)) {
//         selectedDomains.remove(domain);
//       } else {
//         selectedDomains.add(domain);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF2F6FF),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Top Navigation
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
//               child: Row(
//                 children: const [
//                   Icon(Icons.arrow_back, color: Colors.black),
//                   SizedBox(width: 12),
//                   Text(
//                     "Recovery Wellness Plan",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Satoshi',
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Progress
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text("Question 1/13",
//                       style:
//                           TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
//                   SizedBox(height: 8),
//                   ClipRRect(
//                     borderRadius: BorderRadius.all(Radius.circular(4)),
//                     child: LinearProgressIndicator(
//                       value: 1 / 13,
//                       backgroundColor: Color(0xFFE0E0E0),
//                       color: Color(0xFF4C6FEE),
//                       minHeight: 4,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 16),

//             // Card Container
//             Expanded(
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(18),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 8,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text("Domains",
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF4C6FEE))),
//                       const SizedBox(height: 12),
//                       const Text("Please Select a Domain",
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w700)),
//                       const SizedBox(height: 4),
//                       const Text("(check all that apply)",
//                           style: TextStyle(color: Colors.grey, fontSize: 12)),
//                       const SizedBox(height: 16),
//                       const Text("Are you a veteran?",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w500, fontSize: 15)),
//                       Row(
//                         children: [
//                           Radio<bool>(
//                             value: true,
//                             groupValue: isVeteran,
//                             onChanged: (val) => setState(() => isVeteran = val),
//                             activeColor: const Color(0xFF4C6FEE),
//                           ),
//                           const Text("Yes", style: TextStyle(fontSize: 15)),
//                           Radio<bool>(
//                             value: false,
//                             groupValue: isVeteran,
//                             onChanged: (val) => setState(() => isVeteran = val),
//                             activeColor: const Color(0xFF4C6FEE),
//                           ),
//                           const Text("No", style: TextStyle(fontSize: 15)),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       // Domains list
//                       ...domains.map((domain) {
//                         final isSelected = selectedDomains.contains(domain);
//                         return Padding(
//                           padding: const EdgeInsets.only(bottom: 8),
//                           child: CheckboxListTile(
//                             value: isSelected,
//                             onChanged: (_) => toggleDomain(domain),
//                             controlAffinity: ListTileControlAffinity.leading,
//                             contentPadding: EdgeInsets.zero,
//                             title: RichText(
//                               text: TextSpan(
//                                 text: domain,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.black,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                                 children: [
//                                   if (domain == "Clinical Treatment/Telehealth")
//                                     const TextSpan(
//                                       text: '  Primary Domain',
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w400,
//                                         color: Colors.blue,
//                                       ),
//                                     )
//                                 ],
//                               ),
//                             ),
//                             activeColor: const Color(0xFF4C6FEE),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                           ),
//                         );
//                       }),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             // Bottom Button
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 55,
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF4C6FEE),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   child: const Text(
//                     'Click to Start →',
//                     style: TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Satoshi',
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


// class Step1Screen extends StatefulWidget {
//   const Step1Screen({super.key});

//   @override
//   State<Step1Screen> createState() => _Step1ScreenState();
// }

// class _Step1ScreenState extends State<Step1Screen> {
//   bool? isVeteran = true;

//   final List<String> domains = [
//     'Housing',
//     'Family/Reuniting, Family/Aftercare',
//     'Employment',
//     'Education',
//     'Clinical Treatment/Telehealth',
//     'Allies, Advocates and Support',
//     'Recovery Support Services',
//     'Faith and Spirituality',
//     'Recovery Community',
//     'Legal/Criminal Justice',
//   ];

//   final List<String> selectedDomains = [
//     'Housing',
//     'Clinical Treatment/Telehealth'
//   ];

//   void toggleDomain(String domain) {
//     setState(() {
//       if (selectedDomains.contains(domain)) {
//         selectedDomains.remove(domain);
//       } else {
//         selectedDomains.add(domain);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       extendBodyBehindAppBar: true,
//       body: DecoratedBox(
//         decoration: boxDecoration(),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 minHeight: MediaQuery.of(context).size.height -
//                     MediaQuery.of(context).padding.vertical,
//               ),
//               child: IntrinsicHeight(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 4.0, vertical: 10.0),
//                   child: Column(
//                     //  mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Row(
//                       //   children: [
//                       //     InkWell(
//                       //       onTap: () {
//                       //         Navigator.pop(context);
//                       //       },
//                       //       child: CircleAvatar(
//                       //         radius: 19,
//                       //         backgroundColor: Colors.white,
//                       //         child: Icon(
//                       //           Icons.arrow_back,
//                       //           color: Colors.black,
//                       //           size: 19,
//                       //         ),
//                       //       ),
//                       //     ),
//                       //     SizedBox(
//                       //       width: 17,
//                       //     ),
//                       //     const Text(
//                       //       'Forget Password',
//                       //       style: TextStyle(
//                       //         fontSize: 24,
//                       //         color: Colors.black87,
//                       //         fontWeight: FontWeight.w700,
//                       //         fontFamily: 'Satoshi',
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                       //  const SizedBox(height: 20),
//                       const Padding(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 16, vertical: 5),
//                         child: Row(
//                           children: [
//                             Icon(Icons.arrow_back, color: Colors.black),
//                             SizedBox(width: 12),
//                             Text(
//                               "Recovery Wellness Plan",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                                 fontFamily: 'Satoshi',
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "Question 1/13",
//                             style: TextStyle(
//                               fontSize: 13,
//                               fontFamily: 'Satoshi',
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const Padding(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                         child: LinearProgressIndicator(
//                           value: 1 / 13,
//                           backgroundColor: Color(0xFFE0E0E0),
//                           color: Color(0xFF4C6FEE),
//                           minHeight: 4,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: Container(
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(18),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Domains',
//                                 style: TextStyle(
//                                   fontSize: 17,
//                                   fontWeight: FontWeight.w600,
//                                   fontFamily: 'Satoshi',
//                                   color: Color(0xFF4C6FEE),
//                                 ),
//                               ),
//                               const SizedBox(height: 12),
//                               const Text(
//                                 "Please Select a Domain",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w700,
//                                   fontFamily: 'Satoshi',
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               const Text(
//                                 "(check all that apply)",
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   fontFamily: 'Satoshi',
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               const Text(
//                                 "Are you a veteran?",
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               Row(
//                                 children: [
//                                   Radio<bool>(
//                                     value: true,
//                                     groupValue: isVeteran,
//                                     onChanged: (val) {
//                                       setState(() {
//                                         isVeteran = val;
//                                       });
//                                     },
//                                     activeColor: Color(0xFF4C6FEE),
//                                   ),
//                                   const Text(
//                                     "Yes",
//                                     style: TextStyle(
//                                       fontFamily: 'Satoshi',
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                   Radio<bool>(
//                                     value: false,
//                                     groupValue: isVeteran,
//                                     onChanged: (val) {
//                                       setState(() {
//                                         isVeteran = val;
//                                       });
//                                     },
//                                     activeColor: Color(0xFF4C6FEE),
//                                   ),
//                                   const Text(
//                                     "No",
//                                     style: TextStyle(
//                                       fontFamily: 'Satoshi',
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 12),
//                               ...domains.map((domain) {
//                                 final isSelected =
//                                     selectedDomains.contains(domain);
//                                 return Padding(
//                                   padding: const EdgeInsets.only(right: 8.0),
//                                   child: CheckboxListTile(
//                                     value: isSelected,
//                                     onChanged: (_) => toggleDomain(domain),
//                                     title: RichText(
//                                       text: TextSpan(
//                                         text: domain,
//                                         style: const TextStyle(
//                                           fontSize: 16,
//                                           color: Colors.black,
//                                           fontFamily: 'Satoshi',
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                         children: [
//                                           if (domain ==
//                                               "Clinical Treatment/Telehealth")
//                                             const TextSpan(
//                                               text: '  Primary Domain',
//                                               style: TextStyle(
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: Colors.blue,
//                                                 fontFamily: 'Satoshi',
//                                               ),
//                                             )
//                                         ],
//                                       ),
//                                     ),
//                                     activeColor: const Color(0xFF4C6FEE),
//                                     controlAffinity:
//                                         ListTileControlAffinity.leading,
//                                   ),
//                                 );
//                               }).toList(),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: SizedBox(
//                           width: double.infinity,
//                           height: 55,
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF4C6FEE),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                             ),
//                             child: const Text(
//                               'Click to Start →',
//                               style: TextStyle(
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.w600,
//                                 fontFamily: 'Satoshi',
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
