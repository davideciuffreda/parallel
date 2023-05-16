import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/app_widgets/event/event_card.dart';
import 'package:parallel/pages/events/cubit/event_cubit.dart';

class EventsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EventCubit>(context).getEvents();

    return Scaffold(
      body: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if (!(state is EventsLoaded)) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: state.events
                  .map((ev) => EventCard(
                        context: context,
                        event: ev,
                      ))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
