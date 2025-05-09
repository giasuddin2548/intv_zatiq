
import 'package:dio/dio.dart';

class NetworkClient {
  final Dio _dio;
  NetworkClient(this._dio);

  Future<Response> getData(String endPoint, Map<String, dynamic> map)async{
    try{
      var res =  await _dio.get(endPoint, queryParameters: map);
      return res;
    }on DioException catch (ex){
      return Response(requestOptions: ex.requestOptions, statusCode: ex.response?.statusCode??500);
    }
  }

}