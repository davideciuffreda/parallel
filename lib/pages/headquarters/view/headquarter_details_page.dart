import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/app_widgets/card_label.dart';
import 'package:parallel/app_widgets/drawer/drawer_employee.dart';
import 'package:parallel/app_widgets/drawer/drawer_manager.dart';
import 'package:parallel/app_widgets/headquarter/headquarter_card.dart';
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            child: Image.network(
                              state.hq.imageUrl,
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
                                  state.hq.name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Column(
                                  children: [
                                    HeadquarterDetailCard(
                                      description: state.hq.address,
                                      icon: Icon(Icons.abc),
                                    ),
                                    HeadquarterDetailCard(
                                      description: state.hq.description,
                                      icon: Icon(Icons.abc),
                                    ),
                                    HeadquarterDetailCard(
                                      description:
                                          state.hq.workstations.toString(),
                                      icon: Icon(Icons.abc),
                                    ),
                                    HeadquarterDetailCard(
                                      description: state.hq.city,
                                      icon: Icon(Icons.abc),
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
                    padding: EdgeInsets.only(bottom: 8),
                    child: ElevatedButton(
                      style: ButtonStyle(elevation: MaterialStateProperty.all(5)),
                        onPressed: () {},
                        child: Text(
                          "Prenota ora!",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )),
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
