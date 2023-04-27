import 'package:flutter/material.dart';
import 'package:parallel/app_widgets/drawer/drawer_manager.dart';
import 'package:parallel/routing/router_constants.dart';

class NewEventPage extends StatefulWidget {
  @override
  State<NewEventPage> createState() => _NewEventPage();
}

class _NewEventPage extends State<NewEventPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController headquarterController = TextEditingController();
  TextEditingController cityController = TextEditingController();
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
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nome',
                        hintText: 'Inserisci il nome dell\'evento',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: cityController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Città',
                        hintText:
                            'Inserisci la città in cui si terrà l\'evento',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: headquarterController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Sede',
                        hintText: 'Inserisci la sede in cui si terrà l\'evento',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: ticketsController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Numero di posti',
                        hintText:
                            'Inserisci il numero massimo di posti per l\'evento',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: imageUrlController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Locandina',
                        hintText: 'Inserisci l\'url della locandina dell\'evento',
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(homePageManagerRoute);
                      },
                      child: Text(
                        "Crea!",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
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
