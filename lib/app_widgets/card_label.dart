import 'package:flutter/material.dart';

class CardLabel extends StatelessWidget {
  final Icon icon;
  final String title;

  const CardLabel({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        SizedBox(width: 4),
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16
          ),
        ),
      ],
    );
  }
}
