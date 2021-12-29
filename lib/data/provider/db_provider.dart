import 'package:flutter/material.dart';
import 'package:flutter_resto_dicoding/data/helper/database_helper.dart';
import 'package:flutter_resto_dicoding/data/models/resto_model.dart';

class DbProvider extends ChangeNotifier {
  List<Restaurant> _restaurant = [];
  late DatabaseHelper _dbHelper;

  List<Restaurant> get restaurant => _restaurant;

  DbProvider() {
    _dbHelper = DatabaseHelper();
    getAllRestaurants();
  }

  void getAllRestaurants() async {
    _restaurant = await _dbHelper.getRestaurants();
    notifyListeners();
  }

  void addRestaurant(Restaurant restaurant) async {
    await _dbHelper.insertRestaurant(restaurant);
    getAllRestaurants();
  }

  Future<dynamic> getRestaurantById(String id) async {
    try {
      final resto = await _dbHelper.getRestaurantById(id);
      if (resto == null) {
        return 'Data Kosong';
      } else {
        return resto;
      }
    } catch (e) {
      return 'Error $e';
    }
  }

  void deleteRestaurant(String id) async {
    await _dbHelper.deleteRestaurant(id);
    getAllRestaurants();
  }
}
