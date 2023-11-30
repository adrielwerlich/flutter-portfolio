import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:flutter_quill/flutter_quill.dart';

import '../../main.dart';

class QuillDoc {
  final int id;
  String title;
  List<dynamic>? content;
  Delta? delta;
  DateTime createdAt;
  DateTime? updatedAt;
  DateTime? openedAt;

  QuillDoc({
    required this.id,
    required this.title,
    this.content,
    this.delta,
    required this.createdAt,
    this.updatedAt,
    this.openedAt,
  });

  set setTitle(String newTitle) {
    title = newTitle;
  }

  factory QuillDoc.fromJson(Map<String, dynamic> json) {
    return QuillDoc(
      id: json['id'],
      title: json['title'],
      content:
          json['content'] != "" ? List<dynamic>.from(json['content']) : null,
      delta: json['content'] != ""
          ? Delta.fromJson(json['content'] ?? List<dynamic>.empty())
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      openedAt:
          json['opened_at'] != null ? DateTime.parse(json['opened_at']) : null,
    );
  }

  static Future<void> updateQuillDocState(
      int docId, String? title, List<dynamic>? content) async {
    try {
      final now = DateTime.now();
      final formattedTimestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      // Check if either title or content is not null
      if (title != null || content != null) {
        // Make the POST request to update the Quill doc state

        final response = await http.put(
          Uri.parse('${MainApp.baseUrl}/documents/$docId'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            if (title != null) 'title': title,
            if (content != null) 'content': content,
            'updated_at': formattedTimestamp,
          }),
        );

        // Check if the request was successful
        if (response.statusCode == 200) {
          print('Quill doc state updated successfully');
        } else {
          print('Failed to update Quill doc state');
        }
      }
    } catch (e) {
      print('Error occurred while updating Quill doc state: $e');
    }
  }
}

// final quillDefaultSamples = [
//   QuillDoc(
//       id: 1,
//       title: 'Quill Default Sample 1',
//       createdAt: DateTime.utc(2023, 11, 20),
//       content: [
//         {
//           'insert': {
//             'image':
//                 "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.1T2J7T-ZFmGkEmHINnm2wwHaFj%26pid%3DApi&f=1&ipt=9e5beb974bb2e567683142b08478370624d9d08c982e8902bf6098426a5d18f0&ipo=images"
//           },
//           'attributes': {
//             'width': '100',
//             'height': '100',
//             'style': 'width:500px; height:350px;'
//           }
//         },
//         {'insert': 'Flutter Quill'},
//         {
//           'attributes': {'header': 1},
//           'insert': '\n'
//         },
//         {
//           'insert': {
//             'video':
//                 'https://www.youtube.com/watch?v=V4hgdKhIqtc&list=PLbhaS_83B97s78HsDTtplRTEhcFsqSqIK&index=1'
//           }
//         },
//         {
//           'insert': {
//             'video':
//                 'https://user-images.githubusercontent.com/122956/126238875-22e42501-ad41-4266-b1d6-3f89b5e3b79b.mp4'
//           }
//         },
//         {'insert': '\nRich text editor for Flutter'},
//         {
//           'attributes': {'header': 2},
//           'insert': '\n'
//         },
//         {'insert': 'Quill component for Flutter'},
//         {
//           'attributes': {'header': 3},
//           'insert': '\n'
//         },
//         {
//           'attributes': {'link': 'https://bulletjournal.us/home/index.html'},
//           'insert': 'Bullet Journal'
//         },
//         {
//           'insert':
//               ':\nTrack personal and group journals (ToDo, Note, Ledger) from multiple views with timely reminders'
//         },
//         {
//           'attributes': {'list': 'ordered'},
//           'insert': '\n'
//         },
//         {
//           'insert':
//               'Share your tasks and notes with teammates, and see changes as they happen in real-time, across all devices'
//         },
//         {
//           'attributes': {'list': 'ordered'},
//           'insert': '\n'
//         },
//         {
//           'insert':
//               'Check out what you and your teammates are working on each day'
//         },
//         {
//           'attributes': {'list': 'ordered'},
//           'insert': '\n'
//         },
//         {'insert': '\nSplitting bills with friends can never be easier.'},
//         {
//           'attributes': {'list': 'bullet'},
//           'insert': '\n'
//         },
//         {'insert': 'Start creating a group and invite your friends to join.'},
//         {
//           'attributes': {'list': 'bullet'},
//           'insert': '\n'
//         },
//         {
//           'insert':
//               'Create a BuJo of Ledger type to see expense or balance summary.'
//         },
//         {
//           'attributes': {'list': 'bullet'},
//           'insert': '\n'
//         },
//         {
//           'insert':
//               '\nAttach one or multiple labels to tasks, notes or transactions. Later you can track them just using the label(s).'
//         },
//         {
//           'attributes': {'blockquote': true},
//           'insert': '\n'
//         },
//         {'insert': "\nvar BuJo = 'Bullet' + 'Journal'"},
//         {
//           'attributes': {'code-block': true},
//           'insert': '\n'
//         },
//         {'insert': '\nStart tracking in your browser'},
//         {
//           'attributes': {'indent': 1},
//           'insert': '\n'
//         },
//         {'insert': 'Stop the timer on your phone'},
//         {
//           'attributes': {'indent': 1},
//           'insert': '\n'
//         },
//         {'insert': 'All your time entries are synced'},
//         {
//           'attributes': {'indent': 2},
//           'insert': '\n'
//         },
//         {'insert': 'between the phone apps'},
//         {
//           'attributes': {'indent': 2},
//           'insert': '\n'
//         },
//         {'insert': 'and the website.'},
//         {
//           'attributes': {'indent': 3},
//           'insert': '\n'
//         },
//         {'insert': '\n'},
//         {'insert': '\nCenter Align'},
//         {
//           'attributes': {'align': 'center'},
//           'insert': '\n'
//         },
//         {'insert': 'Right Align'},
//         {
//           'attributes': {'align': 'right'},
//           'insert': '\n'
//         },
//         {'insert': 'Justify Align'},
//         {
//           'attributes': {'align': 'justify'},
//           'insert': '\n'
//         },
//         {'insert': 'Have trouble finding things? '},
//         {
//           'attributes': {'list': 'ordered'},
//           'insert': '\n'
//         },
//         {'insert': 'Just type in the search bar'},
//         {
//           'attributes': {'indent': 1, 'list': 'ordered'},
//           'insert': '\n'
//         },
//         {'insert': 'and easily find contents'},
//         {
//           'attributes': {'indent': 2, 'list': 'ordered'},
//           'insert': '\n'
//         },
//         {'insert': 'across projects or folders.'},
//         {
//           'attributes': {'indent': 2, 'list': 'ordered'},
//           'insert': '\n'
//         },
//         {'insert': 'It matches text in your note or task.'},
//         {
//           'attributes': {'indent': 1, 'list': 'ordered'},
//           'insert': '\n'
//         },
//         {'insert': 'Enable reminders so that you will get notified by'},
//         {
//           'attributes': {'list': 'ordered'},
//           'insert': '\n'
//         },
//         {'insert': 'email'},
//         {
//           'attributes': {'indent': 1, 'list': 'ordered'},
//           'insert': '\n'
//         },
//         {'insert': 'message on your phone'},
//         {
//           'attributes': {'indent': 1, 'list': 'ordered'},
//           'insert': '\n'
//         },
//         {'insert': 'popup on the web site'},
//         {
//           'attributes': {'indent': 1, 'list': 'ordered'},
//           'insert': '\n'
//         },
//         {'insert': 'Create a BuJo serving as project or folder'},
//         {
//           'attributes': {'list': 'bullet'},
//           'insert': '\n'
//         },
//         {'insert': 'Organize your'},
//         {
//           'attributes': {'indent': 1, 'list': 'bullet'},
//           'insert': '\n'
//         },
//         {'insert': 'tasks'},
//         {
//           'attributes': {'indent': 2, 'list': 'bullet'},
//           'insert': '\n'
//         },
//         {'insert': 'notes'},
//         {
//           'attributes': {'indent': 2, 'list': 'bullet'},
//           'insert': '\n'
//         },
//         {'insert': 'transactions'},
//         {
//           'attributes': {'indent': 2, 'list': 'bullet'},
//           'insert': '\n'
//         },
//         {'insert': 'under BuJo '},
//         {
//           'attributes': {'indent': 3, 'list': 'bullet'},
//           'insert': '\n'
//         },
//         {'insert': 'See them in Calendar'},
//         {
//           'attributes': {'list': 'bullet'},
//           'insert': '\n'
//         },
//         {'insert': 'or hierarchical view'},
//         {
//           'attributes': {'indent': 1, 'list': 'bullet'},
//           'insert': '\n'
//         },
//         {'insert': 'this is a check list'},
//         {
//           'attributes': {'list': 'checked'},
//           'insert': '\n'
//         },
//         {'insert': 'this is a uncheck list'},
//         {
//           'attributes': {'list': 'unchecked'},
//           'insert': '\n'
//         },
//         {'insert': 'Font '},
//         {
//           'attributes': {'font': 'sans-serif'},
//           'insert': 'Sans Serif'
//         },
//         {'insert': ' '},
//         {
//           'attributes': {'font': 'serif'},
//           'insert': 'Serif'
//         },
//         {'insert': ' '},
//         {
//           'attributes': {'font': 'monospace'},
//           'insert': 'Monospace'
//         },
//         {'insert': ' Size '},
//         {
//           'attributes': {'size': 'small'},
//           'insert': 'Small'
//         },
//         {'insert': ' '},
//         {
//           'attributes': {'size': 'large'},
//           'insert': 'Large'
//         },
//         {'insert': ' '},
//         {
//           'attributes': {'size': 'huge'},
//           'insert': 'Huge'
//         },
//         {
//           'attributes': {'size': '15.0'},
//           'insert': 'font size 15'
//         },
//         {'insert': ' '},
//         {
//           'attributes': {'size': '35'},
//           'insert': 'font size 35'
//         },
//         {'insert': ' '},
//         {
//           'attributes': {'size': '20'},
//           'insert': 'font size 20'
//         },
//         {
//           'attributes': {'token': 'built_in'},
//           'insert': ' diff'
//         },
//         {
//           'attributes': {'token': 'operator'},
//           'insert': '-match'
//         },
//         {
//           'attributes': {'token': 'literal'},
//           'insert': '-patch'
//         },
//         {
//           'insert': {
//             'image':
//                 'https://user-images.githubusercontent.com/122956/72955931-ccc07900-3d52-11ea-89b1-d468a6e2aa2b.png'
//           },
//           'attributes': {
//             'width': '230',
//             'style': 'display: block; margin: auto; width: 500px;'
//           }
//         },
//         {'insert': '\n'}
//       ]),
//   QuillDoc(
//       id: 2,
//       title: 'Quill Default Sample 2',
//       createdAt: DateTime.now().toUtc(),
//       content: [
//         {
//           'insert': {
//             'image':
//                 "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.1T2J7T-ZFmGkEmHINnm2wwHaFj%26pid%3DApi&f=1&ipt=9e5beb974bb2e567683142b08478370624d9d08c982e8902bf6098426a5d18f0&ipo=images"
//           },
//           'attributes': {
//             'width': '100',
//             'height': '100',
//             'style': 'width:500px; height:350px;'
//           }
//         },
//         {'insert': 'It matches text in your note or task.'},
//         {
//           'attributes': {'indent': 1, 'list': 'ordered'},
//           'insert': '\n'
//         },
//         {'insert': 'Enable reminders so that you will get notified by'},
//         {
//           'attributes': {'list': 'ordered'},
//           'insert': '\n'
//         },
//         {'insert': 'email'},
//         {
//           'attributes': {'indent': 1, 'list': 'ordered'},
//           'insert': '\n'
//         },
//         {'insert': 'message on your phone'},
//         {
//           'attributes': {'indent': 1, 'list': 'ordered'},
//           'insert': '\n'
//         },
//         {'insert': 'popup on the web site'},
//         {
//           'attributes': {'indent': 1, 'list': 'ordered'},
//           'insert': '\n'
//         },
//         {'insert': 'Create a BuJo serving as project or folder'},
//         {
//           'attributes': {'list': 'bullet'},
//           'insert': '\n'
//         },
//         {'insert': 'Organize your'},
//         {
//           'attributes': {'indent': 1, 'list': 'bullet'},
//           'insert': '\n'
//         },
//         {'insert': 'tasks'},
//         {
//           'attributes': {'indent': 2, 'list': 'bullet'},
//           'insert': '\n'
//         },
//         {'insert': 'notes'},
//         {
//           'attributes': {'indent': 2, 'list': 'bullet'},
//           'insert': '\n'
//         },
//         {'insert': 'transactions'},
//         {
//           'attributes': {'indent': 2, 'list': 'bullet'},
//           'insert': '\n'
//         },
//         {'insert': 'under BuJo '},
//         {
//           'attributes': {'indent': 3, 'list': 'bullet'},
//           'insert': '\n'
//         },
//         {'insert': 'See them in Calendar'},
//         {
//           'attributes': {'list': 'bullet'},
//           'insert': '\n'
//         },
//         {'insert': 'or hierarchical view'},
//         {
//           'attributes': {'indent': 1, 'list': 'bullet'},
//           'insert': '\n'
//         },
//         {'insert': 'this is a check list'},
//         {
//           'attributes': {'list': 'checked'},
//           'insert': '\n'
//         },
//         {'insert': 'this is a uncheck list'},
//         {
//           'attributes': {'list': 'unchecked'},
//           'insert': '\n'
//         },
//         {'insert': 'Font '},
//         {
//           'attributes': {'font': 'sans-serif'},
//           'insert': 'Sans Serif'
//         },
//         {'insert': ' '},
//         {
//           'attributes': {'font': 'serif'},
//           'insert': 'Serif'
//         },
//         {'insert': ' '},
//         {
//           'attributes': {'font': 'monospace'},
//           'insert': 'Monospace'
//         },
//         {'insert': ' Size '},
//         {
//           'attributes': {'size': 'small'},
//           'insert': 'Small'
//         },
//         {'insert': ' '},
//         {
//           'attributes': {'size': 'large'},
//           'insert': 'Large'
//         },
//         {'insert': ' '},
//         {
//           'attributes': {'size': 'huge'},
//           'insert': 'Huge'
//         },
//         {
//           'attributes': {'size': '15.0'},
//           'insert': 'font size 15'
//         },
//         {'insert': ' '},
//         {
//           'attributes': {'size': '35'},
//           'insert': 'font size 35'
//         },
//         {'insert': ' '},
//         {
//           'attributes': {'size': '20'},
//           'insert': 'font size 20'
//         },
//         {
//           'attributes': {'token': 'built_in'},
//           'insert': ' diff'
//         },
//         {
//           'attributes': {'token': 'operator'},
//           'insert': '-match'
//         },
//         {
//           'attributes': {'token': 'literal'},
//           'insert': '-patch'
//         },
//         {
//           'insert': {
//             'image':
//                 'https://user-images.githubusercontent.com/122956/72955931-ccc07900-3d52-11ea-89b1-d468a6e2aa2b.png'
//           },
//           'attributes': {
//             'width': '230',
//             'style': 'display: block; margin: auto; width: 500px;'
//           }
//         },
//         {'insert': '\n'}
//       ]),
// ];
