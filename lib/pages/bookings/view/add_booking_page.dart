import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/app_widgets/drawer/drawer_employee.dart';
import 'package:parallel/app_widgets/drawer/drawer_manager.dart';
import 'package:parallel/app_widgets/workspace/workspace_card.dart';
import 'package:parallel/core/repositories/main_repository.dart';
import 'package:parallel/pages/bookings/bloc/booking_bloc.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';

class AddBookingPage extends StatefulWidget {
  @override
  State<AddBookingPage> createState() => _AddBookingPage();
}

class _AddBookingPage extends State<AddBookingPage> {
  MainRepository mainRepository = MainRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scegli il locale"),
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
          if (!(state is BookingDateSelected)) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: state.workspaces
                  .map(
                    (workspace) => WorkspaceCard(
                      bookingDate: state.bookingDate,
                      context: context,
                      workspace: workspace,
                      headquarterId: state.hqId,
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
