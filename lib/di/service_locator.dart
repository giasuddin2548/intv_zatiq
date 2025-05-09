import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:intv_zatiq/data/repositories/home_repository_impl.dart';
import 'package:intv_zatiq/domain/repositories/home_repository.dart';
import 'package:intv_zatiq/presentation/blocs/home_bloc.dart';

import '../data/data_sources/network_client.dart';
import '../domain/use_cases/home_usecase.dart';

final sl = GetIt.instance;

Future<void> init()async{
  var dio =Dio();
  dio.options.baseUrl = "https://laravelpoint.com/api";

  sl.registerSingleton(dio);
  sl.registerSingleton<NetworkClient>(NetworkClient(sl()));

  sl.registerLazySingleton<HomeRepository>(()=>HomeRepositoryImpl(sl()));
  sl.registerLazySingleton<HomeUseCase>(()=>HomeUseCase(sl()));

  sl.registerFactory<HomeBloc>(()=>HomeBloc(sl()));

}