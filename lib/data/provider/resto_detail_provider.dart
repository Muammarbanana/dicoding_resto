import 'package:flutter/cupertino.dart';
import 'package:flutter_resto_dicoding/data/api/api_service.dart';
import 'package:flutter_resto_dicoding/data/models/resto_detail_model.dart';

enum ResultState { loading, hasData, noData, error }

class RestoDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restoId;

  RestoDetailProvider({required this.apiService, required this.restoId}) {
    _fetchRestoDetail(restoId);
  }

  late RestoDetailModel _restoDetail;
  late ResultState _state;
  String _message = '';

  RestoDetailModel get result => _restoDetail;
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
}
