import 'package:adriel_flutter_app/communicator/model/saved_notes.dart';
import 'package:flutter/material.dart';

class EditorPage extends StatefulWidget {

  SavedNotes? _note;
  EditorPage(this._note);

  @override
  // ignore: no_logic_in_create_state
  EditorPageState createState() => EditorPageState(_note);
}

class EditorPageState extends State<EditorPage> {

  SavedNotes? _note;
  EditorPageState(this._note);

  // late ZefyrController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    // Here we must load the document and pass it to Zefyr controller.
    // final document = _loadDocument();
    // _controller = ZefyrController(document);
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    // Note that the editor requires special `ZefyrScaffold` widget to be
    // one of its parents.
    return Scaffold(
      appBar: AppBar(title: Text("Editor page")),
      // body: ZefyrEditor(
      //   padding: EdgeInsets.all(16),
      //   controller: _controller,
      //   focusNode: _focusNode,
      // ),
    );
  }

  /// Loads the document to be edited in Zefyr.
  // NotusDocument _loadDocument() {
  //   // For simplicity we hardcode a simple document with one line of text
  //   // saying "Zefyr Quick Start".
  //   // (Note that delta must always end with newline.)

  //   // if (!(_note is SavedNotes)) {
  //   //   final Delta delta = Delta()..insert("Zefyr Quick Start\n");
  //   //   return NotusDocument.fromDelta(delta);
  //   // } else {
  //   // }
  //     final Delta delta = Delta()..insert(_note!.content ?? "Zefyr Quick Start\n");
  //     return NotusDocument.fromDelta(delta);

  //   // final Delta delta = Delta()..insert("Zefyr Quick Start\n");
  //   // return NotusDocument.fromDelta(delta);
  // }
}
