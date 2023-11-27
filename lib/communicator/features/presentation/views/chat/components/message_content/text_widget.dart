import 'package:adriel_flutter_app/communicator/features/presentation/views/chat/components/message_content/time_sent_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/extensions/extensions.dart';
import '../../../../../domain/entities/message.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
  super.key,
  required this.message,
  required this.isMe,
  });

  final Message message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
        color: isMe ? Colors.green : Colors.yellow.shade100,
        borderRadius: BorderRadius.circular(10), // Add the desired border radius here
      ),
      child: Wrap(
        
        crossAxisAlignment: WrapCrossAlignment.end,
        alignment: WrapAlignment.end,
        children: [
          Padding(
    
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message.text,
              // style: context.displaySmall,
              style:  TextStyle(
                fontSize: context.displaySmall?.fontSize,
                color: isMe ? Colors.green.shade900 : Colors.amber,
              ),
              overflow: TextOverflow.visible,
              selectionColor: Colors.deepPurple.shade300,
            ),
          ),
          TimeSentWidget(
            message: message,
            isMe: isMe,
            textColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}