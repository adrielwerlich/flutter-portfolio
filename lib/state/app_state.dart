import 'package:adriel_flutter_app/state/models/quill_doc.dart';
import 'package:adriel_flutter_app/state/models/auth_data.dart';
import 'package:adriel_flutter_app/state/models/user_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';

import '../main.dart';

class AppState with ChangeNotifier {
  int _docId = 0;
  bool _isLogged = false;
  UserData? _userData;
  AuthData? _authData;
  QuillDoc? _quillDoc;
  List<QuillDoc> _list = [];

  List<QuillDoc> get list => _list;

  set list(List<QuillDoc> value) {
    _list = value;
    notifyListeners();
  }

  UserData? get userData => _userData;
  AuthData? get authData => _authData;
  int get docId => _docId;
  QuillDoc? get quillDoc => _quillDoc;

  bool get isLogged => _isLogged;

  AppState() {
    _loadState();
  }

  void _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    _isLogged = prefs.getBool('isLogged') ?? false;

    String? userDataString = prefs.getString('userData');
    if (userDataString != null &&
        userDataString.isNotEmpty &&
        userDataString != 'null') {
      _userData = UserData.fromJson(jsonDecode(userDataString));
    }

    String? authDataString = prefs.getString('authData');
    if (authDataString != null &&
        authDataString.isNotEmpty &&
        authDataString != 'null') {
      _authData = AuthData.fromJson(jsonDecode(authDataString));
    }
    notifyListeners();
  }

  void _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogged', _isLogged);
    prefs.setString('userData', jsonEncode(_userData?.toJson()));
    prefs.setString('authData', jsonEncode(_authData?.toJson()));
  }

  void logIn(UserData userData, AuthData authData) {
    _isLogged = true;
    _userData = userData;
    _authData = authData;
    _saveState();
    notifyListeners();
  }

  void logOut() {
    _isLogged = false;
    _userData = null;
    _authData = null;
    _saveState();
    notifyListeners();
  }

  void setDocId(int docId) {
    _docId = docId;
  }

  void setQuillDoc(QuillDoc quillDoc) {
    _quillDoc = quillDoc;
  }

  void setQuillDocContent(List<dynamic> content) {
    // if (delta != null) {
    //   _quillDoc!.delta = delta;
    // }
    if (content != null) {
      _quillDoc!.content = content;
    }
  }

  void setQuillDocTitle(String title) {
    if (_quillDoc != null) {
      _quillDoc!.title = title;
      notifyListeners();
    }
  }
}
