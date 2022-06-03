import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_food/helper/result_state.dart';
import 'package:restaurant_food/models/restaurant.dart';
import 'package:restaurant_food/provider/restaurant_search_provider.dart';
import 'package:restaurant_food/view/detail_restaurant_page.dart';
import 'package:restaurant_food/widget/card_list.dart';
import 'package:restaurant_food/widget/no_internet_connection.dart';

class SearchRestaurantPage extends StatefulWidget {
  const SearchRestaurantPage({Key? key}) : super(key: key);

  @override
  State<SearchRestaurantPage> createState() => _SearchRestaurantPageState();
}

class _SearchRestaurantPageState extends State<SearchRestaurantPage> {
  final _controller = TextEditingController(text: "");

  RestaurantSearchProvider provider = RestaurantSearchProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return provider.getSearchRestaurant(" ");
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _controller,
                        onSubmitted: (value) {
                          provider.getSearchRestaurant(_controller.text);
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          labelText: "Cari Makanan",
                          hintText: "Cari Makanan",
                          contentPadding: EdgeInsets.all(20),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<RestaurantSearchProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.state == ResultState.hasData) {
                      return Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.resultSearch.restaurants.length,
                              itemBuilder: (context, index) {
                                var restaurant =
                                    state.resultSearch.restaurants[index];
                                return CardList(restaurant: restaurant);
                              }));
                    } else if (state.state == ResultState.noData) {
                      return const Center(
                          child: Text('Data Restaurant belum ditemukan'));
                    } else if (state.state == ResultState.error) {
                      if (state.message.contains("SocketException")) {
                        return const NoInternetConnection();
                      } else {
                        return Center(child: Text(state.message));
                      }
                    } else {
                      return const Center(child: Text(''));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, RestaurantList restaurant) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: restaurant.pictureId,
                child: Image.network(
                    "https://restaurant-api.dicoding.dev/images/medium/" +
                        restaurant.pictureId),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  restaurant.name,
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_city, color: Colors.grey),
                      const SizedBox(width: 2),
                      Text(
                        restaurant.city,
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        restaurant.rating.toString(),
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
