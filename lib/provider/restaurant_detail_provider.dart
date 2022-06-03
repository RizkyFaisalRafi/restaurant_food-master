import 'package:flutter/material.dart';
import 'package:restaurant_food/api/api_service.dart';
import 'package:restaurant_food/helper/result_state.dart';
import 'package:restaurant_food/models/restaurant.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();

  RestaurantDetailProvider getDetailRestaurant(String id) {
    _fetchRestaurantDetails(id);
    return this;
  }

  late RestaurantDetailResults _detailResults;

  late ResultState _state;

  String _message = '';

  String get message => _message;

  RestaurantDetailResults get results => _detailResults;

  ResultState get state => _state;

  Future<dynamic> _fetchRestaurantDetails(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantDetail(id);
      if (!restaurant.error) {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailResults = restaurant;
      } else {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "No Data Found";
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
