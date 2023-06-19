import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parallel/core/models/wpBooking.dart';
import 'package:parallel/routing/router_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/bookings/bloc/booking_bloc.dart';

class BookingCard extends StatefulWidget {
  WpBooking wpBooking;

  BookingCard({required this.wpBooking, required BuildContext context});

  @override
  State<BookingCard> createState() => _BookingCard();
}

class _BookingCard extends State<BookingCard> {
  late SharedPreferences sharedPreferences;
  String? userRole;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getUserRole();
  }

  void getUserRole() {
    String? storedUserRole = sharedPreferences.getString('userRole');
    setState(() {
      userRole = storedUserRole;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      height: 130,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 12),
              width: 80,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: Image.asset("assets/images/booking.png"),
              ),
            ),
            SizedBox(width: 12),
            Container(
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.wpBooking.company.name +
                        ' | ' +
                        widget.wpBooking.headquarters.city,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.wpBooking.headquarters.address,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Data: ' +
                        widget.wpBooking.bookingDate
                            .toString()
                            .substring(0, 10),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Locale e postazione:\n' +
                        widget.wpBooking.workspace.name +
                        ' | ' +
                        widget.wpBooking.workplace.name,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 50,
              child: BlocBuilder<BookingBloc, BookingState>(
                builder: (context, state) {
                  return BlocListener<BookingBloc, BookingState>(
                    listener: (context, state) {
                      if (state is BookingDeleted) {
                        if (userRole.toString() == 'ROLE_EMPLOYEE') {
                          Navigator.of(context)
                              .pushReplacementNamed(homePageUserRoute);
                        } else if (userRole.toString() ==
                            'ROLE_COMPANY_MANAGER') {
                          Navigator.of(context)
                              .pushReplacementNamed(homePageManagerRoute);
                        }
                      } else if (state is BookingError) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Errore'),
                              content: Text(state.errorMessage),
                              actions: [
                                TextButton(
                                  child: Text('Annulla'),
                                  onPressed: () {
                                    if (userRole.toString() ==
                                        'ROLE_EMPLOYEE') {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              homePageUserRoute);
                                    } else if (userRole.toString() ==
                                        'ROLE_COMPANY_MANAGER') {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              homePageManagerRoute);
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: IconButton(
                      onPressed: () {
                        BlocProvider.of<BookingBloc>(context).add(DeleteBooking(
                          widget.wpBooking.workspace.id,
                          widget.wpBooking.workplace.id,
                          widget.wpBooking.id,
                        ));
                      },
                      icon: Icon(
                        Icons.delete_outline_outlined,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
