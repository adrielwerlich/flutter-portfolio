import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../main.dart';

void saveOrigin() async {
  var response = await http.get(Uri.parse('https://ipapi.co/json/'));
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    print('City: ${jsonResponse['city']}');
    print('Country: ${jsonResponse['country']}');
    print('Current date and time: ${DateTime.now()}');

    jsonResponse['datetime'] = DateTime.now().toIso8601String();
    jsonResponse['os'] = Platform.operatingSystem;
    jsonResponse['osVersion'] = Platform.operatingSystemVersion;
    jsonResponse['dartVersion'] = Platform.version;

    if (Platform.isAndroid || Platform.isIOS) {
      jsonResponse['plataform'] = 'Running on mobile';
    } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      jsonResponse['plataform'] = 'Running on desktop';
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