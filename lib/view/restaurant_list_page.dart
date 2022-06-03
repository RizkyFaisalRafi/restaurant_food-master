import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_food/helper/result_state.dart';
import 'package:restaurant_food/provider/restaurant_list_provider.dart';
import 'package:restaurant_food/widget/card_list.dart';
import 'package:restaurant_food/widget/no_internet_connection.dart';
import '../models/restaurant.dart';
import 'detail_restaurant_page.dart';

class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  RestaurantListProvider provider = RestaurantListProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return provider.getListResult();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: _buildList(context),
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    String judul = "Restaurant Kita";
    String subJudul = "Rekomendasi Restaurant Untuk Pecinta Kuliner!";
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.only(top: 24)),
        Text(judul,
            style: GoogleFonts.eczar(
                fontSize: 32,
                height: 0.5,
                color: Colors.black,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.start),
        Text(subJudul,
            style: GoogleFonts.robotoCondensed(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),
            textAlign: TextAlign.start),
        const SizedBox(height: 16),
        Consumer<RestaurantListProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.resultList.restaurants.length,
                      itemBuilder: (context, index) {
                        return CardList(
                            restaurant: state.resultList.restaurants[index]);
                      }));
            } else if (state.state == ResultState.noData) {
              return const Center(child: Text('Data Restaurant Tidak Ada'));
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
        )
      ],
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
                      ),
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
