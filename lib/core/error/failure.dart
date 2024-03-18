import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class OffLineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyCashFailure extends Failure {
  @override
  List<Object?> get props => [];
}


class WrongDataFailure extends Failure {
  List<String> messages;
  WrongDataFailure({
    required this.messages,
  });
  @override
  List<Object?> get props => [messages];
}
