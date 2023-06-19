import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/app_widgets/drawer/drawer_employee.dart';
import 'package:parallel/app_widgets/drawer/drawer_manager.dart';
import 'package:parallel/app_widgets/workplace/workplace_card.dart';
import 'package:parallel/pages/bookings/bloc/booking_bloc.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';

class WorkplacesListPage extends StatefulWidget {
  int headquarterId;
  int workspaceId;
  String bookingDate;

  WorkplacesListPage({
    required this.bookingDate,
    required this.headquarterId,
    required this.workspaceId,
  });

  @override
  State<WorkplacesListPage> createState() => _WorkplacesListPageState();
}

class _WorkplacesListPageState extends State<WorkplacesListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scegli la postazione"),
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
          if (!(state is WorkspaceSelected)) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: state.workplaces
                  .map(
                    (workplace) => WorkplaceCard(
                      workplace: workplace,
                      bookingDate: widget.bookingDate,
                      workspaceId: widget.workspaceId,
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
