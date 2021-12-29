import 'package:flutter/material.dart';
import 'package:flutter_resto_dicoding/data/localdbhelper/database_helper.dart';
import 'package:flutter_resto_dicoding/data/models/resto_model.dart';

class DbProvider extends ChangeNotifier {
  List<Restaurant> _restaurant = [];
  late DatabaseHelper _dbHelper;

  List<Restaurant> get restaurant => _restaurant;

  DbProvider() {
    _dbHelper = DatabaseHelper();
  }

  void getAllRestaurants() async {
    _restaurant = await _dbHelper.getRestaurants();
    notifyListeners();
  }

  void addRestaurant(Restaurant restaurant) async {
    await _dbHelper.insertRestaurant(restaurant);
    getAllRestaurants();
  }

  Future<Restaurant> getRestaurantById(int id) async {
    return await _dbHelper.getRestaurantById(id);
  }

  void deleteRestaurant(int id) async {
    await _dbHelper.deleteRestaurant(id);
    getAllRestaurants();
  }
}
