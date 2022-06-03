import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_food/helper/result_state.dart';
import 'package:restaurant_food/provider/restaurant_detail_provider.dart';
import 'package:restaurant_food/widget/no_internet_connection.dart';
import '../models/restaurant.dart';
import '../styles/styles.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final RestaurantList restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestaurantDetailProvider provider;
    return ChangeNotifierProvider(
      create: (_) {
        provider = RestaurantDetailProvider();
        return provider.getDetailRestaurant(restaurant.id);
      },
      child: Scaffold(
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              return detailsScreen(context, state.results.restaurant);
            } else if (state.state == ResultState.noData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.error) {
              if (state.message.contains("SocketException")) {
                return const NoInternetConnection();
              } else {
                return Center(child: Text(state.message));
              }
            } else {
              return const Center(
                child: Text('No data to displayed'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget detailsScreen(
      BuildContext context, RestaurantDetails restaurantDetails) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Hero(
                    tag: restaurant.pictureId,
                    child: Image.network(
                        "https://restaurant-api.dicoding.dev/images/large/" +
                            restaurant.pictureId)),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 16, left: 16, top: 8, bottom: 8),
              child: Text(
                restaurant.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.aclonica(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    restaurant.city,
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 18,
                        height: 1.2,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.grey,
                      ),
                      Text(
                        restaurant.rating.toString(),
                        style: GoogleFonts.robotoCondensed(
                            fontSize: 18,
                            height: 1.2,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, top: 28, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: GoogleFonts.eczar(
                        fontSize: 24,
                        height: 0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    restaurant.description,
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Foods',
                    style: GoogleFonts.eczar(
                        fontSize: 24,
                        height: 1,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 30,
                    width: (MediaQuery.of(context).size.width * 0.94),
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: restaurantDetails.menus!.foods.map(
                          (drinks) {
                            return SizedBox(
                              width: 120,
                              child: Card(
                                color: secondaryColor,
                                elevation: 2,
                                child: Center(
                                  child: Text(
                                    drinks.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.robotoCondensed(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList()),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Drinks',
                    style: GoogleFonts.eczar(
                        fontSize: 24,
                        height: 1,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 30,
                    width: (MediaQuery.of(context).size.width * 0.94),
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: restaurantDetails.menus!.drinks.map(
                          (drinks) {
                            return SizedBox(
                              width: 120,
                              child: Card(
                                color: secondaryColor,
                                elevation: 2,
                                child: Center(
                                  child: Text(
                                    drinks.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.robotoCondensed(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
