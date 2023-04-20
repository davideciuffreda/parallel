import 'package:flutter/material.dart';

class BookingCard extends StatefulWidget {
  const BookingCard({super.key});

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  late bool checkOutHour = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade50,
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
              child: Image.asset("assets/images/profile.png"),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nome Cognome",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text("Check in: 8:30"),
                checkOutHour
                    ? Text("Check out: 18:00")
                    : Text("Check out: --:--"),
              ],
            ),
            SizedBox(width: 50),
            Row(
              children: [
                checkOutHour
                    ? Container()
                    : TextButton(
                        onPressed: () {
                          setState(() {
                            checkOutHour = !checkOutHour;
                          });
                        },
                        child: Text(
                          "Check out",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
