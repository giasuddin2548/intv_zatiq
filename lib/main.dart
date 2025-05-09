import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intv_zatiq/data/data_sources/network_client.dart';
import 'package:intv_zatiq/data/repositories/home_repository_impl.dart';
import 'package:intv_zatiq/domain/use_cases/home_usecase.dart';
import 'package:intv_zatiq/presentation/blocs/home_bloc.dart';
import 'package:intv_zatiq/presentation/pages/home_screen.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<HomeBloc>(create: (_)=>HomeBloc(HomeUseCase(HomeRepositoryImpl(NetworkClient(Dio(BaseOptions(baseUrl: "https://laravelpoint.com/api")))))))

    ], child: MaterialApp(
      title: 'Zatiq',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen(),
    ));
  }
}

