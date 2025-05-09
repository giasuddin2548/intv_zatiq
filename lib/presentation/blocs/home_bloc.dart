
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/home_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent , HomeState>{
  final HomeUseCase homeUseCase;


  HomeBloc(this.homeUseCase) : super(HomeDataLoadState()) {
    on<HomeGetDataEvent>(_getData);
  }

  FutureOr<void> _getData(HomeGetDataEvent event, Emitter<HomeState> emit)async {


    final currentState = state as HomeDataLoadState;
    emit(currentState.copyWith(isLoadingApi: true, apiError: null));
    try {
      var data = await homeUseCase.fetchProduct(event.pageNo);
      emit(currentState.copyWith(pList: data, isLoadingApi: false));
    } catch (e) {
      emit(currentState.copyWith(isLoadingApi: false, apiError: e.toString()));
    }

  }
}

