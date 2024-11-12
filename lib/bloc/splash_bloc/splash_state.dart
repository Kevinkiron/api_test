part of 'splash_bloc.dart';

enum StatusState { success, failure, initial }

class SplashState extends Equatable {
  final StatusState status;

  const SplashState({
    this.status = StatusState.initial,
  });
  SplashState copyWith({
    StatusState? status,
  }) {
    return SplashState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [];
}
