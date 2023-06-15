import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:parallel/app_widgets/drawer/drawer_employee.dart';
import 'package:parallel/app_widgets/drawer/drawer_manager.dart';
import 'package:parallel/app_widgets/headquarter/headquarter_description_card.dart';
import 'package:parallel/app_widgets/headquarter/headquarter_detail_card.dart';
import 'package:parallel/core/models/headquarter.dart';
import 'package:parallel/pages/bookings/bloc/add_booking_bloc.dart';
import 'package:parallel/pages/headquarters/cubit/headquarter_cubit.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';
import 'package:parallel/routing/router_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeadquarterDetailsPage extends StatefulWidget {
  final int id;

  HeadquarterDetailsPage({super.key, required this.id});

  @override
  State<HeadquarterDetailsPage> createState() => _HeadquarterDetailsPageState();
}

class _HeadquarterDetailsPageState extends State<HeadquarterDetailsPage> {
  TextEditingController dateController = TextEditingController(text: '');
  FocusNode _focusNode = FocusNode();
  late SharedPreferences sharedPreferences;

  String? userRole;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getUserRole();
  }

  void getUserRole() {
    String? storedUserRole = sharedPreferences.getString('userRole');
    setState(() {
      userRole = storedUserRole;
    });
  }

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
              Headquarter headquarter = state.hq;
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
                            Stack(
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
                                BlocListener<HeadquarterCubit,
                                    HeadquarterState>(
                                  listener: (context, state) {
                                    if (state is HeadquarterFavorite) {
                                      if (userRole.toString() ==
                                          'ROLE_EMPLOYEE') {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                homePageUserRoute);
                                      } else if (userRole.toString() ==
                                          'ROLE_COMPANY_MANAGER') {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                homePageManagerRoute);
                                      } else if (userRole.toString() ==
                                          'ROLE_HEADQUARTERS_RECEPTIONIST') {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                homePageReceptionistRoute);
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Errore'),
                                              content: Text(
                                                  'Si è verificato un errore durante l\'operazione.'),
                                              actions: [
                                                TextButton(
                                                  child: Text('Chiudi'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    }
                                  },
                                  child: Positioned(
                                    right: 8,
                                    top: 8,
                                    child: FloatingActionButton.small(
                                      backgroundColor: Colors.white70,
                                      onPressed: () {
                                        BlocProvider.of<HeadquarterCubit>(
                                                context)
                                            .setFavoriteHeadquarter(
                                                headquarter.id);
                                      },
                                      child: headquarter.favorite == true
                                          ? Icon(
                                              Icons.star_outlined,
                                              color: Colors.orange.shade400,
                                            )
                                          : Icon(
                                              Icons.star_border_outlined,
                                              color: Colors.orange.shade400,
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    headquarter.company.name,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Column(
                                    children: [
                                      HeadquarterDetailCard(
                                        description: headquarter.address +
                                            ', ' +
                                            headquarter.city,
                                        icon:
                                            Icon(Icons.share_location_outlined),
                                      ),
                                      SizedBox(height: 6),
                                      HeadquarterDescriptionCard(
                                        description: headquarter.description,
                                        icon: Icon(Icons.description_outlined),
                                      ),
                                      SizedBox(height: 6),
                                      HeadquarterDetailCard(
                                        description: headquarter.phoneNumber,
                                        icon: Icon(Icons.phone_rounded),
                                      ),
                                      SizedBox(height: 6),
                                      HeadquarterDetailCard(
                                        description: headquarter.totalWorkplaces
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
                    BlocBuilder<AddBookingBloc, AddBookingState>(
                      builder: (context, state) {
                        if (dateController.text.isEmpty) {
                          BlocProvider.of<AddBookingBloc>(context)
                              .add(CleaningBookingDate());
                        }
                        if (state is AddBookingError) {
                          return Center(
                            child: Text(
                              state.errorMessage,
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          );
                        } else {
                          return Text('');
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
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
                                  maxTime:
                                      DateTime.now().add(Duration(days: 1095)),
                                  onConfirm: (date) {
                                    dateController.text =
                                        date.toString().substring(0, 10);
                                    BlocProvider.of<AddBookingBloc>(context)
                                        .add(
                                      BookingDateAdded(
                                        dateController.text,
                                      ),
                                    );
                                  },
                                );
                                dateController.clear();
                                _focusNode.unfocus();
                              },
                            ),
                          ),
                          BlocBuilder<AddBookingBloc, AddBookingState>(
                            builder: (context, state) {
                              if (state is BookingDateSelected) {
                                return FloatingActionButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacementNamed(
                                        addBookingPageRoute);
                                  },
                                  child: Icon(Icons.arrow_forward_ios_outlined),
                                );
                              } else {
                                return FloatingActionButton(
                                  backgroundColor: Colors.grey.shade400,
                                  onPressed: null,
                                  child: Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                    color: Colors.white,
                                  ),
                                );
                              }
                            },
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
