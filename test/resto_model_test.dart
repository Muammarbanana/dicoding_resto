import 'dart:convert';

import 'package:flutter_resto_dicoding/data/models/resto_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return appropriate parsed value when function completed", () {
    Resto restoModel;
    String jsonExample = '''{
    "error": false,
    "message": "success",
    "count": 20,
    "restaurants": [
        {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
        },
        {
            "id": "s1knt6za9kkfw1e867",
            "name": "Kafe Kita",
            "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
            "pictureId": "25",
            "city": "Gorontalo",
            "rating": 4}]}''';
    restoModel = Resto.fromJson(json.decode(jsonExample));
    expect(restoModel.count, 20);
    expect(restoModel.message, "success");
    expect(restoModel.error, false);
    expect(restoModel.restaurants[0].name, "Melting Pot");
  });
}
