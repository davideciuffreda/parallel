import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/app_widgets/access_log/access_log_card.dart';

import 'package:parallel/app_widgets/drawer/drawer_receptionist.dart';
import 'package:parallel/core/repositories/auth_repository.dart';
import 'package:parallel/pages/access_log/cubit/access_log_cubit.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageReceptionist extends StatefulWidget {
  @override
  State<HomePageReceptionist> createState() => _HomePageReceptionist();
}

class _HomePageReceptionist extends State<HomePageReceptionist> {
  late SharedPreferences sharedPreferences;
  int hqID = 0;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getScopeId();
  }

  void getScopeId() {
    setState(() {
      hqID = sharedPreferences.getInt('scopeId') ?? 0;
      print(hqID);
    });
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AccessLogCubit>(context).getAccessLog(hqID);

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
          Duration(seconds: 3);
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
