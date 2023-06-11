import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:parallel/app_widgets/drawer/drawer_employee.dart';
import 'package:parallel/app_widgets/drawer/drawer_manager.dart';
import 'package:parallel/app_widgets/headquarter/headquarter_description_card.dart';
import 'package:parallel/app_widgets/headquarter/headquarter_detail_card.dart';
import 'package:parallel/pages/headquarters/cubit/headquarter_cubit.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';
import 'package:parallel/routing/router_constants.dart';

class HeadquarterDetailsPage extends StatefulWidget {
  final int id;

  HeadquarterDetailsPage({super.key, required this.id});

  @override
  State<HeadquarterDetailsPage> createState() => _HeadquarterDetailsPageState();
}

class _HeadquarterDetailsPageState extends State<HeadquarterDetailsPage> {
  TextEditingController dateController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HeadquarterCubit>(context).getHeadquarterById(widget.id);

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
      body: SingleChildScrollView(
        child: BlocBuilder<HeadquarterCubit, HeadquarterState>(
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
                                        icon:
                                            Icon(Icons.share_location_outlined),
                                      ),
                                      SizedBox(height: 6),
                                      HeadquarterDescriptionCard(
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
                                        description: state.hq.totalWorkplaces
                                                .toString() +
                                            ' postazioni',
                                        icon: Icon(Icons.group_outlined),
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
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 70,
                            width: 180,
                            child: TextField(
                              focusNode: _focusNode,
                              controller: dateController,
                              decoration: InputDecoration(
                                labelText: 'Data di prenotazione',
                              ),
                              onTap: () {
                                DatePicker.showDatePicker(
                                  context,
                                  currentTime:
                                      DateTime.now().add(Duration(days: 1)),
                                  minTime:
                                      DateTime.now().add(Duration(days: 1)),
                                  onConfirm: (date) {
                                    dateController.text =
                                        date.toString().substring(0, 10);
                                  },
                                );
                                _focusNode.unfocus();
                              },
                            ),
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(addBookingPageRoute);
                            },
                            //child: Icon(Icons.edit_calendar_outlined),
                            child: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
