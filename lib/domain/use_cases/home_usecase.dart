
import '../../data/models/ProductModel.dart';
import '../repositories/home_repository.dart';

class HomeUseCase{
  final HomeRepository _homeRepository;
  HomeUseCase(this._homeRepository);

  Future<List<ProductModel>> fetchProduct(int pageNo)async{
    var res =await _homeRepository.fetchProduct(pageNo);
    return res;
  }

}