import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/core/models/eventBooking.dart';

import 'package:parallel/pages/events/cubit/event_cubit.dart';
import 'package:parallel/routing/router_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyEventCard extends StatefulWidget {
  EventBooking eventBooking;

  MyEventCard({required this.eventBooking, required BuildContext context});

  @override
  State<MyEventCard> createState() => _MyEventCard();
}

class _MyEventCard extends State<MyEventCard> {
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
                    widget.eventBooking.event.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.eventBooking.company.name +
                        ' | ' +
                        widget.eventBooking.headquarters.city,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.eventBooking.headquarters.address,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Data: ' +
                        widget.eventBooking.bookedOn
                            .toString()
                            .substring(0, 10),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 50,
              child: BlocBuilder<EventCubit, EventState>(
                builder: (context, state) {
                  return BlocListener<EventCubit, EventState>(
                    listener: (context, state) {
                      if (state is EventBookingDeleted) {
                        if (userRole.toString() == 'ROLE_EMPLOYEE') {
                          Navigator.of(context)
                              .pushReplacementNamed(homePageUserRoute);
                        } else if (userRole.toString() ==
                            'ROLE_COMPANY_MANAGER') {
                          Navigator.of(context)
                              .pushReplacementNamed(homePageManagerRoute);
                        }
                      } else if (state is EventError) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Errore'),
                              content: Text(state.error),
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
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Cancellazione'),
                              content: Text(
                                'Confermi di voler cancellare l\'iscrizione?',
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Annulla'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Confermo'),
                                  onPressed: () {
                                    BlocProvider.of<EventCubit>(context)
                                        .deleteEventSubscription(
                                      widget.eventBooking.headquarters.id,
                                      widget.eventBooking.event.id,
                                      widget.eventBooking.id,
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
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
