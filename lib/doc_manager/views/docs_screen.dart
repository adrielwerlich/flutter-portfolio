import 'package:adriel_flutter_app/communicator/model/saved_notes.dart';
import 'package:adriel_flutter_app/doc_manager/views/editor_page.dart';
import 'package:flutter/material.dart';

class DocumentListPage extends StatefulWidget {
  @override
  _DocumentListPageState createState() => _DocumentListPageState();
}


class _DocumentListPageState extends State<DocumentListPage> {
   int count=0;
  List<SavedNotes> list = [
      SavedNotes(
        id: 1,
        title: 'Dummy Item 1',
        content: 'This is the content of dummy item 1',
      ),
      SavedNotes(
        id: 2,
        title: 'Dummy Item 2',
        content: 'This is the content of dummy item 2',
      ),
    ];
  // List<notes> nlist;//to store savednotes object return from database
  // int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Document List'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) => Card(
            child: ListTile(
              title: Text(list[index].title ?? "Insert a title"),
              subtitle: Text(list[index].content ?? "Insert a content"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditorPage(list[index]),//EditorPage
                ),
                // '/editor',
                // arguments: list[index],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    list.removeAt(index);
                  });
                },
              ),
            ),
          )
        )  
      ),
    );

    
    
  }
}
