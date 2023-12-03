// import 'package:adriel_flutter_app/communicator/features/domain/entities/message.dart';
// import 'package:adriel_flutter_app/communicator/features/presentation/views/chat/components/message/my_message_card.dart';
// import 'package:adriel_flutter_app/communicator/features/presentation/views/chat/components/message/sender_message_card.dart';
// import 'package:adriel_flutter_app/communicator/features/presentation/views/chat/components/message_content/message_content.dart';
// import 'package:adriel_flutter_app/communicator/message_replay_card.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'core/enums/message_type.dart';

// class MessageContainer extends StatelessWidget {
//   final String myId = '1';
//   List<Message> messages = [
//     Message(
//       text: 'Hello',
//       messageType: MessageType.text,
//       timeSent: DateTime.now(),
//       sentByMe: false,
//       repliedMessage: '',
//     ),
//     Message(
//       text: 'How are you?',
//       messageType: MessageType.text,
//       timeSent: DateTime.now(),
//       sentByMe: false,
//       repliedMessage: '',
//     ),
//     Message(
//       text: 'I\'m fine, thanks!',
//       messageType: MessageType.text,
//       timeSent: DateTime.now(),
//       sentByMe: true,
//       repliedMessage: '',
//     ),
//     Message(
//       text: 'What are you up to?',
//       messageType: MessageType.text,
//       timeSent: DateTime.now(),
//       sentByMe: false,
//       repliedMessage: '',
//     ),
//     Message(
//       text: 'No big deal, just chilling at home. You?',
//       messageType: MessageType.text,
//       timeSent: DateTime.now(),
//       sentByMe: true,
//       repliedMessage: '',
//     ),
//     Message(
//       text: 'I miss you',
//       messageType: MessageType.text,
//       timeSent: DateTime.now(),
//       sentByMe: false,
//       repliedMessage: '',
//     ),
//     Message(
//       text: 'Let\'s meet up',
//       messageType: MessageType.text,
//       timeSent: DateTime.now(),
//       sentByMe: false,
//       repliedMessage: '',
//     ),
//     Message(
//       text: 'Sure, where?',
//       messageType: MessageType.text,
//       timeSent: DateTime.now(),
//       sentByMe: true,
//       repliedMessage: '',
//     ),
//     Message(
//       text: 'My house? At 20h?',
//       messageType: MessageType.text,
//       timeSent: DateTime.now(),
//       sentByMe: false,
//       repliedMessage: '',
//     ),
//     Message(
//       text: 'Deal!',
//       messageType: MessageType.text,
//       timeSent: DateTime.now(),
//       sentByMe: true,
//       repliedMessage: '',
//     ),
//   ];

//   MessageContainer();

//   void sendMessage(String message) async {
//     final url = Uri.parse('http://localhost:4876/message');
//     final response = await http.post(
//       url,
//       body: jsonEncode({'message': message}),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       // Message sent successfully
//       messages.add(
//         Message(
//           text: message,
//           messageType: MessageType.text,
//           timeSent: DateTime.now(),
//           sentByMe: true,
//           repliedMessage: '',
//         ),
//       );
//       print('Message sent!');
//     } else {
//       // Failed to send message
//       print('Failed to send message');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: ListView.builder(
//             itemCount: messages.length,
//             shrinkWrap: true,
//             padding: EdgeInsets.only(bottom: 5),
//             physics: const BouncingScrollPhysics(),
//             itemBuilder: (context, index) {
//               final isFirst = index == 0;
//               final isReplying = messages[index].repliedMessage.isNotEmpty;
//               final message = messages[index];
//               final sentByMe = message.sentByMe;
//               final backgroundColor = sentByMe ? Colors.green : Colors.white;
//               final alignment =
//                   sentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;

//               return Column(
//                 children: [
//                   Column(
//                     children: [
//                       if (message.sentByMe)
//                         MyMessageCard(
//                           message: message,
//                           isFirst: isFirst,
//                         ),
//                       if (!message.sentByMe)
//                         SenderMessageCard(
//                           message: message,
//                           isFirst: isFirst,
//                         ),
//                     ],
//                   )
//                 ],
//               );
//             },
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Type a message...',
//                     border: InputBorder.none,
//                   ),
//                   onSubmitted: (String message) {
//                     // Handle submit logic
//                     sendMessage(message);
//                   },
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   // Handle attachment logic
//                 },
//                 icon: Icon(Icons.attach_file),
//               ),
//               IconButton(
//                 onPressed: () {
//                   // Handle send message logic
//                 },
//                 icon: Icon(Icons.send),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class WhatsAppMessage extends StatelessWidget {
//   final String message;
//   final String? imagePath;
//   final String? documentPath;

//   WhatsAppMessage({
//     required this.message,
//     this.imagePath,
//     this.documentPath,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (message.isNotEmpty)
//             Text(
//               message,
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//           if (imagePath != null)
//             Image.asset(
//               imagePath!,
//               width: 200,
//               height: 200,
//               fit: BoxFit.cover,
//             ),
//           if (documentPath != null)
//             ElevatedButton(
//               onPressed: () {
//                 // Handle document opening logic
//               },
//               child: Text('Open Document'),
//             ),
//         ],
//       ),
//     );
//   }
// }
