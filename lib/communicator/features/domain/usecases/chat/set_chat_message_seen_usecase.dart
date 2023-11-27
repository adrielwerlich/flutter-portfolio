import 'package:adriel_flutter_app/communicator/core/error/failure.dart';
import 'package:adriel_flutter_app/communicator/core/usecase/base_use_case.dart';
import 'package:adriel_flutter_app/communicator/features/domain/repository/base_chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SetChatMessageSeenUseCase extends BaseUseCase<void,SetChatMessageSeenParameters>{
  final BaseChatRepository _baseChatRepository;

  SetChatMessageSeenUseCase(this._baseChatRepository);
  @override
  Future<Either<Failure, void>> call(SetChatMessageSeenParameters parameters)async {
    return await _baseChatRepository.setChatMessageSeen(parameters);
  }

}

class SetChatMessageSeenParameters extends Equatable{
  final String receiverId;
  final String messageId;

  const SetChatMessageSeenParameters({required this.receiverId, required this.messageId});

  @override
  List<Object?> get props => [receiverId,messageId,];
}