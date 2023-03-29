import 'package:flutter/material.dart';
import 'package:parallel/app_widgets/card_label.dart';
import 'package:parallel/routing/router_constants.dart';

class HeadquarterCard extends StatefulWidget {
  final String image;
  final String name;
  final String city;
  final int workstations;

  const HeadquarterCard({
    required this.name,
    required this.city,
    required this.workstations,
    required this.image,
  });

  @override
  State<HeadquarterCard> createState() => _HeadquarterCardState();
}

class _HeadquarterCardState extends State<HeadquarterCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(headquarterDetailsPageRoute);
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
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    widget.image,
                    width: double.infinity,
                    height: 280,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: FloatingActionButton.small(
                    backgroundColor: Colors.white.withOpacity(0.7),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: isFavorite
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.red.shade300,
                          ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CardLabel(
                        icon: Icon(Icons.share_location_sharp),
                        title: widget.city,
                      ),
                      CardLabel(
                        icon: Icon(Icons.computer_sharp),
                        title: widget.workstations.toString(),
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
