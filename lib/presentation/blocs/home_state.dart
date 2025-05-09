import 'package:equatable/equatable.dart';
import '../../data/models/ProductModel.dart';
abstract class HomeState extends  Equatable{}

class HomeDataLoadState extends HomeState {
  final List<ProductModel>? productList;
  final bool isLoadingApi;
  final bool lazyLoadingApi;
  final String? apiError;

  HomeDataLoadState({
    this.productList,
    this.isLoadingApi = false,
    this.lazyLoadingApi = false,
    this.apiError,
  });

  HomeDataLoadState copyWith({
    List<ProductModel>? pList,
    bool? isLoadingApi,
    bool? lazyLoadingApi,
    String? apiError
  }) {
    return HomeDataLoadState(
      productList: pList ?? productList,
      isLoadingApi: isLoadingApi ?? this.isLoadingApi,
      lazyLoadingApi: lazyLoadingApi ?? this.lazyLoadingApi,
      apiError: apiError ?? this.apiError
    );
  }


  @override
  List<Object?> get props => [productList, isLoadingApi, apiError];
}