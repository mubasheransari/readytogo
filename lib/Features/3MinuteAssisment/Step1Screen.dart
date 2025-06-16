import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';
import 'package:readytogo/widgets/boxDecorationWidget.dart';

import 'family_reuniting_family_aftercare_screen.dart';
import 'housing1_assisment_screen.dart';

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
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  margin: const EdgeInsets.only(top: 16),
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.48,
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
                              print('print ${domain}');

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: _selectedDomains.contains(domain),
                                      onChanged: (value) {
                                        //  print(_selectedDomains[0]);
                                        setState(() {
                                          if (value == true) {
                                            _selectedDomains.add(domain);
                                          } else {
                                            _selectedDomains.remove(domain);
                                          }
                                        });

                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          if (domain == "Housing" &&
                                              value == true) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Housing1AssesmentScreen(),
                                              ),
                                            );
                                          } else if (domain ==
                                                  "Family/Reuniting, Family/Aftercare" &&
                                              value == true) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FamilyReunitingFamilyAftercareScreen(),
                                              ),
                                            );
                                          }
                                        });
                                      },

                                      // onChanged: (value) {
                                      //   print(
                                      //       "VALUE NEW check ${_selectedDomains.contains("Housing")}");
                                      //   if (_selectedDomains
                                      //       .contains("Housing")) {
                                      //     Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             Housing1AssesmentScreen(),
                                      //       ),
                                      //     );
                                      //   }
                                      //   setState(() {
                                      //     if (value == true) {
                                      //       _selectedDomains.add(domain);
                                      //     } else {
                                      //       _selectedDomains.remove(domain);
                                      //     }
                                      //   });
                                      // },
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
              /* Padding(
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
              ),*/
              SizedBox(height: MediaQuery.of(context).size.height),
            ],
          ),
        ),
      ),
    );
  }
}
