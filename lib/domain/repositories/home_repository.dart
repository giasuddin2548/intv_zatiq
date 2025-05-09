
import 'package:intv_zatiq/data/models/ProductModel.dart';

abstract class HomeRepository{
  Future<List<ProductModel>> fetchProduct(int pageNo);
}