// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/core/models/access/access.dart';
import 'package:parallel/pages/access_log/cubit/access_log_cubit.dart';
import 'package:parallel/routing/router_constants.dart';

class AccessLogCard extends StatefulWidget {
  Access access;

  AccessLogCard({required this.access, required BuildContext context});

  @override
  State<AccessLogCard> createState() => _AccessLogCard();
}

class _AccessLogCard extends State<AccessLogCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      height: 130,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: Image.asset("assets/images/profile.png"),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.access.worker.firstName +
                      ' ' +
                      widget.access.worker.lastName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  widget.access.worker.companyName +
                      ' | ' +
                      widget.access.worker.email,
                ),
                SizedBox(height: 4),
                Text(
                  widget.access.workspace.name +
                      ' | ' +
                      widget.access.workplace.name,
                ),
              ],
            ),
            SizedBox(width: 12),
            !widget.access.present
                ? BlocBuilder<AccessLogCubit, AccessLogState>(
                    builder: (context, state) {
                      return BlocListener<AccessLogCubit, AccessLogState>(
                        listener: (context, state) {
                          if (state is UserCheckIn) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Check in'),
                                  content: Text('Presenza registrata'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Chiudi'),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                homePageReceptionistRoute);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else if (state is AccessLogError) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Errore'),
                                  content: Text(state.error),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Chiudi'),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                homePageReceptionistRoute);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: IconButton(
                          onPressed: () {
                            BlocProvider.of<AccessLogCubit>(context)
                                .checkInUser(
                              widget.access.workspace.id,
                              widget.access.workplace.id,
                              widget.access.id,
                            );
                            Navigator.of(context).pushReplacementNamed(
                              homePageReceptionistRoute,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Check-in effettuato!',
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
                          icon: Icon(
                            Icons.check_circle_outline_outlined,
                            color: Colors.green,
                            size: 30,
                          ),
                        ),
                      );
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
