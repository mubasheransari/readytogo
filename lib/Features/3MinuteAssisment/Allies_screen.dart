import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';
import 'package:readytogo/Features/3MinuteAssisment/Step1Screen.dart';
import 'package:readytogo/Features/3MinuteAssisment/widget_recoverywellnessplan.dart';
import 'package:readytogo/widgets/back_next_button_widget.dart';
import 'package:readytogo/widgets/boxDecorationWidget.dart';
import 'advocates_screen.dart';
import 'housing1_assisment_screen.dart';

class AlliesScreen extends StatefulWidget {
  const AlliesScreen({Key? key}) : super(key: key);

  @override
  State<AlliesScreen> createState() => _AlliesScreenState();
}

class _AlliesScreenState extends State<AlliesScreen> {
  List<String> _selectedAllias = [];

  final List<String> _allias = [
    'Local',
    'State',
    'National',
    'Virtual',
    '"For Now" Jobs',
    'Career Training (Academic)',
    'Housing Providers',
    'Real State Investors/Operators',
    'Non Profit (501c3)',
    'Grant Providers / Writers',
    'Research Community',
    'Faith Based and Spiritual Care',
    'Evidence Based',
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
                              TitleHeading3minAssesment(title: "Allies"),
                              const SizedBox(height: 12),
                              const Padding(
                                padding: EdgeInsets.only(left: 14.0),
                                child: Text(
                                  'Any people interested in or offer Support/Services to the Recovery Community.',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'satoshi',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Column(
                                children:
                                    List.generate(_allias.length, (index) {
                                  final domain = _allias[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value:
                                              _selectedAllias.contains(domain),
                                          onChanged: (value) {
                                            setState(() {
                                              if (value == true) {
                                                _selectedAllias.add(domain);
                                              } else {
                                                _selectedAllias.remove(domain);
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
                                                    color:
                                                        Constants().themeColor,
                                                    fontSize: 12,
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
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      BackAndNextButton(
                        onBackPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Step1Screen()),
                          );
                        },
                        onNextPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdvocateScreen()),
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
