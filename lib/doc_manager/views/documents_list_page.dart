import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:adriel_flutter_app/communicator/model/saved_notes.dart';
import 'package:adriel_flutter_app/doc_manager/quill/quill_screen.dart';
import 'package:adriel_flutter_app/state/models/quill_doc.dart';
import 'package:adriel_flutter_app/main.dart';
import 'package:adriel_flutter_app/state/app_state.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

class DocumentListPage extends StatefulWidget {
  static const routeName = '/documents-list';

  @override
  _DocumentListPageState createState() => _DocumentListPageState();
}

class _DocumentListPageState extends State<DocumentListPage> {
  // List<QuillDoc> list = [];
  late AppState? appState;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      appState = Provider.of<AppState>(context, listen: false);
      loadData();
    });
  }

  Future<void> loadData() async {
    _isLoading = true;
    var userId = appState!.userData?.id; // Replace with the actual user ID

    var url = '${MainApp.baseUrl}/documents/$userId';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var data = body['data'] as List;
      List<QuillDoc> quillDocs =
          data.map((item) => QuillDoc.fromJson(item)).toList();
      if (quillDocs.isNotEmpty) {
        await Future.delayed(Duration(seconds: 2));
        setState(() {
          appState?.list = quillDocs;
          // list = quillDocs;
          // print(list);
          _isLoading = false;
        });
      }
    } else {
      // Error occurred while loading data
      print('Failed to load data. Error: ${response.statusCode}');
    }
  }

  Future<void> logout() async {
    var url = '${MainApp.baseUrl}/logout';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // widget.onLogout();
      var appState = Provider.of<AppState>(context, listen: false);
      appState.logOut();
      Fluttertoast.showToast(
        msg: "LogOut successful!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
      );
      print('Logout successful!');
    } else {
      // Error occurred while logging out
      print('Failed to logout. Error: ${response.statusCode}');
    }
  }

  String getFormattedDate(QuillDoc doc) {
    if (doc.updatedAt != null) {
      return 'Updated at: ${DateFormat('dd/MM/yyyy HH:mm').format(doc.updatedAt!.toLocal())}';
    } else if (doc.openedAt != null) {
      return 'Opened at: ${DateFormat('dd/MM/yyyy HH:mm').format(doc.openedAt!.toLocal())}';
    } else {
      return 'Created at: ${DateFormat('dd/MM/yyyy HH:mm').format(doc.createdAt.toLocal())}';
    }
  }

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Document List'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              logout();
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                  itemCount: appState?.list.length,
                  itemBuilder: (context, index) => Card(
                        child: ListTile(
                          title: Text(appState?.list[index].title ?? "Insert a title"),
                          subtitle: Text(getFormattedDate(appState!.list[index]) ?? ""),
                          onTap: () {
                            if (appState?.list[index].content != null) {
                              Navigator.of(context).pushNamed(
                                QuillScreen.routeName,
                                arguments: QuillScreenArgs(
                                  document: Document.fromJson(
                                      appState?.list?[index]?.content as List),
                                ),
                              );
                            } else {
                              Navigator.of(context).pushNamed(
                                QuillScreen.routeName,
                                arguments: QuillScreenArgs(
                                  document: Document(),
                                ),
                              );
                            }
                            appState!.setQuillDoc(appState!.list[index]);
                          },
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                appState?.list.removeAt(index);
                              });
                            },
                          ),
                        ),
                      ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showOptions(context);
        },
        child: Icon(Icons.more_vert),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void createDocument() async {
    var url = 'http://localhost:4876/document';

    var appState = Provider.of<AppState>(context, listen: false);
    // Create the request body
    var requestBody = {
      'title': 'New Document',
      'content': '',
      'user_id': appState.userData?.id,
    };

    // Send the POST request
    var response = await http.post(Uri.parse(url), body: requestBody);
    var responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      // Document created successfully
      print('New document created!');

      // Get the ID from the response body
      var documentId = responseBody['id'];
      appState.setDocId(documentId);
      print('Document ID: $documentId');
    } else {
      // Error occurred while creating the document
      print('Failed to create document. Error: ${response.statusCode}');
      var responseBody = json.decode(response.body);
      var errorMessage = responseBody['message'];
      print('Error Message: $errorMessage');
    }
  }

  void showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.edit_document),
                title: Text('New Document'),
                onTap: () {
                  createDocument();
                  Navigator.of(context).pushNamed(
                    QuillScreen.routeName,
                    arguments: QuillScreenArgs(
                      document: Document(),
                    ),
                  );

                  // Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
                onTap: () {
                  // TODO: Implement share option
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.copy),
                title: Text('Copy'),
                onTap: () {
                  // TODO: Implement copy option
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: () {
                  // TODO: Implement delete option
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
