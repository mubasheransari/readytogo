import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';
import 'package:readytogo/Features/3MinuteAssisment/widget_recoverywellnessplan.dart';
import 'package:readytogo/widgets/back_next_button_widget.dart';
import 'package:readytogo/widgets/boxDecorationWidget.dart';

import 'direct_supoort_groups.dart';

class AdvocateScreen extends StatefulWidget {
  const AdvocateScreen({Key? key}) : super(key: key);

  @override
  State<AdvocateScreen> createState() => _AdvocateScreenState();
}

class _AdvocateScreenState extends State<AdvocateScreen> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _domainScrollController = ScrollController();
  bool _isVeteran = true;

  List<String> _selectedDomains = [];

  final List<String> _advocates = [
    'Local',
    'State',
    'National',
    'Virtual',
    'Legal Advocates',
    'Civil Rights',
    'Criminal Justice',
    'CPS',
    'Legal Assistance',
    'EBOA (Evidence Based Outcomes Advocate)',
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
              BackHeader(
                onTap: (context) {
                  Navigator.pop(context);
                },
                questionNumber: 2,
                totalQuestions: 13,
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
                      TitleHeading3minAssesment(title: "Advocates"),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DirectSupportGroupsScreen()));
              }),
              SizedBox(height: MediaQuery.of(context).size.height),
            ],
          ),
        ),
      ),
    );
  }
}
