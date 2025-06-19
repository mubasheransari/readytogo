import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';
import 'package:readytogo/Features/3MinuteAssisment/Step1Screen.dart';
import 'package:readytogo/Features/3MinuteAssisment/widget_recoverywellnessplan.dart';
import 'package:readytogo/widgets/boxDecorationWidget.dart';
import '../../widgets/back_next_button_widget.dart';
import 'housing1_assisment_screen.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({Key? key}) : super(key: key);

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
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
                   TitleHeading3minAssesment(title: "Education"),
                      const SizedBox(height: 12),
                      const Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          'Whats your education level?',
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
                          '(choose the highest level acvhieve)',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'satoshi',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RadioListTile<String>(
                        title: const Text(
                          'Less than High School',
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
                          'GED/HS',
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
                          'Some College',
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
                          '2 year degree',
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
                      RadioListTile<String>(
                        activeColor: Constants().themeColor,
                        title: const Text(
                          '4 year degree',
                          style: TextStyle(
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        value: 'Option 5',
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
                          'Masters or PHD',
                          style: TextStyle(
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        value: 'Option 6',
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
                          'Are you currently in rolled in school or job training program?',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      RadioListTile<String>(
                        activeColor: Constants().themeColor,
                        title: const Text(
                          'Full Time',
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
                          'Part Time',
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
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
               BackAndNextButton(onBackPressed: () {
                Navigator.of(context).pop();
              }, onNextPressed: () {
                Navigator.of(context).pop();
              }),
              SizedBox(height: MediaQuery.of(context).size.height),
            ],
          ),
        ),
      ),
    );
  }
}
