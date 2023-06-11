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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon,
        SizedBox(width: 4),
        Expanded(
          child: Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
