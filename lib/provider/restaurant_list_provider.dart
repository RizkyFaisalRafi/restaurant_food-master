import 'package:flutter/cupertino.dart';
import 'package:restaurant_food/api/api_service.dart';
import 'package:restaurant_food/helper/result_state.dart';
import 'package:restaurant_food/models/restaurant.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();

  RestaurantListProvider getListResult() {
    _fetchRestaurantList();
    return this;
  }

  late RestaurantResult _restaurantListResult;

  late ResultState _state;

  String _message = '';

  String get message => _message;

  RestaurantResult get resultList => _restaurantListResult;

  ResultState get state => _state;

  Future<dynamic> _fetchRestaurantList() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantList();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "No Data Found";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantListResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Error --> $e";
    }
  }
}
