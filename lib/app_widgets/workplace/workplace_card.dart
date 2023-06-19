import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parallel/core/models/workplace.dart';
import 'package:parallel/pages/bookings/bloc/booking_bloc.dart';
import 'package:parallel/routing/router_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkplaceCard extends StatefulWidget {
  String bookingDate;
  int workspaceId;
  Workplace workplace;

  WorkplaceCard({
    required this.bookingDate,
    required this.workspaceId,
    required this.workplace,
    required BuildContext context,
  });

  @override
  State<WorkplaceCard> createState() => _WorkplaceCard();
}

class _WorkplaceCard extends State<WorkplaceCard> {
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
      width: double.infinity,
      height: 88,
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
              width: 60,
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: Image.asset("assets/images/workplace.png"),
              ),
            ),
            SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Postazione ' + widget.workplace.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Tipologia: ' + widget.workplace.type,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            SizedBox(width: 12),
            BlocBuilder<BookingBloc, BookingState>(
              builder: (context, state) {
                return BlocListener<BookingBloc, BookingState>(
                  listener: (context, state) {
                    if (state is BookingCreated) {
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
                                  if (userRole.toString() == 'ROLE_EMPLOYEE') {
                                    Navigator.of(context).pushReplacementNamed(
                                        homePageUserRoute);
                                  } else if (userRole.toString() ==
                                      'ROLE_COMPANY_MANAGER') {
                                    Navigator.of(context).pushReplacementNamed(
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
                  child: TextButton(
                    onPressed: () {
                      BlocProvider.of<BookingBloc>(context)
                          .add(CreateBooking(
                        widget.workspaceId,
                        widget.workplace.id,
                        widget.bookingDate,
                      ));
                    },
                    child: Text("Prenota"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
