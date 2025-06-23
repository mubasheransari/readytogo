import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';
import 'package:readytogo/Features/3MinuteAssisment/widget_recoverywellnessplan.dart';
import 'package:readytogo/widgets/back_next_button_widget.dart';
import 'package:readytogo/widgets/boxDecorationWidget.dart';

class FamilyReunitingFamilyAftercareScreen extends StatefulWidget {
  const FamilyReunitingFamilyAftercareScreen({Key? key}) : super(key: key);

  @override
  State<FamilyReunitingFamilyAftercareScreen> createState() =>
      _FamilyReunitingFamilyAftercareScreenState();
}

class _FamilyReunitingFamilyAftercareScreenState
    extends State<FamilyReunitingFamilyAftercareScreen> {
  String _married = '';
  String _childern = '';

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
                                  title: "Family/Reuniting , Family/Aftercare"),
                              const SizedBox(height: 18),
                              const Padding(
                                padding: EdgeInsets.only(left: 14.0),
                                child: Text(
                                  'Self Inquiry',
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
                                  '(Answer all the questions below)',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'satoshi',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Padding(
                                padding: EdgeInsets.only(left: 14.0),
                                child: Text(
                                  'Married',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'satoshi',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: RadioListTile<String>(
                                      title: const Text(
                                        'Yes',
                                        style: TextStyle(
                                          fontFamily: 'satoshi',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                      ),
                                      value: 'Option 1',
                                      groupValue: _married,
                                      activeColor: Constants().themeColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _married = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile<String>(
                                      title: const Text(
                                        'No',
                                        style: TextStyle(
                                          fontFamily: 'satoshi',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                      ),
                                      value: 'Option 2',
                                      groupValue: _married,
                                      activeColor: Constants().themeColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _married = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              const Padding(
                                padding: EdgeInsets.only(left: 14.0),
                                child: Text(
                                  'Children',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'satoshi',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: RadioListTile<String>(
                                      title: const Text(
                                        'Yes',
                                        style: TextStyle(
                                          fontFamily: 'satoshi',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                      ),
                                      value: 'Option 3',
                                      groupValue: _childern,
                                      activeColor: Constants().themeColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _childern = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile<String>(
                                      title: const Text(
                                        'No',
                                        style: TextStyle(
                                          fontFamily: 'satoshi',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                      ),
                                      value: 'Option 4',
                                      groupValue: _childern,
                                      activeColor: Constants().themeColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _childern = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              const Padding(
                                padding: EdgeInsets.only(left: 14.0),
                                child: Text(
                                  'Number of Children',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'satoshi',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 14.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'type here',
                                    hintStyle: TextStyle(
                                      fontFamily: 'satoshi',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Padding(
                                padding: EdgeInsets.only(left: 14.0),
                                child: Text(
                                  'Any Other Dependent',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'satoshi',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 14.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'type here',
                                    hintStyle: TextStyle(
                                      fontFamily: 'satoshi',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 22),
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
                      const SizedBox(height: 15),
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
