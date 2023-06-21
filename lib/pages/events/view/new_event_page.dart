import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:parallel/app_widgets/drawer/drawer_manager.dart';
import 'package:parallel/app_widgets/headquarter/headquarter_company_card.dart';
import 'package:parallel/core/models/headquarterCompany.dart';
import 'package:parallel/pages/events/cubit/event_cubit.dart';
import 'package:parallel/routing/router_constants.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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
  List<HeadquarterCompany> hqList = [];
  FocusNode _focusNode = FocusNode();

  void clearController() {
    dateController.clear();
    nameController.clear();
    startTimeController.clear();
    endTimeController.clear();
    ticketsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EventCubit>(context).getHeadquartersByCompany();
    HeadquarterCompany hqSelected = HeadquarterCompany(
      id: 0,
      address: '',
      city: '',
      companyId: 0,
      description: '',
      phoneNumber: '',
      totalWorkplaces: 0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Crea evento"),
      ),
      drawer: DrawerManager(),
      body: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          return Column(
            children: [
              BlocBuilder<EventCubit, EventState>(
                builder: (context, state) {
                  if (state is EventHeadquartersByCompanyLoaded) {
                    return Column(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: state.headquarters
                                .map((hq) => HeadquarterCompanyCard(
                                      context: context,
                                      hq: hq,
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    );
                  } else if (state is EventHqSelected) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 12,
                      ),
                      child: Column(
                        children: [
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
                                      minTime:
                                          DateTime.now().add(Duration(days: 1)),
                                      showTitleActions: true,
                                      onConfirm: (date) {
                                        DateFormat dateFormatter =
                                            DateFormat('yyyy-MM-dd');
                                        dateController.text = dateFormatter
                                            .format(date)
                                            .toString();
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
                                    hintText: 'min. 2 e max. 50',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BlocListener<EventCubit, EventState>(
                                listener: (context, state) {
                                  if (state is EventCreated) {
                                    Navigator.of(context).pushReplacementNamed(
                                        homePageManagerRoute);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Evento creato con successo!',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        duration: Duration(seconds: 3),
                                        backgroundColor: Colors.green.shade300,
                                      ),
                                    );
                                  } else if (state is EventError) {
                                    clearController();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          state.error,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        duration: Duration(seconds: 3),
                                        backgroundColor: Colors.red.shade300,
                                      ),
                                    );
                                  }
                                },
                                child: TextButton(
                                  onPressed: () {
                                    if (state.hqId != 0 &&
                                        dateController.text.isNotEmpty &&
                                        nameController.text.isNotEmpty &&
                                        startTimeController.text.isNotEmpty &&
                                        endTimeController.text.isNotEmpty &&
                                        ticketsController.text.isNotEmpty &&
                                        int.parse(ticketsController.text) > 2 &&
                                        int.parse(ticketsController.text) <
                                            50) {
                                      BlocProvider.of<EventCubit>(context)
                                          .createNewEvent(
                                        state.hqId,
                                        nameController.text,
                                        dateController.text,
                                        startTimeController.text,
                                        endTimeController.text,
                                        int.parse(ticketsController.text),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Compila correttamente tutti i campi!',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                          duration: Duration(seconds: 3),
                                          backgroundColor: Colors.red.shade300,
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    "Crea",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else if (state is EventError) {
                    return TextButton(
                      child: Center(
                        child: Text('Qualcosa è andato storto, riprova!'),
                      ),
                      onPressed: () {
                        clearController();
                        Navigator.of(context)
                            .pushReplacementNamed(homePageManagerRoute);
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
