import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/app_widgets/access_log/access_log_card.dart';
import 'package:parallel/pages/access_log/cubit/access_log_cubit.dart';

class AccessLogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AccessLogCubit>(context).getAccessLog();

    return Scaffold(
      body: BlocBuilder<AccessLogCubit, AccessLogState>(
        builder: (context, state) {
          if (!(state is AccessLogLoaded)) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: state.accessLog
                  .map(
                    (access) => AccessLogCard(
                      context: context,
                      access: access,
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
