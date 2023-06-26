// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/app_widgets/headquarter/headquarter_card.dart';
import 'package:parallel/pages/headquarters/cubit/headquarter_cubit.dart';

class HeadquartersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HeadquarterCubit>(context).getHeadquarters();

    return Scaffold(
      body: BlocBuilder<HeadquarterCubit, HeadquarterState>(
        builder: (context, state) {
          if (!(state is HeadquarterLoaded)) {
            return Center(child: CircularProgressIndicator());
          }

          ///Lista di widget che rappresentano le sedi
          return SingleChildScrollView(
            child: Column(
              children: state.headquarters
                  .map((hq) => HeadquarterCard(
                        context: context,
                        hq: hq,
                      ))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
