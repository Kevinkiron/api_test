import 'dart:developer';

import '../api_endpoints.dart';
import '../api_excepion.dart';
import '../api_service.dart';
import '../models/home_model.dart';
import '../models/product_model.dart';

class HomeDatasource {
  final APIHelper _apiHelper;

  HomeDatasource(this._apiHelper);

  Future<HomeModel> homeGet() async {
    try {
      final response = await _apiHelper.request(
        params: {
          '': '',
        },
        url: ApiEndpoints.home,
        method: Method.GET,
      );
      log(response.data.runtimeType.toString(), name: 'Response Type');

      final result = HomeModel.fromJson(response.data);
      log(result.toString(), name: 'Taken');
      return result;
    } on APIException {
      rethrow;
    } catch (e) {
      log(e.toString());
      throw APIException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }

  Future<ProductModel> productGet(String id) async {
    try {
      final response = await _apiHelper.request(
        params: {
          '': '',
        },
        url: ApiEndpoints.product + id,
        method: Method.GET,
      );
      log(response.data.runtimeType.toString(), name: 'Response Type');

      final result = ProductModel.fromJson(response.data);
      log(result.toString(), name: 'Taken');
      return result;
    } on APIException {
      rethrow;
    } catch (e) {
      log(e.toString());
      throw APIException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }

  Future<ProductModel> productEdit({
    required String title,
    required String desc,
    required String price,
    required String id,
  }) async {
    try {
      final response = await _apiHelper.request(
        params: {
          'title': title,
          'price': price,
          'description': desc,
        },
        url: ApiEndpoints.product + id,
        method: Method.PUT,
      );
      log(response.data.runtimeType.toString(), name: 'Response Type');

      final result = ProductModel.fromJson(response.data);
      log(result.price.toString(), name: 'Taken');
      log(result.title.toString(), name: 'Taken');
      return result;
    } on APIException {
      rethrow;
    } catch (e) {
      log(e.toString());
      throw APIException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }
}
