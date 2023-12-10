import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:io' if (dart.library.io) 'dart:io';
import 'dart:html' if (dart.library.html) 'dart:html' as html;

import '../main.dart';

void saveOrigin() async {
  var response = await http.get(Uri.parse('https://ipapi.co/json/'));
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    print('City: ${jsonResponse['city']}');
    print('Country: ${jsonResponse['country']}');
    print('Current date and time: ${DateTime.now()}');
    if (kIsWeb) {
      print('Running on the web');
    } 

    jsonResponse['datetime'] = DateTime.now().toIso8601String();
    if (kIsWeb) {
      jsonResponse['os'] = [
        html.window.navigator.appCodeName,
        html.window.navigator.appName,
        html.window.navigator.appVersion,
        html.window.navigator.language,
        html.window.navigator.onLine.toString(),
        html.window.navigator.platform,
        html.window.navigator.product,
        html.window.navigator.userAgent
      ].join(',');
      jsonResponse['osVersion'] = 'Not available';
      jsonResponse['dartVersion'] = 'Not available';
    } 
    if (kIsWeb) {
      print('Running on web');
      jsonResponse['plataform'] = 'Running on web';
    } 

    final url = Uri.parse('${MainApp.baseUrl}/request-origin');

    response = await http.post(
      url,
      body: jsonEncode(jsonResponse),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('IP information saved!');
    } else {
      print('Failed to save IP information');
    }
  } else {
    print('Failed to get IP information');
  }
}
