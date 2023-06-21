import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/app_widgets/card_label.dart';
import 'package:parallel/core/models/event.dart';
import 'package:parallel/pages/events/cubit/event_cubit.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';
import 'package:parallel/routing/router_constants.dart';

class EventCard extends StatefulWidget {
  Event event;

  EventCard({required this.event, required BuildContext context});

  @override
  State<EventCard> createState() => _EventCard();
}

class _EventCard extends State<EventCard> {
  bool isJoined = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 3,
      margin: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.asset(
                  "assets/images/event.jpg",
                  width: double.infinity,
                  height: 280,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: Column(
                  children: [
                    BlocBuilder<EventCubit, EventState>(
                      builder: (context, state) {
                        return FloatingActionButton.small(
                          backgroundColor: Colors.white.withOpacity(0.7),
                          onPressed: () {
                            if (!widget.event.alreadyBooked) {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Text('Iscrizione'),
                                  content: Text(
                                    'Confermi di volerti iscrivere a questo evento?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Annulla',
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        BlocProvider.of<EventCubit>(context)
                                            .setEventPresence(
                                          widget.event.headquarters.id,
                                          widget.event.id,
                                        );
                                        Navigator.of(context).pop;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Iscrizione effettuata con successo!',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            behavior: SnackBarBehavior.floating,
                                            duration: Duration(seconds: 3),
                                            backgroundColor:
                                                Colors.green.shade300,
                                          ),
                                        );
                                      },
                                      child: Text('Confermo'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          child: widget.event.alreadyBooked
                              ? Icon(
                                  Icons.bookmark_added_sharp,
                                  color: Colors.green.shade700,
                                )
                              : Icon(
                                  Icons.bookmark_add_sharp,
                                  color: Colors.black,
                                ),
                        );
                      },
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is LoginManagerState) {
                          return FloatingActionButton.small(
                            backgroundColor: Colors.white.withOpacity(0.7),
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Conferma'),
                                  content: Text(
                                    'Confermi di voler cancellare questo evento?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'Annulla');
                                      },
                                      child: Text('Annulla'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        BlocProvider.of<EventCubit>(context)
                                            .deleteEvent(
                                          widget.event.headquarters.id,
                                          widget.event.id,
                                        );
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                          homePageManagerRoute,
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Evento rimosso correttamente!',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            behavior: SnackBarBehavior.floating,
                                            duration: Duration(seconds: 3),
                                            backgroundColor:
                                                Colors.green.shade300,
                                          ),
                                        );
                                      },
                                      child: Text('Confermo'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Icon(
                              Icons.delete_outline_outlined,
                              color: Colors.red,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.event.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  child: CardLabel(
                    icon: Icon(Icons.share_location_sharp),
                    title: widget.event.company.name +
                        ', ' +
                        widget.event.headquarters.city,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CardLabel(
                      icon: Icon(Icons.people_alt_outlined),
                      title: widget.event.availablePlaces.toString() +
                          '/' +
                          widget.event.totalPlaces.toString(),
                    ),
                    CardLabel(
                      icon: Icon(Icons.date_range_sharp),
                      title: widget.event.eventDate.toString().substring(0, 10),
                    ),
                    CardLabel(
                      icon: Icon(Icons.hourglass_bottom_outlined),
                      title: widget.event.startTime.substring(0, 5) +
                          '-' +
                          widget.event.endTime.substring(0, 5),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
