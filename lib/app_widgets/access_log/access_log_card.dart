import 'package:flutter/material.dart';

import 'package:parallel/core/models/access.dart';

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
                ? IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.check_circle_outline_outlined,
                      color: Colors.green,
                      size: 30,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
