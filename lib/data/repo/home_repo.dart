import 'dart:developer';

import 'package:api_test/data/data_source/home_datasource.dart';
import 'package:api_test/data/models/product_model.dart';
import 'package:dartz/dartz.dart';

import '../api_excepion.dart';
import '../failure.dart';
import '../models/home_model.dart';
import '../type_def.dart';

class HomeRepo {
  final HomeDatasource _getHome;
  HomeRepo({required HomeDatasource getHome}) : _getHome = getHome;
  ResultFuture<HomeModel> homeGet() async {
    try {
      final result = await _getHome.homeGet();
      return Right(result);
    } on APIException catch (e) {
      log(e.toString());
      return Left(
        APIFailure.fromException(e.message),
      );
    }
  }

  ResultFuture<ProductModel> productGet(String id) async {
    try {
      final result = await _getHome.productGet(id);
      return Right(result);
    } on APIException catch (e) {
      log(e.toString());
      return Left(
        APIFailure.fromException(e.message),
      );
    }
  }

  ResultFuture<ProductModel> productEdit({
    required String title,
    required String desc,
    required String price,
    required String id,
  }) async {
    try {
      final result = await _getHome.productEdit(
        title: title,
        desc: desc,
        price: price,
        id: id,
      );
      return Right(result);
    } on APIException catch (e) {
      log(e.toString());
      return Left(
        APIFailure.fromException(e.message),
      );
    }
  }
}
