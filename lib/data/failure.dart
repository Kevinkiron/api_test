import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.message,
  });
  final String message;

  String get errorMessage => " $message";

  @override
  List<Object> get props => [
        message,
      ];
}

class APIFailure extends Failure {
  const APIFailure({
    required super.message,
  });

  APIFailure.fromException(String exception)
      : this(
          message: exception,
        );
}
