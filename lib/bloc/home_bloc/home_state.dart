part of 'home_bloc.dart';

enum ApiStatus { success, failure, initial }

class HomeState extends Equatable {
  final ApiStatus status;
  final List<Product> homeApi;
  final List<ProductModel> productApi;
  final bool load;
  final bool productLoaad;
  const HomeState(
      {this.status = ApiStatus.initial,
      this.productApi = const <ProductModel>[],
      this.load = false,
      this.productLoaad = false,
      this.homeApi = const <Product>[]});
  HomeState copyWith({
    ApiStatus? status,
    List<Product>? homeApi,
    List<ProductModel>? productApi,
    bool? load,
    bool? productLoaad,
  }) {
    return HomeState(
      status: status ?? this.status,
      load: load ?? this.load,
      productLoaad: productLoaad ?? this.productLoaad,
      homeApi: homeApi ?? this.homeApi,
      productApi: productApi ?? this.productApi,
    );
  }

  @override
  List<Object> get props => [
        status,
        productApi,
        load,
        productLoaad,
        homeApi,
      ];
}
