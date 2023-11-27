import 'package:adriel_flutter_app/communicator/core/error/failure.dart';
import 'package:adriel_flutter_app/communicator/core/shared/message_replay.dart';
import 'package:adriel_flutter_app/communicator/features/domain/repository/base_chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecase/base_use_case.dart';

class SendGifMessageUseCase extends BaseUseCase<void, GifMessageParameters> {
  final BaseChatRepository _baseChatRepository;

  SendGifMessageUseCase(this._baseChatRepository);

  @override
  Future<Either<Failure, void>> call(GifMessageParameters parameters) async {
    return await _baseChatRepository.sendGifMessage(parameters);
  }
}

class GifMessageParameters extends Equatable {
  final String receiverId;
  final String gifUrl;
  final MessageReplay? messageReplay;

  const GifMessageParameters({
    required this.receiverId,
    required this.gifUrl,
    this.messageReplay,
  });

  @override
  List<Object?> get props => [
        receiverId,
        gifUrl,
    messageReplay,
      ];
}
