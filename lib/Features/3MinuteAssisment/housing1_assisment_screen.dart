import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';
import 'package:readytogo/Features/3MinuteAssisment/Step1Screen.dart';
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
          child: Column(
            children: [
              const SizedBox(height: 76),
              Row(
                children: [
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const CircleAvatar(
                      radius: 19,
                      backgroundColor: Colors.white,
                      child:
                          Icon(Icons.arrow_back, color: Colors.black, size: 19),
                    ),
                  ),
                  const SizedBox(width: 17),
                  const Text(
                    'Recovery Wellness Plan',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: const Text(
                      'Question 2/13',
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'satoshi',
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white,
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(10),
                      stopIndicatorColor: Colors.white,
                      value: 2 / 13,
                      valueColor: AlwaysStoppedAnimation(
                        Constants().themeColor,
                      ),
                    ),
                  ),
                ],
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
                            'Housing - 1',
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
                          'In the past 30 days, where you have been living most of the time?',
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
                      const Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          '(choose one option that best applies)',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'satoshi',
                          ),
                        ),
                      ),
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
                        activeColor: Constants().themeColor,
                        title: const Text(
                          'Someone else apartment/home',
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
                          'In a medical, treatment or other recovery setting',
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
                          'In jail, prison or other correctional setting.',
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
                          'In a shelter or temporary housing facility',
                          style: const TextStyle(
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
                          'Outdoors or on the streets',
                          style:  TextStyle(
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

                      /*  SizedBox(
                        height: MediaQuery.of(context).size.height * 0.41,
                        child: RawScrollbar(
                          thumbVisibility: true,
                          trackVisibility: true,
                          thickness: 10,
                          radius: const Radius.circular(10),
                          thumbColor: Constants().themeColor,
                          controller: _domainScrollController,
                          child: ListView.builder(
                            controller: _domainScrollController,
                            padding: EdgeInsets.zero,
                            itemCount: _domains.length,
                            itemBuilder: (context, index) {
                              final domain = _domains[index];
        
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: _selectedDomains.contains(domain),
                                      onChanged: (value) {
                                        print("VALUE NEW ${_selectedDomains}");
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
                            },
                          ),
                        ),
                      ),*/
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
                BackAndNextButton(onBackPressed: (){
                  Navigator.of(context).pop();
                }, onNextPressed: (){
                  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Housing2AssesmentScreen()));

                },),
           
              SizedBox(height: MediaQuery.of(context).size.height),
            ],
          ),
        ),
      ),
    );
  }
}
