import 'dart:core';

class RestaurantResult {
  RestaurantResult(
      {required this.error,
      required this.message,
      required this.count,
      required this.restaurants});

  bool error;
  String message;
  int count;
  List<RestaurantList> restaurants;

  factory RestaurantResult.fromJson(Map<String, dynamic> json) =>
      RestaurantResult(
          error: json["error"],
          message: json["message"],
          count: json["count"],
          restaurants: List<RestaurantList>.from((json["restaurants"] as List)
              .map((x) => RestaurantList.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class RestaurantList {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  RestaurantList({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory RestaurantList.fromJson(Map<String, dynamic> json) => RestaurantList(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}

class RestaurantDetailResults {
  RestaurantDetailResults(
      {required this.error, required this.message, required this.restaurant});

  bool error;
  String message;
  RestaurantDetails restaurant;

  factory RestaurantDetailResults.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailResults(
        error: json["error"],
        message: json["message"],
        restaurant: RestaurantDetails.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() =>
      {"error": error, "message": message, "restaurant": restaurant};
}

class RestaurantDetails {
  String id;
  String name;
  String description;
  String pictureId;
  String address;
  String city;
  double rating;
  Menus? menus;
  List<ItemName> categories;

  RestaurantDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.address,
    required this.city,
    required this.rating,
    required this.menus,
    required this.categories,
  });

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) =>
      RestaurantDetails(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        address: json["address"],
        city: json["city"],
        rating: json["rating"].toDouble(),
        menus: Menus.fromJson(json["menus"]),
        categories: List<ItemName>.from(
            json["categories"].map((x) => ItemName.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "address": address,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "menus": menus?.toJson(),
      };
}

class Menus {
  Menus({required this.foods, required this.drinks});

  List<ItemName> foods;
  List<ItemName> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
      foods:
          List<ItemName>.from(json["foods"].map((x) => ItemName.fromJson(x))),
      drinks:
          List<ItemName>.from(json["drinks"].map((x) => ItemName.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}

class RestaurantSearchResults {
  bool error;
  int founded;
  List<RestaurantList> restaurants;

  RestaurantSearchResults(
      {required this.error, required this.founded, required this.restaurants});

  factory RestaurantSearchResults.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchResults(
          error: json["error"],
          founded: json["founded"],
          restaurants: List<RestaurantList>.from((json["restaurants"] as List)
              .map((x) => RestaurantList.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class ItemName {
  ItemName({required this.name});

  String name;

  factory ItemName.fromJson(Map<String, dynamic> json) => ItemName(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class CustomerReviews {
  String name;
  String review;
  String date;

  CustomerReviews(
      {required this.name, required this.review, required this.date});

  factory CustomerReviews.fromJson(Map<String, dynamic> json) =>
      CustomerReviews(
          name: json["name"], review: json["review"], date: json["date"]);

  Map<String, dynamic> toJson() =>
      {"name": name, "review": review, "date": date};
}
