import 'package:equatable/equatable.dart';

class DocumentModel extends Equatable {
  final String name;
  final String id;

  const DocumentModel({
    required this.name,
    required this.id,
  });

  @override
  List<Object?> get props => [
        name,
        id,
      ];
}
