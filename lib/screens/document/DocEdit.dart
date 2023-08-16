import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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

  String selectRace = 'White';
  String selectSex = 'Male';
  String selectRecommendation = 'Detain';
  String selectPrimaryChargeCategory = 'Violent Felony/Firearm';
  String selectRiskLevel = '1';
  String selectConsistency =
      'The recommendation is consistent with the Praxis.';

  List<String> raceOptions = ['White', 'Black', 'Asian', 'Other', 'Unknown'];
  List<String> sexOptions = ['Male', 'Female'];
  List<String> recOptions = [
    'Detain',
    'Release with Supervision',
    'Release without Supervision'
  ];
  List<String> categoryOptions = [
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
  List<String> levelOptions = ['1', '2', '3', '4', '5', '6'];
  List<String> consistencyOptions = [
    'The recommendation is consistent with the Praxis.',
    'The recommendation is not consistent with the Praxis.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 35),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 36),
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
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 23),
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
                width: double.infinity,
                height: 457,
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
                          labelText: 'Name',
                          hintText: 'Enter your name',
                          controller: nameController,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 15,
                      top: 40,
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
                      top: 40,
                      child: SizedBox(
                        width: 200,
                        height: 21,
                        child: CustomTextField(
                          labelText: 'SSN',
                          hintText: 'Enter your ssn',
                          controller: ssnController,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 15,
                      top: 80,
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
                      top: 80,
                      child: SizedBox(
                        width: 200,
                        height: 21,
                        child: CustomTextField(
                          labelText: 'Zip',
                          hintText: 'Enter your zip cide',
                          controller: zipController,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 15,
                      top: 120,
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
                      top: 116,
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
                      top: 160,
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
                      top: 156,
                      child: SizedBox(
                          width: 200,
                          height: 40,
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
                      top: 200,
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
                      top: 200,
                      child: SizedBox(
                        width: 52,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () async {
                                DatePicker.showDatePicker(
                                  context,
                                  showTitleActions: true,
                                  minTime: DateTime(1900),
                                  maxTime: DateTime.now(),
                                  onConfirm: (date) {
                                    setState(() {
                                      final formattedDate =
                                          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
                                      dobController.text = formattedDate;
                                    });
                                  },
                                  currentTime: DateTime.now(),
                                );
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
                      top: 240,
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
                      top: 255,
                      child: SizedBox(
                          width: 200,
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
                                child: Text(rec),
                              );
                            }).toList(),
                          )),
                    ),
                    Positioned(
                      left: 15,
                      top: 300,
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
                      top: 315,
                      child: SizedBox(
                          width: 200,
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
                                child: Text(category),
                              );
                            }).toList(),
                          )),
                    ),
                    Positioned(
                      left: 15,
                      top: 360,
                      child: Text(
                        'Risk Level:',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff1f2c5c)),
                      ),
                    ),
                    Positioned(
                      right: 15,
                      top: 356,
                      child: SizedBox(
                          width: 200,
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
                      top: 400,
                      child: SizedBox(
                          width: 380,
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
                                child: Text(consist),
                              );
                            }).toList(),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
