import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';
import 'package:readytogo/Features/3MinuteAssisment/Step1Screen.dart';
import 'package:readytogo/Features/3MinuteAssisment/widget_recoverywellnessplan.dart';
import 'package:readytogo/widgets/boxDecorationWidget.dart';
import '../../widgets/back_next_button_widget.dart';
import 'housing1_assisment_screen.dart';

class Housing2AssesmentScreen extends StatefulWidget {
  const Housing2AssesmentScreen({Key? key}) : super(key: key);

  @override
  State<Housing2AssesmentScreen> createState() =>
      _Housing2AssesmentScreenState();
}

class _Housing2AssesmentScreenState extends State<Housing2AssesmentScreen> {
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
                            'Housing - 2',
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
                          'Location Preference',
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
                      RadioListTile<String>(
                        title: const Text(
                          'Metropolitan',
                          style: TextStyle(
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        value: 'Option 1',
                        activeColor: Constants().themeColor,
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        activeColor: Constants().themeColor,
                        title: const Text(
                          'Suburban',
                          style: TextStyle(
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        value: 'Option 2',
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        activeColor: Constants().themeColor,
                        title: const Text(
                          'Rural',
                          style: TextStyle(
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        value: 'Option 3',
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        activeColor: Constants().themeColor,
                        title: const Text(
                          'Other',
                          style: TextStyle(
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        value: 'Option 4',
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          'Accommodation',
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
                          '(Select one)',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'satoshi',
                          ),
                        ),
                      ),
                      RadioListTile<String>(
                        activeColor: Constants().themeColor,
                        title: const Text(
                          'Live Independently',
                          style: TextStyle(
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        value: 'Option 4',
                        groupValue: _accommodation,
                        onChanged: (value) {
                          setState(() {
                            _accommodation = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        activeColor: Constants().themeColor,
                        title: const Text(
                          'Live with family',
                          style: TextStyle(
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        value: 'Option 5',
                        groupValue: _accommodation,
                        onChanged: (value) {
                          setState(() {
                            _accommodation = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        activeColor: Constants().themeColor,
                        title: const Text(
                          'Live with friends',
                          style: TextStyle(
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        value: 'Option 6',
                        groupValue: _accommodation,
                        onChanged: (value) {
                          setState(() {
                            _accommodation = value!;
                          });
                        },
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
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => Step1Screen()));
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height),
            ],
          ),
        ),
      ),
    );
  }
}
