import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class RequestFailure extends Failure {
  const RequestFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);
}

class NoDataFailure extends Failure {
  const NoDataFailure(super.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class OtherFailure extends Failure {
  const OtherFailure(super.message);
}

class UnAuthorizedFailure extends Failure {
  const UnAuthorizedFailure(super.message);
}
