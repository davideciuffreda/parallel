import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/app_widgets/headquarter/card_label.dart';

import 'package:parallel/core/models/workspace/workspace.dart';
import 'package:parallel/pages/bookings/bloc/booking_bloc.dart';
import 'package:parallel/pages/workspace/workplaces_list.dart';

class WorkspaceCard extends StatefulWidget {
  String bookingDate;
  Workspace workspace;
  int headquarterId;

  WorkspaceCard({
    required this.bookingDate,
    required this.headquarterId,
    required this.workspace,
    required BuildContext context,
  });

  @override
  State<WorkspaceCard> createState() => _WorkspaceCard();
}

class _WorkspaceCard extends State<WorkspaceCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<BookingBloc>(context).add(WorkspaceAdded(
          widget.bookingDate,
          widget.headquarterId,
          widget.workspace.id,
        ));
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => WorkplacesListPage(
              headquarterId: widget.headquarterId,
              workspaceId: widget.workspace.id,
              bookingDate: widget.bookingDate,
            ),
          ),
        );
      },
      child: Card(
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
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.asset(
                "assets/images/workspace.jpg",
                width: double.infinity,
                height: 280,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.workspace.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CardLabel(
                        icon: Icon(Icons.room_preferences_outlined),
                        title: widget.workspace.type.replaceAll('_', ' '),
                      ),
                      CardLabel(
                        icon: Icon(Icons.format_list_numbered_outlined),
                        title: widget.workspace.floor,
                      ),
                      CardLabel(
                        icon: Icon(Icons.people_alt_outlined),
                        title: widget.workspace.availableWorkplaces.toString() +
                            '/' +
                            widget.workspace.totalWorkplaces.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
