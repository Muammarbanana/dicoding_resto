import 'package:flutter/material.dart';
import 'package:flutter_resto_dicoding/common/constants.dart';
import 'package:flutter_resto_dicoding/data/helper/database_helper.dart';
import 'package:flutter_resto_dicoding/data/models/resto_model.dart';

class DbProvider extends ChangeNotifier {
  List<Restaurant> _restaurant = [];
  late DatabaseHelper _dbHelper;
  late ResultState _state;

  List<Restaurant> get restaurant => _restaurant;
  ResultState get state => _state;

  DbProvider() {
    _dbHelper = DatabaseHelper();
    getAllRestaurants();
  }

  void getAllRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await _dbHelper.getRestaurants();
      if (restaurant.isNotEmpty) {
        _state = ResultState.hasData;
        _restaurant = restaurant;
        notifyListeners();
      } else {
        _state = ResultState.noData;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
    }
  }

  void addRestaurant(Restaurant restaurant) async {
    await _dbHelper.insertRestaurant(restaurant);
    notifyListeners();
    getAllRestaurants();
  }

  Future<dynamic> getRestaurantById(String id) async {
    try {
      final resto = await _dbHelper.getRestaurantById(id);
      if (resto == null) {
        _state = ResultState.noData;
        notifyListeners();
        return 'Data Kosong';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return resto;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return 'Error $e';
    }
  }

  void deleteRestaurant(String id) async {
    await _dbHelper.deleteRestaurant(id);
    notifyListeners();
    getAllRestaurants();
  }
}
