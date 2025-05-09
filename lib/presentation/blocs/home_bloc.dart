
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/ProductModel.dart';
import '../../domain/use_cases/home_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent , HomeState>{
  final HomeUseCase homeUseCase;


  HomeBloc(this.homeUseCase) : super(HomeDataLoadState()) {
    on<HomeGetDataEvent>(_getData);
    on<HomeGetDataLazyEvent>(_getDataLazy);
    on<HomeSearchDataEvent>(_filterData);
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

  FutureOr<void> _getDataLazy(HomeGetDataLazyEvent event, Emitter<HomeState> emit) async {
    final currentState = state as HomeDataLoadState;
    emit(currentState.copyWith(lazyLoadingApi: true, apiError: null));

    try {

      var newData = await homeUseCase.fetchProduct(event.pageNo);

      List<ProductModel> updatedList = List.from(currentState.productList ?? [])..addAll(newData);

      emit(currentState.copyWith(pList: updatedList, lazyLoadingApi: false));
    } catch (e) {
      emit(currentState.copyWith(lazyLoadingApi: false, apiError: e.toString()));
    }
  }


  FutureOr<void> _filterData(HomeSearchDataEvent event, Emitter<HomeState> emit) {
    final currentState = state as HomeDataLoadState;
    emit(currentState.copyWith(lazyLoadingApi: false, isLoadingApi: false, apiError: null));

    try {


      List<ProductModel> updatedList = List.from(currentState.productList ?? []);
      List<ProductModel> searchedList = [];

      for (var e in updatedList) {
        var searching=event.value.toLowerCase();
        var name = "${e.name}".toLowerCase();
        var brand = "${e.brandName}".toLowerCase();
        var cat = "${e.categoryName}".toLowerCase();
        if(searching.isEmpty){
          searchedList.addAll(updatedList);
        }else{
          if(name.contains(searching) || brand.contains(searching) || cat.contains(searching)){
            searchedList.add(e);
          }
        }
      }

      emit(currentState.copyWith(pList: searchedList,lazyLoadingApi: false, isLoadingApi: false, apiError: null, ));
    } catch (e) {
      emit(currentState.copyWith(lazyLoadingApi: false, isLoadingApi: false, apiError: null, ));
    }
  }
}

