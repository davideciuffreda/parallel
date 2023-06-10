import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/app_widgets/drawer/drawer_employee.dart';
import 'package:parallel/app_widgets/drawer/drawer_manager.dart';
import 'package:parallel/app_widgets/headquarter/headquarter_detail_card.dart';
import 'package:parallel/pages/headquarters/cubit/headquarter_cubit.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';

class HeadquarterDetailsPage extends StatelessWidget {
  final int id;

  HeadquarterDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HeadquarterCubit>(context).getHeadquarterById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text("Dettagli sede"),
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
      body: BlocBuilder<HeadquarterCubit, HeadquarterState>(
        builder: (context, state) {
          if (state is HeadquarterDetailLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
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
                              "assets/images/city.jpg",
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
                                  state.hq.company.name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Column(
                                  children: [
                                    HeadquarterDetailCard(
                                      description: state.hq.address +
                                          ', ' +
                                          state.hq.city,
                                      icon: Icon(Icons.share_location_outlined),
                                    ),
                                    SizedBox(height: 6),
                                    HeadquarterDetailCard(
                                      description: state.hq.description,
                                      icon: Icon(Icons.description_outlined),
                                    ),
                                    SizedBox(height: 6),
                                    HeadquarterDetailCard(
                                      description: state.hq.phoneNumber,
                                      icon: Icon(Icons.phone_rounded),
                                    ),
                                    SizedBox(height: 6),
                                    HeadquarterDetailCard(
                                      description: state.hq.company.websiteUrl,
                                      icon: Icon(Icons.link_outlined),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: FloatingActionButton(
                      onPressed: () {},
                      child: Icon(Icons.work_history_outlined),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text("Ops... c'è stato un errore nel caricamento!"),
            );
          }
        },
      ),
    );
  }
}
