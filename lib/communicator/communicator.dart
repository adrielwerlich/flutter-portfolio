import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CommunicatorLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login to mobile-desktop exchange',
      theme: ThemeData.light(), // Light mode theme
      darkTheme: ThemeData.dark(), // Dark mode theme
      themeMode: ThemeMode.system, // System theme mode
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('Namer App'),
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back),
        //     onPressed: () {
        //       if (Navigator.canPop(context)) {
        //         Navigator.pop(context);
        //       }
        //     },
        //   ),
        // ),
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
  String _identifier = '';
  String _email = '';
  var loading = false;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        loading = true;
      });

      final url = Uri.parse('http://localhost:4876/login');
      final response = await http.post(
        url,
        body: jsonEncode({'identifier': _identifier, 'email': _email}),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        // TODO: Handle successful response
        print('Success!');
      } else {
        // TODO: Handle error response
        print('error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Identifier'),
            validator: (value) {
              if (value!.isEmpty || value.length < 4) {
                return 'Please enter a valid identifier with at least 4 characters.';
              }
              return null;
            },
            onSaved: (value) => _identifier = value!,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value!.isEmpty || !value.contains('@')) {
                return 'Please enter a valid email.';
              }
              return null;
            },
            onSaved: (value) => _email = value!,
          ),
          // Text(loading, style: TextStyle(color: Colors.red)),
          ElevatedButton(
            onPressed: _submit,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}



// import 'package:socket_io_client/socket_io_client.dart' as IO;

//       // ...

//       IO.Socket socket = IO.io('https://login-anantadeva.herokuapp.com', <String, dynamic>{
//         'transports': ['websocket'],
//         'autoConnect': false,
//       });

//       socket.connect();