// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/core/models/headquarter/headquarterCompany.dart';
import 'package:parallel/pages/events/cubit/event_cubit.dart';

class HeadquarterCompanyCard extends StatefulWidget {
  HeadquarterCompany hq;

  HeadquarterCompanyCard({required this.hq, required BuildContext context});

  @override
  State<HeadquarterCompanyCard> createState() => _HeadquarterCompanyCard();
}

class _HeadquarterCompanyCard extends State<HeadquarterCompanyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 12),
      width: double.infinity,
      height: 65,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.hq.city + ' | ' + widget.hq.address,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            BlocBuilder<EventCubit, EventState>(
              builder: (context, state) {
                return FloatingActionButton.small(
                  onPressed: () {
                    BlocProvider.of<EventCubit>(context)
                        .emit(EventHqSelected(widget.hq.id));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Sede scelta: ' +
                              widget.hq.city +
                              ' | ' +
                              widget.hq.address,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.green.shade300,
                      ),
                    );
                  },
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: Icon(
                    Icons.check,
                    color: Colors.blue,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
