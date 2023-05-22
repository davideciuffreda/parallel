import 'package:flutter/material.dart';

class HeadquarterDetailCard extends StatelessWidget {
  final String description;
  final Icon icon;

  const HeadquarterDetailCard({
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(width: 4),
        Expanded(
          child: Text(
            description,
            softWrap: true,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
