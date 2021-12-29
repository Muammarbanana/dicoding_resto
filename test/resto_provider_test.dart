import 'package:flutter_resto_dicoding/data/api/api_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Resto Provider Test", () {
    test("should return list when success", () async {
      final ApiService apiService = ApiService();
      final result = await apiService.fetchRestoList();
      expect(result.restaurants is List, true);
    });
  });
}
