import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';
import 'package:readytogo/Features/3MinuteAssisment/widget_recoverywellnessplan.dart';
import 'package:readytogo/widgets/back_next_button_widget.dart';
import 'package:readytogo/widgets/boxDecorationWidget.dart';
import 'housing2_assisment_screen.dart';

class Housing1AssesmentScreen extends StatefulWidget {
  const Housing1AssesmentScreen({Key? key}) : super(key: key);

  @override
  State<Housing1AssesmentScreen> createState() =>
      _Housing1AssesmentScreenState();
}

class _Housing1AssesmentScreenState extends State<Housing1AssesmentScreen> {
  String _selectedOption = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: boxDecoration(),
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
                      TitleHeading3minAssesment(title: "Housing - 1"),
                      const SizedBox(height: 12),
                      Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          'In the past 30 days, where you have been living most of the time?',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          '(choose one option that best applies)',
                          style: TextStyle(
                            color: Constants().greyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'satoshi',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      /// Radio buttons
                      RadioListTile<String>(
                        title: const Text(
                          'My own home/apartment',
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
                        title: const Text(
                          'Someone else apartment/home',
                          style: TextStyle(
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        value: 'Option 2',
                        activeColor: Constants().themeColor,
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text(
                          'In a medical, treatment or other recovery setting',
                          style: TextStyle(
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        value: 'Option 3',
                        activeColor: Constants().themeColor,
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text(
                          'In jail, prison or other correctional setting.',
                          style: TextStyle(
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        value: 'Option 4',
                        activeColor: Constants().themeColor,
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text(
                          'In a shelter or temporary housing facility',
                          style: TextStyle(
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        value: 'Option 5',
                        activeColor: Constants().themeColor,
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text(
                          'Outdoors or on the streets',
                          style: TextStyle(
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        value: 'Option 6',
                        activeColor: Constants().themeColor,
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Housing2AssesmentScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
