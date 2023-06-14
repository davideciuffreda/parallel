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
      width: double.infinity,
      height: 130,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: Image.asset("assests/images/profile.png"),
            ),
            SizedBox(width: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.access.user.firstName +
                      "" +
                      widget.access.user.lastName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.access.user.email,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 5),
                Text("Check in: " + widget.access.accessHour),
                Text(
                  widget.access.leavingHour != ""
                      ? "Check out: " + widget.access.leavingHour
                      : "Check out: --:--",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
