import 'package:api_test/bloc/home_bloc/home_bloc.dart';
import 'package:api_test/data/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

import '../bloc/splash_bloc/splash_bloc.dart';
import '../data/api_service.dart';
import '../data/data_source/home_datasource.dart';

final APIHelper apiHelper = APIHelper();

List<SingleChildWidget> blocProviderList = [
  BlocProvider(
    create: (context) => SplashBloc()..add(Navigate()),
  ),
  BlocProvider(
    create: (context) =>
        HomeBloc(homeRepo: HomeRepo(getHome: HomeDatasource(apiHelper)))
          ..add(FetchHome()),
  ),
];
