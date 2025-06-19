import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';
import 'package:readytogo/Features/3MinuteAssisment/Step1Screen.dart';
import 'package:readytogo/Features/3MinuteAssisment/widget_recoverywellnessplan.dart';
import 'package:readytogo/widgets/back_next_button_widget.dart';
import 'package:readytogo/widgets/boxDecorationWidget.dart';

import 'direct_supoort_groups.dart';

class RecoverySupportServicesScreen extends StatefulWidget {
  const RecoverySupportServicesScreen({Key? key}) : super(key: key);

  @override
  State<RecoverySupportServicesScreen> createState() =>
      _RecoverySupportServicesScreenState();
}

class _RecoverySupportServicesScreenState
    extends State<RecoverySupportServicesScreen> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _domainScrollController = ScrollController();
  bool _isVeteran = true;

  List<String> _selectedDomains = [];

  final List<String> _typeOfPayment = [
    'Monthly Payment',
    'Scholarships',
    'Sliding Fees Scale',
  ];

  final List<String> _paymentsOptions = [
    'Private Insurance',
    'Private/Self Pay',
    'Medicare',
    'Medicaid',
    'Military',
    'State Funded'
  ];

  String _selectedOption = '';
  String _accommodation = '';

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
                        TitleHeading3minAssesment(
                        title: 'Recovery Support Services',
                      ),
          
                    
                      const SizedBox(height: 12),
                      const Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          'Type of Payment Assistance Available',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          '(check all that applies)',
                          style: TextStyle(
                            color: Constants().greyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'satoshi',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: List.generate(_typeOfPayment.length, (index) {
                          final domain = _typeOfPayment[index];
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
                      const Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          'Payments Options',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          '(check all that applies)',
                          style: TextStyle(
                            color: Constants().greyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'satoshi',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        children:
                            List.generate(_paymentsOptions.length, (index) {
                          final domain = _paymentsOptions[index];
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
