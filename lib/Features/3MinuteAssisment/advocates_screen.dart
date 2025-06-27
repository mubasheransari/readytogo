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
  List<String> _selectedAdvocates = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: DecoratedBox(
                  decoration: boxDecoration(),
                  child: Column(
                    children: [
                      const SizedBox(height: 76),
                      BackHeader(
                        onTap: (context) {
                          Navigator.pop(context);
                        },
                        questionNumber: 5,
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
                              const SizedBox(height: 5),
                              Column(
                                children:
                                    List.generate(_advocates.length, (index) {
                                  final domain = _advocates[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: _selectedAdvocates
                                              .contains(domain),
                                          onChanged: (value) {
                                            setState(() {
                                              if (value == true) {
                                                _selectedAdvocates.add(domain);
                                              } else {
                                                _selectedAdvocates
                                                    .remove(domain);
                                              }
                                            });
                                          },
                                          activeColor: Constants().themeColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            domain,
                                            style: const TextStyle(
                                              fontFamily: 'satoshi',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                            ),
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
                      BackAndNextButton(
                        onBackPressed: () {
                          Navigator.pop(context);
                        },
                        onNextPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DirectSupportGroupsScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
