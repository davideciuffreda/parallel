import 'package:flutter/material.dart';
import 'package:parallel/app_widgets/drawer/drawer_manager.dart';
import 'package:parallel/routing/router_constants.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class NewEventPage extends StatefulWidget {
  @override
  State<NewEventPage> createState() => _NewEventPage();
}

class _NewEventPage extends State<NewEventPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController headquarterController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController ticketsController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 12,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        hintText: 'Inserisci il nome dell\'evento',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: dateController,
                      decoration: InputDecoration(
                        labelText: 'Data',
                        hintText: 'Seleziona la data in cui si terrà l\'evento',
                      ),
                      onTap: () {
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          onConfirm: (date) {
                            dateController.text = date.toString();
                          },
                          currentTime: DateTime.now(),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: headquarterController,
                      decoration: InputDecoration(
                        labelText: 'Sede',
                        hintText: 'Inserisci la sede in cui si terrà l\'evento',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: ticketsController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Numero di posti',
                        hintText:
                            'Inserisci il numero massimo di posti per l\'evento',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: imageUrlController,
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                        labelText: 'Locandina',
                        hintText:
                            'Inserisci l\'url della locandina dell\'evento',
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue.shade50, // Colore di sfondo
                            foregroundColor: Colors.blue, // Colore del testo
                            side: BorderSide(
                                color:
                                    Colors.lightBlue.shade50), // Colore del bordo e spessore
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
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
          ),
        ),
      ),
    );
  }
}
