// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/app_widgets/booking/booking_card.dart';
import 'package:parallel/app_widgets/drawer/drawer_employee.dart';
import 'package:parallel/app_widgets/drawer/drawer_manager.dart';
import 'package:parallel/pages/bookings/bloc/booking_bloc.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';

class BookingsPage extends StatefulWidget {
  @override
  State<BookingsPage> createState() => _BookingsPage();
}

class _BookingsPage extends State<BookingsPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BookingBloc>(context).add(GetAllMyWpBookings());

    return Scaffold(
      appBar: AppBar(
        title: Text("Prenotazioni"),
      ),
      drawer: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginUserState) {
            return DrawerEmployee();
          } else if (state is LoginManagerState) {
            return DrawerManager();
          } else {
            return Text("Non dovresti essere arrivato a questo punto!");
          }
        },
      ),
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          if (!(state is BookingsLoaded)) {
            return Center(child: CircularProgressIndicator());
          }

          ///Lista di widget che rappresentano le prenotazioni
          return SingleChildScrollView(
            child: Column(
              children: state.myBookings
                  .map(
                    (wpBooking) => BookingCard(
                      wpBooking: wpBooking,
                      context: context,
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
