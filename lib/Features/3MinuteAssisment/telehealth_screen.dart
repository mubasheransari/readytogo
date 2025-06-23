import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';
import 'package:readytogo/Features/3MinuteAssisment/Step1Screen.dart';
import 'package:readytogo/Features/3MinuteAssisment/widget_recoverywellnessplan.dart';
import 'package:readytogo/widgets/boxDecorationWidget.dart';
import '../../widgets/back_next_button_widget.dart';
import 'clinical_treatment_screen.dart';

class TelehealthScreen extends StatefulWidget {
  const TelehealthScreen({Key? key}) : super(key: key);

  @override
  State<TelehealthScreen> createState() => _TelehealthScreenState();
}

class _TelehealthScreenState extends State<TelehealthScreen> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _domainScrollController = ScrollController();

  List<String> _selectedDomains = [];

  final List<String> _domains = [
    'Virtual Services (Online/Telehealth)',
    'Warm Line Provider (Lifeguard Designation 24/7)',
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
      body: Container(
        decoration: boxDecoration(),
        height: MediaQuery.of(context).size.height,
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
                      TitleHeading3minAssesment(
                        title: 'Telehealth',
                      ),
                      const SizedBox(height: 12),
                      const Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          'Select Categories',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          '(check all that applies)',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'satoshi',
                          ),
                        ),
                      ),
                      Column(
                        children: List.generate(_domains.length, (index) {
                          final domain = _domains[index];
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
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              BackAndNextButton(
                onBackPressed: () {
                  Navigator.of(context).pop();
                },
                onNextPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const Step1Screen()),
                  // );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
