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
  String _educationLevel = '';
  String _trainingProgram = '';

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
                        questionNumber: 4,
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
                                  'What\'s your education level?',
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
                                  '(choose the highest level achieved)',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'satoshi',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              ...[
                                'Less than High School',
                                'GED/HS',
                                'Some College',
                                '2 year degree',
                                '4 year degree',
                                'Masters or PHD',
                              ].asMap().entries.map((entry) {
                                final index = entry.key + 1;
                                final text = entry.value;
                                return RadioListTile<String>(
                                  title: Text(
                                    text,
                                    style: const TextStyle(
                                      fontFamily: 'satoshi',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                  value: 'Option $index',
                                  groupValue: _educationLevel,
                                  activeColor: Constants().themeColor,
                                  onChanged: (value) {
                                    setState(() {
                                      _educationLevel = value!;
                                    });
                                  },
                                );
                              }).toList(),
                              const SizedBox(height: 20),
                              const Padding(
                                padding: EdgeInsets.only(left: 14.0),
                                child: Text(
                                  'Are you currently enrolled in school or a job training program?',
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
                                groupValue: _trainingProgram,
                                onChanged: (value) {
                                  setState(() {
                                    _trainingProgram = value!;
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
                                groupValue: _trainingProgram,
                                onChanged: (value) {
                                  setState(() {
                                    _trainingProgram = value!;
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
                        },
                      ),
                      const SizedBox(height: 20),
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
