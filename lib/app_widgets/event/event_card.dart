import 'package:flutter/material.dart';
import 'package:parallel/app_widgets/card_label.dart';
import 'package:parallel/core/models/headquarter.dart';
import 'package:parallel/routing/router_constants.dart';

class EventCard extends StatefulWidget {
  final String image;
  final String name;
  final int tickets;
  final String headquarter_city;
  final String headquarter_name;
  final String date;

  const EventCard({
    required this.name,
    required this.headquarter_city,
    required this.headquarter_name,
    required this.tickets,
    required this.image,
    required this.date,
  });

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
                child: Image.network(
                  widget.image,
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
                    FloatingActionButton.small(
                      backgroundColor: Colors.white.withOpacity(0.7),
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Conferma iscrizione'),
                            content: Text('Vuoi iscriverti a questo evento?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'Annulla iscrizione');
                                  setState(() {
                                    isJoined = false;
                                  });
                                },
                                child: Text(
                                  'Annulla iscrizione',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'Certo!');
                                  setState(() {
                                    isJoined = true;
                                  });
                                },
                                child: Text('Certo!'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: isJoined
                          ? Icon(
                              Icons.bookmark_added_sharp,
                              color: Colors.green.shade700,
                            )
                          : Icon(
                              Icons.bookmark_add_sharp,
                              color: Colors.black,
                            ),
                    ),
                    FloatingActionButton.small(
                      backgroundColor: Colors.white.withOpacity(0.7),
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Informazioni'),
                            content:
                                Text('Ora di inizio: 9:00\nOra di fine: 12:00'),
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
                  widget.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CardLabel(
                      icon: Icon(Icons.share_location_sharp),
                      title: widget.headquarter_name +
                          ', ' +
                          widget.headquarter_city,
                    ),
                    CardLabel(
                      icon: Icon(Icons.people_outline),
                      title: widget.tickets.toString(),
                    ),
                    CardLabel(
                      icon: Icon(Icons.date_range_sharp),
                      title: widget.date.toString(),
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
