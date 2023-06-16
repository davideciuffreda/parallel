import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:parallel/app_widgets/drawer/drawer_manager.dart';
import 'package:parallel/core/models/company.dart';
import 'package:parallel/core/models/headquarter.dart';
import 'package:parallel/core/repositories/main_repository.dart';
import 'package:parallel/pages/events/cubit/event_cubit.dart';
import 'package:parallel/routing/router_constants.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewEventPage extends StatefulWidget {
  @override
  State<NewEventPage> createState() => _NewEventPage();
}

class _NewEventPage extends State<NewEventPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController ticketsController = TextEditingController();
  MainRepository mainRepository = MainRepository();
  late SharedPreferences sharedPreferences;

  List<Headquarter> hqList = [];

  FocusNode _focusNode = FocusNode();

  Future<List<Headquarter>> getAllHeadquarters() async {
    hqList = await mainRepository.getHeadquarters();
    return hqList;
  }

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
    getAllHeadquarters();
  }

  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void setHeadquarterId(int id) async {
    await sharedPreferences.setInt('headquarterId', id);
  }

  @override
  Widget build(BuildContext context) {
    Headquarter hqSelected = Headquarter(
      id: 0,
      company: Company(
          id: 0,
          name: "",
          city: "",
          address: "",
          phoneNumber: "",
          description: "",
          websiteUrl: ""),
      city: "",
      address: "",
      phoneNumber: "",
      description: "",
      totalWorkplaces: 0,
      favorite: false,
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Crea evento"),
        ),
        drawer: DrawerManager(),
        body: SafeArea(
          child: BlocBuilder<EventCubit, EventState>(
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 12,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Scegli la sede",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 4),
                            PopupMenuButton<Headquarter>(
                              itemBuilder: (BuildContext context) {
                                return hqList.map((Headquarter headquarters) {
                                  return PopupMenuItem<Headquarter>(
                                    value: headquarters,
                                    child: Text(headquarters.company.name +
                                        ' | ' +
                                        headquarters.city),
                                  );
                                }).toList();
                              },
                              onSelected: (value) => hqSelected = value,
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Nome',
                            hintText: 'Inserisci il nome dell\'evento',
                          ),
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150,
                              child: TextField(
                                controller: startTimeController,
                                keyboardType: TextInputType.datetime,
                                decoration: InputDecoration(
                                  labelText: 'Ora di inizio',
                                ),
                              ),
                            ),
                            SizedBox(width: 4),
                            Container(
                              width: 150,
                              child: TextField(
                                controller: endTimeController,
                                keyboardType: TextInputType.datetime,
                                decoration: InputDecoration(
                                  labelText: 'Ora di fine',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150,
                              child: TextField(
                                controller: dateController,
                                focusNode: _focusNode,
                                decoration: InputDecoration(
                                  labelText: 'Data',
                                ),
                                onTap: () {
                                  DatePicker.showDatePicker(
                                    context,
                                    showTitleActions: true,
                                    onConfirm: (date) {
                                      DateFormat dateFormatter =
                                          DateFormat('yyyy-MM-dd');
                                      dateController.text =
                                          dateFormatter.format(date).toString();
                                    },
                                    currentTime:
                                        DateTime.now().add(Duration(days: 1)),
                                  );
                                  _focusNode.unfocus();
                                },
                              ),
                            ),
                            SizedBox(width: 4),
                            Container(
                              width: 150,
                              child: TextField(
                                controller: ticketsController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Numero di posti',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                //print(sharedPreferences.getInt('headquarterId').toString());

                                BlocProvider.of<EventCubit>(context)
                                    .createNewEvent(
                                  hqSelected.id,
                                  nameController.text,
                                  dateController.text,
                                  startTimeController.text,
                                  endTimeController.text,
                                  int.parse(ticketsController.text),
                                );
                                Navigator.of(context)
                                    .pushReplacementNamed(homePageManagerRoute);
                              },
                              child: Text(
                                "Crea",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
