import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:parallel/app_widgets/access_log/access_log_card.dart';

import 'package:parallel/app_widgets/drawer/drawer_receptionist.dart';
import 'package:parallel/core/models/access.dart';
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
  final storage = FlutterSecureStorage();
  int hqID = 0;
  String? userToken;
  List<Access> accessLogList = [];

  @override
  void initState() {
    super.initState();
    getToken();
    initSharedPreferences();
  }

  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getScopeId();
  }

  void getScopeId() {
    setState(() {
      hqID = sharedPreferences.getInt('scopeId') ?? 0;
    });
  }

  void getToken() async {
    String? storedToken = await storage.read(key: 'userToken');
    setState(() {
      userToken = storedToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AccessLogCubit>(context).getAccessLog(hqID, userToken!);

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
