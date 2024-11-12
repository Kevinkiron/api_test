import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<Navigate>(_navigateTo);
  }

  _navigateTo(Navigate event, Emitter<SplashState> emit) async {
    await Future.delayed(const Duration(seconds: 3), () {
      emit(state.copyWith(status: StatusState.success));
    });
  }
}
