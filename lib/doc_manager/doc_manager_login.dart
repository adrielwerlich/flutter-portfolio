import 'package:adriel_flutter_app/state/app_state.dart';
import 'package:adriel_flutter_app/state/models/auth_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';
import '../state/models/user_data.dart';

class DocManagerLogin extends StatefulWidget {
  // final VoidCallback gotoDocsPage;
  // DocManagerLogin({required this.gotoDocsPage});
  @override
  _DocManagerLoginState createState() => _DocManagerLoginState();
}

class _DocManagerLoginState extends State<DocManagerLogin> {
  // bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login to your documents',
      theme: ThemeData.light(), // Light mode theme
      darkTheme: ThemeData.dark(), // Dark mode theme
      themeMode: ThemeMode.system, // System theme mode
      home: Scaffold(
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(20.0),
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _password = kReleaseMode
      ? ''
      : '432121341'; // hard coded credentials for dev/debug purposes only
  String _email = kReleaseMode ? '' : 'adrielwerlich@outlook.com';
  var loading = false;

  void _submit(BuildContext ctx) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        loading = true;
      });

      // kReleaseMode
      final localUrl = Uri.parse('http://localhost:4876/login');
      final prodUrl = Uri.parse('${MainApp.baseUrl}/login');
      final finalUrl = kReleaseMode ? prodUrl : localUrl;

      final url = prodUrl;
      final response = await http.post(
        url,
        body: jsonEncode({'password': _password, 'email': _email}),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        print('Success!');
        print(response.body);
        // ignore: use_build_context_synchronously
        var appState = Provider.of<AppState>(context, listen: false);

        // Save userData to appState
        final data = jsonDecode(response.body);
        if (data['auth'] == true) {
          appState.logIn(UserData.fromJsonMap(data['userData']),
              AuthData.fromJsonMap(data['sessionData']));
          Fluttertoast.showToast(
            msg: "Login successful!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
          );
        }
      } else {
        print('error');
        print(response.statusCode);
        print('Error: ${response.statusCode}');
        print('Error message: ${response.body}');
        Fluttertoast.showToast(
          msg: 'Login failed: : ${response.body}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 50,
        );
      }

      Future.delayed(Duration(seconds: 5), () {
        // This code will be executed after a delay of 5 seconds.
        print('5 seconds have passed!');
        if (mounted) {
          // Avoid calling `setState` if the widget is no longer in the widget tree.
          setState(() {
            loading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            initialValue: _email,
            validator: (value) {
              if (value!.isEmpty ||
                  !RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                      .hasMatch(value)) {
                return 'Please enter a valid email.';
              }
              return null;
            },
            onSaved: (value) => _email = value!,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            initialValue: _password,
            validator: (value) {
              if (value!.isEmpty || value.length < 8) {
                return 'Please enter a valid password with at least 8 characters.';
              }
              return null;
            },
            onSaved: (value) => _password = value!,
            onFieldSubmitted: (value) => _submit(context),
          ),
          if (loading)
            CircularProgressIndicator() // Show the loader if loading is true
          else
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                onPressed: () => _submit(context),
                child: Text('Submit'),
              ),
            ),
        ],
      ),
    );
  }
}
