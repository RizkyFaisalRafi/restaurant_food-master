import 'package:flutter/material.dart';
import 'package:restaurant_food/common/notification_helper.dart';
import 'package:restaurant_food/view/detail_restaurant_page.dart';
import 'package:restaurant_food/view/favorite_restaurantlist.dart';
import 'package:restaurant_food/view/profile_and_settings_pages.dart';
import 'package:restaurant_food/view/search_page.dart';
import 'package:restaurant_food/view/restaurant_list_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  int bottomNavIndex = 0;
  final tabs = [
    const RestaurantListPage(),
    const SearchRestaurantPage(),
    const FavoriteRestaurantList(),
    const ProfileAndSettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant), label: 'Restaurant'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
        onTap: (selected) {
          setState(
                () {
              bottomNavIndex = selected;
            },
          );
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}
