import 'dart:convert';
import 'dart:io';

import 'package:flutter_resto_dicoding/data/models/resto_detail_model.dart';
import 'package:flutter_resto_dicoding/data/models/resto_model.dart';
import 'package:flutter_resto_dicoding/data/models/resto_search_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<Resto> fetchRestoList() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + 'list'));
      if (response.statusCode == 200) {
        return Resto.fromJson(json.decode(response.body));
      } else {
        throw ("Gagal mengambil data daftar restoran");
      }
    } on SocketException catch (_) {
      throw ("Tidak dapat terhubung ke internet");
    }
  }

  Future<RestoDetailModel> fetchRestoDetail(String restoId) async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + 'detail/$restoId'));
      if (response.statusCode == 200) {
        return RestoDetailModel.fromJson(json.decode(response.body));
      } else {
        throw Exception("Gagal mengambil data detail restoran");
      }
    } on SocketException catch (_) {
      throw ("Tidak dapat terhubung ke internet");
    }
  }

  Future<dynamic> fetchSearchedResto(String searchKeyword) async {
    try {
      final response =
          await http.get(Uri.parse(_baseUrl + 'search?q=$searchKeyword'));
      if (response.statusCode == 200) {
        return RestoSearchModel.fromJson(json.decode(response.body));
      } else if (searchKeyword.isEmpty || searchKeyword == '') {
        return fetchRestoList();
      } else {
        throw ('Gagal mengambil data pencarian');
      }
    } on SocketException catch (_) {
      throw ('Tidak dapat terhubung ke internet');
    }
  }
}
