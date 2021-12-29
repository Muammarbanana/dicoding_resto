import 'package:flutter/cupertino.dart';
import 'package:flutter_resto_dicoding/common/constants.dart';
import 'package:flutter_resto_dicoding/data/api/api_service.dart';

class RestoSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestoSearchProvider({required this.apiService}) {
    fetchSearchedResto('');
  }

  late dynamic _searchedResto;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  dynamic get result => _searchedResto;

  ResultState get state => _state;

  Future<dynamic> fetchSearchedResto(String searchKeyword) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final _restoList = await apiService.fetchSearchedResto(searchKeyword);
      if (_restoList.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Data Tidak Ditemukan';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchedResto = _restoList;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
