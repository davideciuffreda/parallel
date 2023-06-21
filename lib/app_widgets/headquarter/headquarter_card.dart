import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parallel/app_widgets/headquarter/card_label.dart';
import 'package:parallel/core/models/headquarter/headquarter.dart';
import 'package:parallel/pages/headquarters/cubit/headquarter_cubit.dart';
import 'package:parallel/pages/headquarters/view/headquarter_details_page.dart';

class HeadquarterCard extends StatefulWidget {
  Headquarter hq;

  HeadquarterCard({required this.hq, required BuildContext context});

  @override
  State<HeadquarterCard> createState() => _HeadquarterCardState();
}

class _HeadquarterCardState extends State<HeadquarterCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HeadquarterDetailsPage(id: widget.hq.id),
          ),
        );
      },
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
                    widget.hq.company.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CardLabel(
                        icon: Icon(Icons.near_me_outlined),
                        title: widget.hq.city.toUpperCase() +
                            ' | ' +
                            widget.hq.address,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
