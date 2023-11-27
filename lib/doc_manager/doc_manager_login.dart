import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DocManagerLogin extends StatefulWidget {
  final VoidCallback gotoDocsPage;
  DocManagerLogin({required this.gotoDocsPage});
  @override
  _DocManagerLoginState createState() => _DocManagerLoginState();
}

class _DocManagerLoginState extends State<DocManagerLogin> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
  }

  void onLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    setState(() {
      isLoggedIn = true;
    });
  }

  void onLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    setState(() {
      isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login to mobile-desktop exchange',
      theme: ThemeData.light(), // Light mode theme
      darkTheme: ThemeData.dark(), // Dark mode theme
      themeMode: ThemeMode.system, // System theme mode
      home: Scaffold(
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(20.0),
            child: LoginForm(onLogin: onLogin),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final VoidCallback onLogin;
  LoginForm({required this.onLogin});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _password = '432121341';
  String _email = 'example@example.com';
  var loading = false;

  void _submit(BuildContext ctx) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('In construction'),
          content: Text('This feature is not yet implemented'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Dead end'),
              onPressed: () {
                // Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        loading = true;
      });

      final url = Uri.parse('http://localhost:4876/login');
      final response = await http.post(
        url,
        body: jsonEncode({'password': _password, 'email': _email}),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        print('Success!');
        widget.onLogin();
        final parentWidget =
            ctx.findAncestorWidgetOfExactType<DocManagerLogin>();
        if (parentWidget != null) {
          parentWidget.gotoDocsPage();
        }
      } else {
        print('error');
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
