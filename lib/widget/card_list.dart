import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_food/models/restaurant.dart';
import 'package:restaurant_food/provider/database_provider.dart';

import '../view/detail_restaurant_page.dart';

class CardList extends StatelessWidget {
  final RestaurantList restaurant;

  const CardList({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
          future: provider.isFavorited(restaurant.id),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(restaurant.name,
                                    style: GoogleFonts.robotoCondensed(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ))),
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.location_city,
                                        color: Colors.grey),
                                    const SizedBox(width: 2),
                                    Text(restaurant.city,
                                        style: GoogleFonts.robotoCondensed(
                                          fontSize: 18,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                        ))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(width: 2),
                                        Text(restaurant.rating.toString(),
                                            style: GoogleFonts.robotoCondensed(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: isFavorited
                                          ? IconButton(
                                              icon: Icon(Icons.favorite),
                                              onPressed: () =>
                                                  provider.removeBookmark(
                                                      restaurant.id),
                                            )
                                          : IconButton(
                                              icon: Icon(Icons.favorite_border),
                                              color: Colors.grey,
                                              onPressed: () => provider
                                                  .addFavorite(restaurant),
                                            ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ]),
                    )));
          });
    });
  }
}
