import 'package:flutter/cupertino.dart';
import 'package:flutter_resto_dicoding/data/api/api_service.dart';
import 'package:flutter_resto_dicoding/data/models/resto_model.dart';

enum ResultState { loading, hasData, noData, error }

class RestoProvider extends ChangeNotifier {
  final ApiService apiService;

  RestoProvider({required this.apiService}) {
    _fetchAllResto();
  }

  late Resto _resto;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  Resto get result => _resto;

  ResultState get state => _state;

  Future<dynamic> _fetchAllResto() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final _restoList = await apiService.fetchRestoList();
      if (_restoList.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Data Kosong';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _resto = _restoList;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
