import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';
import '../../utility/textField.dart';

class EditContentObject {
  final String name;
  final String ssn;
  final String zip;
  final String race;
  final String sex;
  final DateTime dob;
  final String recommendation;
  final String primaryChargeCategory;
  final String riskLevel;
  final String consistency;

  EditContentObject({
    required this.name,
    required this.ssn,
    required this.zip,
    required this.race,
    required this.sex,
    required this.dob,
    required this.recommendation,
    required this.primaryChargeCategory,
    required this.riskLevel,
    required this.consistency,
  });
}

class DocEdit extends StatefulWidget {
  const DocEdit({super.key});

  @override
  _DocEdit createState() => _DocEdit();
}

class _DocEdit extends State<DocEdit> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ssnController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController chargeController = TextEditingController();

  String selectRace = 'Select an option';
  String selectSex = 'Select an option';
  String selectRecommendation = 'Select an option';
  String selectPrimaryChargeCategory = 'Select an option';
  String selectRiskLevel = 'Select an option';
  String selectConsistency =
      'Select an option';

  List<String> raceOptions = ['Select an option', 'White', 'Black', 'Asian', 'Other', 'Unknown'];
  List<String> sexOptions = ['Select an option', 'Male', 'Female'];
  List<String> recOptions = [
    'Select an option',
    'Detain',
    'Release with Supervision',
    'Release without Supervision'
  ];
  List<String> categoryOptions = [
    'Select an option',
    'Violent Felony/Firearm',
    'Violent Misdemeanor',
    'Non-violent Felony',
    'Driving Under the Influence',
    'Non-violent misdemeanor',
    'FTA: Violent Felony/Firearm/FTA: Violent Misdemeanor',
    'FTA: Non-Violent Felony',
    'FTA: Driving under the Influence',
    'FTA: Non-Violent Misdemeanor'
  ];
  List<String> levelOptions = ['Select an option', '1', '2', '3', '4', '5', '6'];
  List<String> consistencyOptions = [
    'Select an option',
    'The recommendation is consistent with the Praxis.',
    'The recommendation is not consistent with the Praxis.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 30),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 17, 0, 0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color(0x3fb8bfd7),
                  offset: Offset(0, 7),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 28),
                  padding: const EdgeInsets.fromLTRB(15, 13, 15, 12),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xffb8bed6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: const Text('Defendant Demographic Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          height: 1.2125,
                          color: Color(0xff1f2c5c),
                        )),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
                  width: double.infinity,
                  height: 555,
                  child: Stack(
                    children: [
                      const Positioned(
                        left: 15,
                        top: 0,
                        child: Text(
                          'Name:',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff1f2c5c)),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 0,
                        child: SizedBox(
                          width: 200,
                          height: 21,
                          child: CustomTextField(
                            controller: nameController,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 50,
                        child: Text(
                          'SSN:',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff1f2c5c)),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 48,
                        child: SizedBox(
                          width: 200,
                          height: 21,
                          child: CustomTextField(
                            controller: ssnController,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 95,
                        child: Text(
                          'Zip:',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff1f2c5c)),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 93,
                        child: SizedBox(
                          width: 200,
                          height: 21,
                          child: CustomTextField(
                            controller: zipController,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 140,
                        child: Text(
                          'Race:',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff1f2c5c)),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 134,
                        child: SizedBox(
                            width: 200,
                            height: 40,
                            child: DropdownButton<String>(
                              value: selectRace,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectRace = newValue!;
                                });
                              },
                              items: raceOptions.map((String race) {
                                return DropdownMenuItem<String>(
                                  value: race,
                                  child: Text(race),
                                );
                              }).toList(),
                            )),
                      ),
                      Positioned(
                        left: 15,
                        top: 185,
                        child: Text(
                          'Sex:',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff1f2c5c)),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 181,
                        child: SizedBox(
                            width: 200,
                            height: 38,
                            child: DropdownButton<String>(
                              value: selectSex,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectSex = newValue!;
                                });
                              },
                              items: sexOptions.map((String sex) {
                                return DropdownMenuItem<String>(
                                  value: sex,
                                  child: Text(sex),
                                );
                              }).toList(),
                            )),
                      ),
                      Positioned(
                        left: 15,
                        top: 230,
                        child: Text(
                          'DOB:',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff1f2c5c)),
                        ),
                      ),
                      Positioned(
                        left: 110,
                        top: 225,
                        child: SizedBox(
                          width: 150,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  );

                                  if (selectedDate != null) {
                                    setState(() {
                                      final formattedDate =
                                          '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';
                                      dobController.text = formattedDate;
                                    });
                                  }
                                },
                                child: Text(
                                  dobController.text.isEmpty
                                      ? 'Select Date of Birth'
                                      : dobController.text,
                                  style: TextStyle(
                                    color: dobController.text.isEmpty
                                        ? Color.fromARGB(153, 113, 116, 117)
                                        : Color(0xff1f2c5c),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 275,
                        child: Text(
                          'Recommendation:',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff1f2c5c)),
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 295,
                        child: SizedBox(
                            width: 237,
                            height: 40,
                            child: DropdownButton<String>(
                                value: selectRecommendation,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectRecommendation = newValue!;
                                  });
                                },
                                items: recOptions.map((String rec) {
                                  return DropdownMenuItem<String>(
                                    value: rec,
                                    child: Text(rec, overflow: TextOverflow.ellipsis,),
                                  );
                                }).toList(),
                              ),
                            ),
                      ),
                      Positioned(
                        left: 15,
                        top: 345,
                        child: Text(
                          'Primary Charge Category:',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff1f2c5c)),
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 365,
                        child: SizedBox(
                            width: 432,
                            height: 40,
                            child: DropdownButton<String>(
                                value: selectPrimaryChargeCategory,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectPrimaryChargeCategory = newValue!;
                                  });
                                },
                                items: categoryOptions.map((String category) {
                                  return DropdownMenuItem<String>(
                                    value: category,
                                    child: Text(category, overflow: TextOverflow.ellipsis,
                                     maxLines: 3,),
                                  );
                                }).toList(),
                              ),
                            ),
                      ),
                      Positioned(
                        left: 15,
                        top: 415,
                        child: Text(
                          'Risk Level:',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff1f2c5c)),
                        ),
                      ),
                      Positioned(
                        left: 128,
                        top: 405,
                        child: SizedBox(
                            width: 147,
                            height: 40,
                            child: DropdownButton<String>(
                              value: selectRiskLevel,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectRiskLevel = newValue!;
                                });
                              },
                              items: levelOptions.map((String level) {
                                return DropdownMenuItem<String>(
                                  value: level,
                                  child: Text(level),
                                );
                              }).toList(),
                            )),
                      ),
                      Positioned(
                        left: 14,
                        top: 445,
                        child: SizedBox(
                            width: 433,
                            height: 40,
                            child: DropdownButton<String>(
                              value: selectConsistency,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectConsistency = newValue!;
                                });
                              },
                              items: consistencyOptions.map((String consist) {
                                return DropdownMenuItem<String>(
                                  value: consist,
                                  child: Text(consist, overflow: TextOverflow.ellipsis,
                                   maxLines: 2,),
                                );
                              }).toList(),
                            )),
                      ),
                    ],
                  ),
                ),
                Container( // Submit button
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        backgroundColor: const Color(0xff1f2c5c),
                      ),
                      onPressed: _onSubmit,
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Submit',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        height: 1.6699999173,
                        color: Color(0xff1f2c5c),
                      ),
                    ),
                  ],
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit() async { 
    if (nameController.text.isNotEmpty &&
      ssnController.text.isNotEmpty &&
      zipController.text.isNotEmpty &&
      dobController.text.isNotEmpty &&
      selectRace != 'Select an option' &&
      selectSex != 'Select an option' &&
      selectRecommendation != 'Select an option' &&
      selectPrimaryChargeCategory != 'Select an option' &&
      selectRiskLevel != 'Select an option' &&
      selectConsistency != 'Select an option') { 
      context.goNamed('home');
    } else { 
      final snackBar = SnackBar(
        content: Text(
          'Please fill in all the fields.',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
