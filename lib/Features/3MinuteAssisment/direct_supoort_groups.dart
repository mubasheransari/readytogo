import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';
import 'package:readytogo/widgets/back_next_button_widget.dart';
import 'package:readytogo/widgets/boxDecorationWidget.dart';

import 'Step1Screen.dart';

class DirectSupportGroupsScreen extends StatefulWidget {
  const DirectSupportGroupsScreen({Key? key}) : super(key: key);

  @override
  State<DirectSupportGroupsScreen> createState() =>
      _DirectSupportGroupsScreenState();
}

class _DirectSupportGroupsScreenState extends State<DirectSupportGroupsScreen> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _domainScrollController = ScrollController();
  bool _isVeteran = true;

  List<String> _selectedDomains = [];

  final List<String> _advocates = [
    'Local',
    'State',
    'National',
    'Virtual',
    'Veterans',
    'Social Events & Calendar',
    'Veterans Only',
    'My Coummunity',
    '12 step',
    'Male Only',
    'Peer Support',
    'Spiritual Support',
    'Female Only',
    'Family',
    'Friends'
  ];

  String _selectedOption = '';
  String _accommodation = '';

  final List<String> _options = [
    "Option 1",
    "Option 2",
    "Option 3",
    "Option 4",
    "Option 5",
    "Option 6",
    "Option 7",
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
                      'Question 12/13',
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
                      value: 12 / 13,
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
                              'Direct Support Group',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'satoshi',
                              ),
                            )),
                      ),
                      const SizedBox(height: 12),
                      const Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          'Check all that applies',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: List.generate(_advocates.length, (index) {
                          final domain = _advocates[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              BackAndNextButton(onBackPressed: () {
                Navigator.pop(context);
              }, onNextPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Step1Screen()));
              }),
              SizedBox(height: MediaQuery.of(context).size.height),
            ],
          ),
        ),
      ),
    );
  }
}
