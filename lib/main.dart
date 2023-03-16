import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parallel/pages/account/account_page.dart';
import 'package:parallel/pages/bookings/bookings_page.dart';
import 'package:parallel/pages/events/events_page.dart';
import 'package:parallel/pages/headquarters/favorites_headquarters_page.dart';
import 'package:parallel/pages/forum/forum_page.dart';
import 'package:parallel/pages/headquarters/headquarters_page.dart';
import 'package:parallel/pages/employee/home_page_user.dart';
import 'package:parallel/pages/notifications/notifications_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parallel',
      theme: ThemeData(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
      ),
      initialRoute: HomePageUser.routeName,
      routes: {
        HomePageUser.routeName: (ctx) => HomePageUser(),
        EventsPage.routeName: (ctx) => EventsPage(),
        ForumPage.routeName: (ctx) => ForumPage(),
        HeadquartersPage.routeName: (ctx) => HeadquartersPage(),
        AccountPage.routeName: (ctx) => AccountPage(),
        FavoritesHeadquartersPage.routeName: (ctx) =>
            FavoritesHeadquartersPage(),
        BookingsPage.routeName: (ctx) => BookingsPage(),
        NotificationsPage.routeName: (ctx) => NotificationsPage(),
      },
    );
  }
}
