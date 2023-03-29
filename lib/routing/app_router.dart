import 'package:flutter/material.dart';
import 'package:parallel/pages/account/account_page.dart';
import 'package:parallel/pages/account/edit_account_page.dart';
import 'package:parallel/pages/bookings/bookings_page.dart';
import 'package:parallel/pages/events/event_details_page.dart';
import 'package:parallel/pages/headquarters/headquarter_details_page.dart';
import 'package:parallel/pages/home/home_page_user.dart';
import 'package:parallel/pages/events/events_page.dart';
import 'package:parallel/pages/forum/forum_page.dart';
import 'package:parallel/pages/headquarters/favorite_headquarters/favorites_headquarters_page.dart';
import 'package:parallel/pages/headquarters/headquarters_page.dart';
import 'package:parallel/pages/login/view/login_page.dart';
import 'package:parallel/routing/router_constants.dart';
import 'package:parallel/pages/home/home_page_receptionist.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case loginPageRoute:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case homePageUserRoute:
        return MaterialPageRoute(builder: (context) => HomePageUser());
      case homePageReceptionistRoute:
        return MaterialPageRoute(builder: (context) => HomePageReceptionist());
      case headquartersPageRoute:
        return MaterialPageRoute(builder: (context) => HeadquartersPage());
      case headquarterDetailsPageRoute:
        return MaterialPageRoute(
            builder: (context) => HeadquarterDetailsPage());
      case eventDetailsPageRoute:
        return MaterialPageRoute(
            builder: (context) => EventDetailsPage());
      case favHeadquartersPageRoute:
        return MaterialPageRoute(
            builder: (context) => FavoritesHeadquartersPage());
      case forumPageRoute:
        return MaterialPageRoute(builder: (context) => ForumPage());
      case eventsPageRoute:
        return MaterialPageRoute(builder: (context) => EventsPage());
      case bookingsPageRoute:
        return MaterialPageRoute(builder: (context) => BookingsPage());
      case accountPageRoute:
        return MaterialPageRoute(builder: (context) => AccountPage());
      case editAccountPageRoute:
        return MaterialPageRoute(builder: (context) => EditAccountPage());
      default:
        return MaterialPageRoute(builder: (context) => HomePageUser());
    }
  }
}
