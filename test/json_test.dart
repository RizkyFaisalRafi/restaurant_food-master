import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_food/models/restaurant.dart';
var dummyRestaurant = {
  "id": "rqdv5juczeskfw1e867",
  "name": "Melting Pot",
  "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
  "pictureId": "14",
  "city": "Medan",
  "rating": 4.20
};

void main() {
  test("get restaurant name data", () {
    var restaurantResult = RestaurantList
        .fromJson(dummyRestaurant)
        .name;
    expect(restaurantResult, "Melting Pot");
  });
}
