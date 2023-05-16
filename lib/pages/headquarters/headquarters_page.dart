import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/app_widgets/card_label.dart';
import 'package:parallel/app_widgets/headquarter/headquarter_card.dart';
import 'package:parallel/core/models/headquarter.dart';
import 'package:parallel/pages/headquarters/cubit/headquarter_cubit.dart';
import 'package:parallel/routing/router_constants.dart';

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

          final headquarter = (state as HeadquarterLoaded).headquarters;

          return SingleChildScrollView(
            child: Column(
              children: headquarter
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

  Widget _hqCard(Headquarter hq, context) {
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
                    hq.imageUrl,
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
                    onPressed: () {},
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
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
                    hq.name,
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
                        title: hq.city,
                      ),
                      CardLabel(
                        icon: Icon(Icons.computer_sharp),
                        title: hq.workstations.toString(),
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
