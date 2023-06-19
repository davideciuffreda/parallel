import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/app_widgets/access_log/access_log_card.dart';

import 'package:parallel/app_widgets/drawer/drawer_receptionist.dart';
import 'package:parallel/core/repositories/auth_repository.dart';
import 'package:parallel/pages/access_log/cubit/access_log_cubit.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';

class HomePageReceptionist extends StatefulWidget {
  @override
  State<HomePageReceptionist> createState() => _HomePageReceptionist();
}

class _HomePageReceptionist extends State<HomePageReceptionist> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AccessLogCubit>(context).getAccessLog();

    return Scaffold(
      drawer: BlocProvider(
        create: (context) => LoginBloc(AuthRepository()),
        child: DrawerReceptionist(),
      ),
      appBar: AppBar(
        title: Text("Storico prenotazioni"),
      ),
      body: BlocBuilder<AccessLogCubit, AccessLogState>(
        builder: (context, state) {
          if (!(state is AccessLogLoaded)) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: state.accessLog
                  .map(
                    (access) => AccessLogCard(
                      context: context,
                      access: access,
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
