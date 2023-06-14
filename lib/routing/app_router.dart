import 'package:flutter/material.dart';
import 'package:parallel/pages/account/view/account_page.dart';
import 'package:parallel/pages/account/view/edit_account_page.dart';
import 'package:parallel/pages/account/view/edit_password_page.dart';
import 'package:parallel/pages/bookings/view/add_booking_page.dart';
import 'package:parallel/pages/bookings/view/bookings_page.dart';
import 'package:parallel/pages/events/view/events_page.dart';
import 'package:parallel/pages/events/view/new_event_page.dart';
import 'package:parallel/pages/headquarters/view/headquarter_details_page.dart';
import 'package:parallel/pages/headquarters/view/headquarters_page.dart';
import 'package:parallel/pages/headquarters/view/favorite_headquarters_page.dart';
import 'package:parallel/pages/home/home_page_manager.dart';
import 'package:parallel/pages/home/home_page_user.dart';
import 'package:parallel/pages/login/view/login_page.dart';
import 'package:parallel/routing/router_constants.dart';
import 'package:parallel/pages/home/home_page_receptionist.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPageRoute:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case homePageUserRoute:
        return MaterialPageRoute(builder: (context) => HomePageUser());
      case homePageReceptionistRoute:
        return MaterialPageRoute(builder: (context) => HomePageReceptionist());
      case homePageManagerRoute:
        return MaterialPageRoute(builder: (context) => HomePageManager());
      case headquartersPageRoute:
        return MaterialPageRoute(builder: (context) => HeadquartersPage());
      case headquarterDetailsPageRoute:
        var parameters = settings.arguments as Map<String, dynamic>;
        var headquarterId = parameters['headquarterId'];
        return MaterialPageRoute(
            builder: (context) => HeadquarterDetailsPage(id: headquarterId,));
      case favHeadquartersPageRoute:
        return MaterialPageRoute(
            builder: (context) => FavoriteHeadquartersPage());
      case eventsPageRoute:
        return MaterialPageRoute(builder: (context) => EventsPage());
      case bookingsPageRoute:
        return MaterialPageRoute(builder: (context) => BookingsPage());
      case addBookingPageRoute:
        return MaterialPageRoute(builder: (context) => AddBookingPage());
      case accountPageRoute:
        return MaterialPageRoute(builder: (context) => AccountPage());
      case editAccountPageRoute:
        return MaterialPageRoute(builder: (context) => EditAccountPage());
      case editPasswordPageRoute:
        return MaterialPageRoute(builder: (context) => EditPasswordPage());
      case newEventPageRoute:
        return MaterialPageRoute(builder: (context) => NewEventPage());
      default:
        return MaterialPageRoute(builder: (context) => LoginPage());
    }
  }
}
