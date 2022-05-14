import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String msg;

  Failure(this.msg);
}

class ServerFailure extends Failure {
  ServerFailure(String msg) : super(msg);
  @override
  List<Object?> get props => [msg];
}

class CacheFailure extends Failure {
  CacheFailure(String msg) : super(msg);

  @override
  List<Object?> get props => [msg];
}
