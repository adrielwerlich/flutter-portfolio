import 'package:adriel_flutter_app/communicator/core/enums/message_type.dart';
import 'package:equatable/equatable.dart';

class MessageReplay extends Equatable {
  final String message;
  final bool isMe;
  final MessageType messageType;
  final String repliedTo;

  const MessageReplay( {
    required this.message,
    required this.isMe,
    required this.messageType,
    required this.repliedTo,
  });

  @override
  List<Object?> get props => [
        message,
        isMe,
        messageType,
    repliedTo,
      ];
}
