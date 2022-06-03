import 'package:flutter/material.dart';
import 'package:restaurant_food/api/api_service.dart';
import 'package:restaurant_food/helper/result_state.dart';
import 'package:restaurant_food/models/restaurant.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();

  RestaurantSearchProvider getSearchRestaurant(String query) {
    _fetchSearchData(query);
    return this;
  }

  late RestaurantSearchResults _restaurantSearchResults;

  late ResultState _state;

  String _message = '';

  String get message => _message;

  RestaurantSearchResults get resultSearch => _restaurantSearchResults;

  ResultState get state => _state;

  Future<dynamic> _fetchSearchData(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.searchRestaurant(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "No Data Found";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantSearchResults = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Error --> $e";
    }
  }
}
