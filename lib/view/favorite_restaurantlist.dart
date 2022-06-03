import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_food/helper/result_state.dart';
import 'package:restaurant_food/provider/database_provider.dart';
import 'package:restaurant_food/widget/card_list.dart';

class FavoriteRestaurantList extends StatefulWidget {
  const FavoriteRestaurantList({Key? key}) : super(key: key);

  @override
  State<FavoriteRestaurantList> createState() => _FavoriteRestaurantListState();
}

class _FavoriteRestaurantListState extends State<FavoriteRestaurantList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: _buildItem(),
        ),
      ),
    );
  }
}

Widget _buildItem() {
  return Consumer<DatabaseProvider>(
    builder: (context, provider, child) {
      if (provider.state == ResultState.hasData) {
        return ListView.builder(
          itemCount: provider.favorite.length,
          itemBuilder: (context, index) {
            return CardList(restaurant: provider.favorite[index]);
          },
        );
      } else {
        return Center(
            child: Text(provider.message,
                style: GoogleFonts.robotoCondensed(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400)));
      }
    },
  );
}
