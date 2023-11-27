// class DocumentListPage extends StatelessWidget {
//   Future<List<QuillDocument>> getAllDocuments() async {
//     // Replace this with your actual implementation
//     return [];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<QuillDocument>>(
//       future: getAllDocuments(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               final document = snapshot.data![index];
//               return ListTile(
//                 title: Text(document.title),
//                 onTap: () {
//                   // Navigate to the document editor when the list tile is tapped
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DocumentEditorPage(document: document),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }