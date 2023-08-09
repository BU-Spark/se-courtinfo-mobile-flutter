import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/form.dart';
import '../utility/app_url.dart';
import 'package:http/http.dart' as http;

Future<List<FormObject>> fetchformumentsFromApi() async {
  final response = await http.get(Uri.parse(AppUrl.forms));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((form) => FormObject(
      name: form['name'],
      description: form['description'],
      minPageCount: form['min_page_count'],
      variablePageCount: form['variable_page_count'],
    )).toList();
  } else {
    throw Exception('Failed to load formuments');
  }
}
