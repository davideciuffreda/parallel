// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';

class HeadquarterDescriptionCard extends StatelessWidget {
  final String description;
  final Icon icon;

  const HeadquarterDescriptionCard({
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
          child: Container(
            height: 80,
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: [
                Text(
                  description,
                  softWrap: true,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
