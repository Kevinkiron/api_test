import 'dart:developer';
import 'package:api_test/data/models/home_model.dart';
import 'package:api_test/src/prdouct_detail_view.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../data/repo/home_repo.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepo homeRepo;

  HomeBloc({required this.homeRepo}) : super(const HomeState()) {
    on<FetchHome>(_homeFetch);
    on<ProductFetch>(_productGet);
    on<EditPrdouct>(_productEdit);
  }

  Future<void> _homeFetch(FetchHome event, Emitter<HomeState> emit) async {
    emit(state.copyWith(load: true));
    final homeResponse = await homeRepo.homeGet();

    homeResponse.fold(
      (failure) {
        emit(state.copyWith(
          load: false,
        ));
      },
      (result) {
        emit(state.copyWith(load: false, homeApi: result.products));
        log((result.products).toString());
      },
    );
  }

  Future<void> _productGet(ProductFetch event, Emitter<HomeState> emit) async {
    emit(state.copyWith(productLoaad: true));
    final homeResponse = await homeRepo.productGet(event.id);

    homeResponse.fold(
      (failure) {
        emit(state.copyWith(
          productLoaad: false,
        ));
      },
      (result) {
        emit(state.copyWith(productLoaad: false, productApi: [result]));
        Navigator.push(
            event.context,
            MaterialPageRoute(
              builder: (context) => ProductDetailView(),
            ));
      },
    );
  }

  Future<void> _productEdit(EditPrdouct event, Emitter<HomeState> emit) async {
    emit(state.copyWith(productLoaad: true));
    final homeResponse = await homeRepo.productEdit(
        id: event.id, desc: event.desc, price: event.price, title: event.title);

    homeResponse.fold(
      (failure) {
        emit(state.copyWith(
          productLoaad: false,
        ));
      },
      (result) {
        emit(state.copyWith(productLoaad: false, productApi: [result]));
      },
    );
  }
}
