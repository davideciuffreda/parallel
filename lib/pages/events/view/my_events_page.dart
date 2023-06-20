import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/app_widgets/drawer/drawer_employee.dart';
import 'package:parallel/app_widgets/drawer/drawer_manager.dart';
import 'package:parallel/app_widgets/event/my_event_card.dart';
import 'package:parallel/pages/events/cubit/event_cubit.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';

class MyEventsPage extends StatefulWidget {
  @override
  State<MyEventsPage> createState() => _MyEventsPage();
}

class _MyEventsPage extends State<MyEventsPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EventCubit>(context).getMyEvents();

    return Scaffold(
      appBar: AppBar(
        title: Text("I miei eventi"),
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
      body: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if (!(state is MyEventsLoaded)) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: state.events
                  .map(
                    (event) => MyEventCard(
                      eventBooking: event,
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
