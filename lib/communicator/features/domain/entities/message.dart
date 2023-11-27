import 'package:adriel_flutter_app/communicator/core/enums/message_type.dart';
import 'package:equatable/equatable.dart';


class Message extends Equatable {
  final String senderId;
  final String receiverId;
  final String senderName;
  final String text;
  final String messageId;
  final DateTime timeSent = DateTime.now();
  final bool isSeen;
  final bool sentByMe;
  final MessageType messageType;
  //replay message
  final String repliedMessage;
  final String repliedTo;
  final MessageType repliedMessageType;

  Message({
    this.senderId = '',
    this.receiverId = '',
    required this.text,
    this.messageId = '',
    DateTime? timeSent,
    this.isSeen = false,
    required this.messageType,
    this.repliedMessage = '',
    this.repliedTo = '',
    this.repliedMessageType = MessageType.text,
    this.senderName = '',
    this.sentByMe = false,
  });

  // const Message({
  //   required this.senderId,
  //   required this.receiverId,
  //   required this.text,
  //   required this.messageId,
  //   required this.timeSent,
  //   required this.isSeen,
  //   required this.messageType,
  //   required this.repliedMessage,
  //   required this.repliedTo,
  //   required this.repliedMessageType,
  //   required this.senderName,
  // });


  @override
  List<Object?> get props => [
    senderId,
    receiverId,
    text,
    messageId,
    timeSent,
    isSeen,
    messageType,
    repliedMessage,
    repliedTo,
    repliedMessageType,
    senderName,
  ];
}
