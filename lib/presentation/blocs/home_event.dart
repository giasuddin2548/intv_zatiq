
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends  Equatable{}

class HomeGetDataEvent extends HomeEvent{
  int pageNo;
  HomeGetDataEvent(this.pageNo);


  @override
  List<Object?> get props => [];
}
class HomeGetDataLazyEvent extends HomeEvent{
  int pageNo;
  HomeGetDataLazyEvent(this.pageNo);


  @override
  List<Object?> get props => [];
}

class HomeSearchDataEvent extends HomeEvent{

  @override
  List<Object?> get props => [];
}