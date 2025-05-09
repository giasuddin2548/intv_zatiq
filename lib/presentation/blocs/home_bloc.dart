
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intv_zatiq/data/models/ProductModel.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent , HomeState>{

  HomeBloc() : super(HomeDataLoadState()) {
    on<HomeGetDataEvent>(_getData);
  }

  FutureOr<void> _getData(HomeGetDataEvent event, Emitter<HomeState> emit)async {

    print(event.pageNo);

    emit(HomeDataLoadState(productList: [ProductModel(name: "Gias"), ProductModel(name: "Rima")]));

  }
}

