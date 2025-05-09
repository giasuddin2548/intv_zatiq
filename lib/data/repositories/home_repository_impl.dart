
import 'package:intv_zatiq/data/models/ProductModel.dart';

import '../../domain/repositories/home_repository.dart';
import '../data_sources/network_client.dart';
import '../models/ProductResponse.dart';

class HomeRepositoryImpl extends HomeRepository{
  final NetworkClient _networkClient;
  HomeRepositoryImpl(this._networkClient);

  @override
  Future<List<ProductModel>> fetchProduct(int pageNo) async{


    try{
      var res = await _networkClient.getData('/ProductList', {
        'page': pageNo
      });

      var myData = ProductResponse.fromJson(res.data);
      List<ProductModel> postList =  myData.data??[];
      return postList;

    }catch(e, l){

      List<ProductModel> postLis=[];
      return postLis;
    }




  }



}