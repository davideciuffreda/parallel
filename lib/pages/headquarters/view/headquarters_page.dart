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
