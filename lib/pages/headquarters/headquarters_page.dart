import 'package:flutter/material.dart';
import 'package:parallel/app_widgets/headquarter/headquarter_card.dart';

class HeadquartersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 3,
        itemBuilder: (context, index) => HeadquarterCard(
          image:
              'https://images.unsplash.com/photo-1552832230-c0197dd311b5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1096&q=80',
          name: "ELIS",
          city: "Roma",
          workstations: 200,
        ),
      ),
    );
  }
}
