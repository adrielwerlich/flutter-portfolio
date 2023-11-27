import 'dart:io';

import 'package:adriel_flutter_app/communicator/core/enums/message_type.dart';
import 'package:adriel_flutter_app/communicator/core/error/failure.dart';
import 'package:adriel_flutter_app/communicator/core/shared/message_replay.dart';
import 'package:adriel_flutter_app/communicator/core/usecase/base_use_case.dart';
import 'package:adriel_flutter_app/communicator/features/domain/repository/base_chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';


class SendFileMessageUseCase extends BaseUseCase<void, FileMessageParameters> {
  final BaseChatRepository _baseChatRepository;

  SendFileMessageUseCase(this._baseChatRepository);

  @override
  Future<Either<Failure, void>> call(FileMessageParameters parameters) async {
    return await _baseChatRepository.sendFileMessage(parameters);
  }
}

class FileMessageParameters extends Equatable {
  final String receiverId;
  final MessageType messageType;
  final File file;
  final MessageReplay? messageReplay;

  const FileMessageParameters({
    required this.receiverId,
    required this.messageType,
    required this.file,
    this.messageReplay,
  });

  @override
  List<Object?> get props => [
        receiverId,
        messageType,
        file,
    messageReplay,
      ];
}
