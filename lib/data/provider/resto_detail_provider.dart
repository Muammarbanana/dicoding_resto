import 'package:flutter/cupertino.dart';
import 'package:flutter_resto_dicoding/common/constants.dart';
import 'package:flutter_resto_dicoding/data/api/api_service.dart';
import 'package:flutter_resto_dicoding/data/helper/database_helper.dart';
import 'package:flutter_resto_dicoding/data/models/resto_detail_model.dart'
    as rdm;

class RestoDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restoId;
  late DatabaseHelper _dbHelper;

  RestoDetailProvider({required this.apiService, required this.restoId}) {
    _dbHelper = DatabaseHelper();
    _fetchRestoDetail(restoId);
    checkFavourite(restoId);
  }

  late rdm.RestoDetailModel _restoDetail;
  late ResultState _state;
  late bool isFavorited;
  String _message = '';

  rdm.RestoDetailModel get result => _restoDetail;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> _fetchRestoDetail(String restoId) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final _restoDetailData = await apiService.fetchRestoDetail(restoId);
      if (_restoDetailData.error == false) {
        _state = ResultState.hasData;
        notifyListeners();
        _restoDetail = _restoDetailData;
      } else {
        _state = ResultState.error;
        notifyListeners();
        return _message = _restoDetail.message;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = '$e';
    }
  }

  Future<void> checkFavourite(String restoId) async {
    final resto = await _dbHelper.getRestaurantById(restoId);
    if (resto != null) {
      isFavorited = true;
      notifyListeners();
    } else {
      isFavorited = false;
      notifyListeners();
    }
  }
}
