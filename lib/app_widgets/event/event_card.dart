import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/app_widgets/card_label.dart';
import 'package:parallel/core/models/event.dart';
import 'package:parallel/pages/events/cubit/event_cubit.dart';

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
                    FloatingActionButton.small(
                      backgroundColor: Colors.white.withOpacity(0.7),
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Informazioni'),
                            content: Text(
                              'Ora di inizio: ${widget.event.startTime.substring(0, 5)}\n' +
                                  'Ora di fine: ${widget.event.endTime.substring(0, 5)}\n',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'Chiudi');
                                },
                                child: Text(
                                  'Chiudi',
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Icon(
                        Icons.info_outline,
                        color: Colors.black,
                      ),
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
